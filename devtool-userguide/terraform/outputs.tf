output "vpc_id" {
  value = ncloud_vpc.main_vpc.id
}

output "main_key_private_key" {
  value     = ncloud_login_key.loginkey.private_key
  sensitive = true
}

