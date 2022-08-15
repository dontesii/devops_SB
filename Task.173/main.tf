provider "aws" {}

resource "aws_instance" "Load_balancer" {
    ami = "ami-0c956e207f9d113d5"
    instance_type = "t2.micro"
    key_name = "MyKeyPair1"
    security_groups = [ aws_security_group.lb_rules.name ]

    tags = {
        Creator = "DmitryC"
    }
}

resource "aws_instance" "DB_server" {
    ami = "ami-065deacbcaac64cf2"
    instance_type = "t2.micro"
    key_name = "MyKeyPair1"
    security_groups = [ aws_security_group.db_rules.name ]

    tags = {
        Creator = "DmitryC"
    }
}

resource "aws_instance" "APP_server" {
    ami = "ami-065deacbcaac64cf2"
    instance_type = "t2.micro"
    key_name = "MyKeyPair1"
    security_groups = [ aws_security_group.app_rules.name ]

    tags = {
        Creator = "DmitryC"
    }
}

resource "aws_security_group" "lb_rules" {
  name        = "lb_rules"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Creator = "DmitryC"
  }
}

resource "aws_security_group" "db_rules" {
  name        = "db_rules"

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Creator = "DmitryC"
  }
}

resource "aws_security_group" "app_rules" {
  name        = "app_rules"

  ingress {
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Creator = "DmitryC"
  }
}

resource "aws_route53_record" "lb" {
  zone_id = "Z01242703EIVQQ2V4GNJ8"
  name    = "lb.DmitryC.lab.vandergizer.com"
  type    = "A"
  ttl     = 300
  records = [ aws_instance.Load_balancer.public_ip  ]
}

resource "aws_route53_record" "db1" {
  zone_id = "Z01242703EIVQQ2V4GNJ8"
  name    = "db1.DmitryC.lab.vandergizer.com"
  type    = "A"
  ttl     = 300
  records = [ aws_instance.DB_server.public_ip  ]
}

resource "aws_route53_record" "app_django_1" {
  zone_id = "Z01242703EIVQQ2V4GNJ8"
  name    = "app_django_1.DmitryC.lab.vandergizer.com"
  type    = "A"
  ttl     = 300
  records = [ aws_instance.APP_server.public_ip  ]
}
