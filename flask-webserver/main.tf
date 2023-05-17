provider "aws" {
    region = "${var.region}"
}

data "template_file" "user_data" {
    template = file("${path.module}/scripts/user_data.sh")
}

data "aws_ami" "ubuntu_ami" { # Grab Official Canonical AMI
    owners = [ "099720109477" ]
    most_recent = true

    filter {
        name = "virtualization-type"
        values = [ "hvm" ]
    }

    filter {
        name = "name"
        values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" ]
    }
}

resource "aws_security_group" "flask_sg" {
    name = "flask_sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_instance" "flask_ec2" {
    ami                         = data.aws_ami.ubuntu_ami.id
    instance_type               = "${var.instance_type}"
    vpc_security_group_ids      = [ aws_security_group.flask_sg.id ]
    user_data                   = base64encode(data.template_file.user_data.rendered)
    user_data_replace_on_change = true # Redeploy if user_data is updated
    associate_public_ip_address = true
    key_name                    = "${var.key_name}"

    lifecycle {
      ignore_changes = [ ami ] # Incase a new ubuntu image is released, we don't want to force replacement
    }

    tags = {
        Name = "flask-webserver"
    }
}
