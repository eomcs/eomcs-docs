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

# Node Pool 생성
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

