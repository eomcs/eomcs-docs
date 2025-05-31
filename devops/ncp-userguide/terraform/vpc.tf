# VPC 생성
resource "ncloud_vpc" "main_vpc" {
  name            = "main-vpc"
  ipv4_cidr_block = var.vpc_cidr
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
    ip_block    = var.my_ip_block
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
  subnet         = cidrsubnet(var.vpc_cidr, 8, 1)
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.main_web_nacl.id
  subnet_type    = "PUBLIC"
  usage_type     = "GEN"
  name           = "main-web-subnet"
}

resource "ncloud_subnet" "main_public_lb_subnet" {
  vpc_no         = ncloud_vpc.main_vpc.id
  subnet         = cidrsubnet(var.vpc_cidr, 8, 255)
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.main_public_lb_nacl.id
  subnet_type    = "PUBLIC"
  usage_type     = "LOADB"
  name           = "main-public-lb-subnet"
}

resource "ncloud_subnet" "main_private_lb_subnet" {
  vpc_no         = ncloud_vpc.main_vpc.id
  subnet         = cidrsubnet(var.vpc_cidr, 8, 6)
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.main_private_lb_nacl.id
  subnet_type    = "PRIVATE"
  usage_type     = "LOADB"
  name           = "main-private-lb-subnet"
}
