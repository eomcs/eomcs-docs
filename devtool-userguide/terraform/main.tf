terraform {
  required_providers {
    ncloud = {
      source  = "NaverCloudPlatform/ncloud"
      version = "3.3.1"
    }
  }
  required_version = ">= 0.13"
}

provider "ncloud" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = var.region
  site        = var.site
  support_vpc = var.support_vpc
}

# VPC 생성
resource "ncloud_vpc" "main_vpc" {
  name            = "main-vpc"
  ipv4_cidr_block = "10.0.0.0/16"
}

# Network Web ACL 생성
resource "ncloud_network_acl" "main_web_nacl" {
  vpc_no      = ncloud_vpc.main_vpc.id
  name        = "main-web-acl"
  description = "Web ACL"
}

resource "ncloud_network_acl_rule" "main_web_nacl_rule" {
  network_acl_no = ncloud_network_acl.main_web_nacl.id

  inbound {
    priority    = 15
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "10.0.0.0/16"
    port_range  = "1-65535"
  }

  inbound {
    priority    = 20
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "220.78.43.230/32"
    port_range  = "1-65535"
  }

  inbound {
    priority    = 199
    protocol    = "TCP"
    rule_action = "DROP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
  }

  outbound {
    priority    = 0
    protocol    = "ICMP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
  }

  outbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }

  outbound {
    priority    = 20
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }
}

# Network Public Load Balancer ACL 생성

resource "ncloud_network_acl" "main_public_lb_nacl" {
  vpc_no      = ncloud_vpc.main_vpc.id
  name        = "main-public-lb-acl"
  description = "Public Load Balancer ACL"
}

resource "ncloud_network_acl_rule" "main_public_lb_nacl_rule" {
  network_acl_no = ncloud_network_acl.main_public_lb_nacl.id

  inbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }

  outbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }

}

# Network Private Load Balancer ACL 생성

resource "ncloud_network_acl" "main_private_lb_nacl" {
  vpc_no      = ncloud_vpc.main_vpc.id
  name        = "main-private-lb-acl"
  description = "Private Load Balancer ACL"
}

resource "ncloud_network_acl_rule" "main_private_lb_nacl_rule" {
  network_acl_no = ncloud_network_acl.main_private_lb_nacl.id

  inbound {
    priority    = 0
    protocol    = "ICMP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
  }

  inbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "10.0.0.0/16"
    port_range  = "1-65535"
  }

  inbound {
    priority    = 20
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "10.0.0.0/16"
    port_range  = "1-65535"
  }

  outbound {
    priority    = 0
    protocol    = "ICMP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
  }

  outbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }

  outbound {
    priority    = 20
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }
}


# Subnet 생성
resource "ncloud_subnet" "main_web_subnet" {
  vpc_no         = ncloud_vpc.main_vpc.id
  subnet         = "10.0.1.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.main_web_nacl.id
  subnet_type    = "PUBLIC"
  usage_type     = "GEN"
  name           = "main-web-subnet"
}

resource "ncloud_subnet" "main_public_lb_subnet" {
  vpc_no         = ncloud_vpc.main_vpc.id
  subnet         = "10.0.255.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.main_public_lb_nacl.id
  subnet_type    = "PUBLIC"
  usage_type     = "LOADB"
  name           = "main-public-lb-subnet"
}

resource "ncloud_subnet" "main_private_lb_subnet" {
  vpc_no         = ncloud_vpc.main_vpc.id
  subnet         = "10.0.6.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.main_private_lb_nacl.id
  subnet_type    = "PRIVATE"
  usage_type     = "LOADB"
  name           = "main-private-lb-subnet"
}

# ACG 생성
resource "ncloud_access_control_group" "main_web_acg" {
  vpc_no      = ncloud_vpc.main_vpc.id
  name        = "main-web-acg"
  description = "Allow SSH, WEB"
}

