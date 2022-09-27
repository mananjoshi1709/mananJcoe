resource "aws_instance" "webservers" {
	count = "${length(var.subnets_cidr)}" 
     #instance_count = 5
	ami = "${var.webservers_ami}"
	instance_type = "${var.instance_type}"
	security_groups = ["${aws_security_group.webservers.id}"]
      # monitoring             = true
	subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
	user_data = "${file("install_httpd.sh")}"
    tags = {
      Terraform = "true"
      Environment = "dev"
  }
}

