provider "aws" {
  region  = "ap-northeast-2"
  profile = var.aws_profile
}

resource "aws_instance" "hello_ec2" {
  ami                         = "ami-0f0646a5f59758444"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.hello_ec2_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.hello_ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "hello_ec2"
  }
  # user_data 리소스 최초 생성시 1회 실행되는 script
  user_data = <<-EOF
    #!/bin/bash
    echo Helloworld!
  EOF

  # Provisioner : resource를 생성후/제거전에 실행되는 shell script
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("${local_file.hello_ec2_downloads_key.filename}") # 생성될 파일명은 변수로 작성해야한다.
  }

  # 1. local-exec provisioner
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> hello_ec2_public_ip.txt" # local에 파일 저장 - public_ip를 조회하여 hello_ec2_public_ip.txt" 파일에 저장한다.
  }
  # 2. remote-exec provisioner
  provisioner "file" {
    source      = "hello_ec2_init.sh" # 로컬 파일
    destination = "/tmp/script.sh"    # 서버에 복사될 장소
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }

}
