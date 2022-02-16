resource "tls_private_key" "default" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

locals {
  public_key = tls_private_key.default.public_key_pem
  private_key = tls_private_key.default.private_key_pem
}

output "public_key" {
  value = local.public_key
}

output "private_key" {
  value = local.private_key
  sensitive = true
}

#resource "local_file" "foo" {
#  content     = local.private_key
#  filename = "${path.module}/foo.bar"
#}