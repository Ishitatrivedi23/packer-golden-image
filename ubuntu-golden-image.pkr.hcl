 GNU nano 7.2                                 ubuntu-golden-image.pkr.hcl
# Packer Template for Basic Ubuntu AMI

variable "aws_region" {
  default = "eu-north-1"
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-basic-tools-ami-{{timestamp}}"
  instance_type = "t3.large"
  region        = var.aws_region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"] # Canonical
    most_recent = true
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y curl htop unzip"
    ]
  }
}

