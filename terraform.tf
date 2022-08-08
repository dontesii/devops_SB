provider "aws" {}

resource "aws_instance" "Load_balancer" {
    ami = "ami-090fa75af13c156b4"
    instance_type = "t2.micro"

    tags = {
        Creator = "DmitryC"
    }
}

resource "aws_instance" "DB_server" {
    ami = "ami-090fa75af13c156b4"
    instance_type = "t2.micro"

    tags = {
        Creator = "DmitryC"
    }
}

resource "aws_instance" "APP_server" {
    ami = "ami-090fa75af13c156b4"
    instance_type = "t2.micro"

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