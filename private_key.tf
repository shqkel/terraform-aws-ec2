resource "tls_private_key" "hello_ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "hello_ec2_keypair" {
  key_name   = "hello_ec2_key"
  public_key = tls_private_key.hello_ec2_key.public_key_openssh
}

resource "local_file" "hello_ec2_downloads_key" {
  filename = "hello_ec2_key.pem"
  content  = tls_private_key.hello_ec2_key.private_key_pem
}
