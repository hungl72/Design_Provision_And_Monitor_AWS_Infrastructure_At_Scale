# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "AKIASUDX4I3XX32SI34M"
  secret_key = "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"
  region = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity-t2" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  subnet_id = "subnet-0ad2b40f2559e88dd"
  count = 4
  tags = {
    Name = "Udacity T2"
  }
}


# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity-m4" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "m4.large"
  subnet_id = "subnet-0ad2b40f2559e88dd"
  count = 2
  tags = {
    Name = "Udacity M4"
  }
}
