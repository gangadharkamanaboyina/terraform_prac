data "aws_ami" "amazon" {

        most_recent = true
        owners = ["137112412989"]
        tags = {
            Name   = "Amazon-ami"
            Tested = "true"
        }

        filter {
           name = "virtualization-type" 
           values = ["hvm"]
        }

        filter {
            name   = "name"
            values = ["al2023-ami-2023.9.20251027.0-kernel-6.1-x86_64"]
        }
        
}

data "aws_instances" "running" {

  instance_state_names = ["running"]
}

data "aws_instance" "details" {
  for_each = toset(data.aws_instances.running.ids)
  instance_id = each.value
}

data "aws_route53_zone" "zone" {
  name         = var.domain_name
}