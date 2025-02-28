data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_availability_zones" "available" {
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh.tpl")

  vars = {
    docker_image = var.docker_image
    ssh_user     = var.ssh_user
  }
}

