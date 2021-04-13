# Find the AMI to use
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create the server
resource "aws_instance" "server1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = var.key_name

  tags = {
    Name                     = "server1"
    ODINAPPID_ENV_ROLE_STACK = "442_dev_test_test"
    Team                     = "GCS-Linux"
    odin_app_id              = "442"
    created_by               = var.key_name
  }
}

output "instance_ips" {
  value = aws_instance.server1.*.public_ip
}
