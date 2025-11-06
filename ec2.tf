resource "aws_instance" "main" {
    count = length (var.instances)
    ami = local.ami_id
    instance_type = local.instance_type 
    key_name = aws_key_pair.terraformkey.key_name
    vpc_security_group_ids = [aws_security_group.allow_all_prac.id]
    depends_on = [aws_key_pair.terraformkey]
    tags = local.common_name_suffix[count.index]

  #   provisioner "local-exec" {
  #   command = "echo ${self.public_ip} > inventory.ini"
  #   }
  #     connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("C:/DevOps/keys/terraform")
  #     host        = self.public_ip
  # }

  #   provisioner "remote-exec" {
  #     inline = [
  #       "sudo dnf install nginx -y",
  #       "sudo systemctl enable nginx",
  #       "sudo systemctl start nginx"
  #     ]
  #     }

}

resource "aws_key_pair" "terraformkey" {
  key_name   = "terraform-${terraform.workspace}"
  public_key = file("C:/DevOps/keys/terraform.pub")
}

resource "aws_security_group" "allow_all_prac" {
  dynamic ingress {
    for_each = toset(local.ports)
    content{
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
    
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge( 
      var.common_tags,
    { Name = "${local.common_name}-allow-all-prac" },
    {Environment = terraform.workspace} )
  }
