provider "aws" {
region = "us-east-1"

}

resource "aws_instance" "web-tera" {
  ami           = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name = "india"
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y 
              sudo yum -y install httpd
               echo "welcome india" >> /var/www/html/index.html
               systemctl start httpd
        EOF
              
  tags = {
    Name = "web-tera-ec2"
  }

resource "aws_security_group" "instance" {
  name        = "web-tera-aws_security_group"
# inbound httpd from anywhere
ingress {
  from_port = "${var.web_server_port}"
  to_port = "$var.web_server_port"
  protocol ="tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port = 22
  to_port   = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress { 
  from_port = 0
  to_port   = 0
  protocol = ".1"
  cidr_blocks = ["0.0.0.0/0"]
}

}

}






#  description = "Allow TLS inbound traffic"
# data "aws_vpc" "selected" {
# filter {
#  name = "tag:Name"
#  values = [" main_india"]
#}   

#  vpc_id      = "${aws_vpc.main.id}"

#  ingress {
    # TLS (change to whatever ports you need)
 #   from_port   = 443
 #   to_port     = 443
 #   protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  #  cidr_blocks = # add a CIDR block here
  #}

 # egress {
  #  from_port       = 0
#    to_port         = 0
#    protocol        = "-1"
#    cidr_blocks     = ["0.0.0.0/0"]
#    prefix_list_ids = ["pl-12c4e678"]
#  }
#}




#data "aws_caller_identity" "current" {}
#output "account_id"{
#value = "${data_aws_caller_identity.current.account_id}"

#}

#data "aws_vpc" "selected" {
#filter {
# name = "tag:Name"
# values = ["main"]

#}
#  }

#data "aws_security_group" "sg" {
#filter {
# name = "group-name"
# values = ["my"]

#}
 # }


#data "aws_security_group" "sg" {
#filter {
# name = "vpc-id"
# values = ["my"]


