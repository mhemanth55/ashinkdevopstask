provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "ashinkdevopstask-terraform"
    key    = "terraform/my/key"
    region = "ap-south-1"
  }
}

## EC2 resource

data "template_file" "nginx" {
  template = file("${path.module}/init.tpl")
}

resource "aws_instance" "nginx_instance" {
  ami = var.instance_ami
  instance_type = var.instance_type
  security_groups = [var.security_group]
  subnet_id = var.subnet
  associate_public_ip_address = true
  user_data = data.template_file.nginx.rendered
  key_name = "DevOps-Key"
}