resource "ncloud_access_control_group_rule" "main_web_acg_rule" {
  access_control_group_no = ncloud_access_control_group.main_web_acg.id

  inbound {
    protocol = "ICMP"
    ip_block = "0.0.0.0/0"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "220.78.43.230/32"
    port_range  = "22"
    description = "Allow SSH"
  }

  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "Allow all outbound"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "Allow all outbound"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "Allow all outbound"
  }
}

# Login Key 생성
# - 생성된 키를 main-key.pem 파일로 저장
#     terraform output -raw main_key_private_key > main-key.pem
#     chmod 400 main-key.pem
resource "ncloud_login_key" "loginkey" {
  key_name = var.login_key_name
}

# 서버 생성
data "ncloud_server_image_numbers" "kvm-image" {
  server_image_name = "ubuntu-24.04-base"
  filter {
    name   = "hypervisor_type"
    values = ["KVM"]
  }
}

data "ncloud_server_specs" "kvm-spec" {
  filter {
    name   = "server_spec_code"
    values = ["c2-g3"]
  }
}


# 서버 생성
resource "ncloud_server" "main_server" {
  subnet_no                     = ncloud_subnet.main_web_subnet.id
  name                          = "main-server"
  server_image_number           = data.ncloud_server_image_numbers.kvm-image.image_number_list.0.server_image_number
  server_spec_code              = data.ncloud_server_specs.kvm-spec.server_spec_list.0.server_spec_code
  fee_system_type_code          = "MTRAT"
  is_protect_server_termination = false
  init_script_no                = null
  login_key_name                = ncloud_login_key.loginkey.key_name
}

# 서버에 public IP 할당
resource "ncloud_public_ip" "main_server_public_ip" {
  server_instance_no = ncloud_server.main_server.id
}

# Container Registry 용 Object Storage 버킷 생성
resource "ncloud_objectstorage_bucket" "docker_image_bitcamp_teacher01" {
  bucket_name = "docker-image-bitcamp-teacher01"
}

# SourceCommit 용 Object Storage 버킷 생성
resource "ncloud_objectstorage_bucket" "source_commit_bitcamp_teacher01" {
  bucket_name = "source-commit-bitcamp-teacher01"
}

# Kubernetes Cluster 생성
data "ncloud_nks_versions" "version" {
  hypervisor_code = "KVM"
  filter {
    name   = "value"
    values = ["1.32.3"]
    regex  = true
  }
}

resource "ncloud_nks_cluster" "cluster" {
  name                 = "k8s-20250521"
  hypervisor_code      = "KVM"
  cluster_type         = "SVR.VNKS.STAND.C002.M008.G003"
  k8s_version          = data.ncloud_nks_versions.version.versions.0.value
  kube_network_plugin  = "cilium"
  vpc_no               = ncloud_vpc.main_vpc.id
  zone                 = "KR-2"
  public_network       = true
  subnet_no_list       = [ncloud_subnet.main_web_subnet.id]
  lb_private_subnet_no = ncloud_subnet.main_private_lb_subnet.id
  lb_public_subnet_no  = ncloud_subnet.main_public_lb_subnet.id
  log {
    audit = true
  }
  login_key_name = ncloud_login_key.loginkey.key_name
}

data "ncloud_nks_server_images" "image" {
  hypervisor_code = "KVM"
  filter {
    name   = "label"
    values = ["ubuntu-22.04"]
    regex  = true
  }
}

data "ncloud_nks_server_products" "product" {
  software_code = data.ncloud_nks_server_images.image.images[0].value
  zone          = "KR-2"

  filter {
    name   = "product_type"
    values = ["STAND"]
  }

  filter {
    name   = "cpu_count"
    values = ["2"]
  }

  filter {
    name   = "memory_size"
    values = ["8GB"]
  }
}

resource "ncloud_nks_node_pool" "default_pool" {
  cluster_uuid     = ncloud_nks_cluster.cluster.uuid
  node_pool_name   = "default-pool"
  node_count       = 1
  software_code    = data.ncloud_nks_server_images.image.images[0].value
  server_spec_code = data.ncloud_nks_server_products.product.products.0.value
  storage_size     = 100
  autoscale {
    enabled = false
    min     = 2
    max     = 2
  }
}

