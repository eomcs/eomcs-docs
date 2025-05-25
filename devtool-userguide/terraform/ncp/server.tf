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
    ip_block    = var.my_ip_block
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

# 생성할 서버 이미지 찾기=
data "ncloud_server_image_numbers" "kvm_image" {
  server_image_name = "ubuntu-24.04-base"
  filter {
    name   = "hypervisor_type"
    values = ["KVM"]
  }
}

# 생성할 서버 스펙 찾기
data "ncloud_server_specs" "kvm_spec" {
  filter {
    name   = "server_spec_code"
    values = ["c2-g3"]
  }
}

# 서버 생성 후 실행할 초기화 스크립트 정의
resource "ncloud_init_script" "init_script" {
  name = "init-script"

  content = <<-EOF
    #!/bin/bash
    useradd -m -s /bin/bash bitcamp
    echo "bitcamp:bitcamp123!@#" | chpasswd
    echo "bitcamp ALL=(ALL) ALL" >> /etc/sudoers.d/bitcamp
    chmod 440 /etc/sudoers.d/bitcamp
  EOF
}

# 네트워크 인터페이스 생성 및 ACG 연결
resource "ncloud_network_interface" "main_nic" {
  name                  = "main-server-nic"
  description           = "Main Server NIC"
  subnet_no             = ncloud_subnet.main_web_subnet.id
  access_control_groups = [ncloud_access_control_group.main_web_acg.id]
}

# 서버 생성
resource "ncloud_server" "main_server" {
  name      = "main-server"
  subnet_no = ncloud_subnet.main_web_subnet.id
  network_interface {
    network_interface_no = ncloud_network_interface.main_nic.id
    order                = 0
  }
  server_image_number           = data.ncloud_server_image_numbers.kvm_image.image_number_list.0.server_image_number
  server_spec_code              = data.ncloud_server_specs.kvm_spec.server_spec_list.0.server_spec_code
  fee_system_type_code          = "MTRAT"
  is_protect_server_termination = false
  init_script_no                = ncloud_init_script.init_script.id
  login_key_name                = ncloud_login_key.loginkey.key_name
}

# 서버에 public IP 할당
resource "ncloud_public_ip" "main_server_public_ip" {
  server_instance_no = ncloud_server.main_server.id
}
