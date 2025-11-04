resource "aws_instance" "main" {
    count = length (var.instances)
    ami = data.aws_ami.amazon.id
    instance_type = var.env != "prod" ? "t3.large" : var.instance_type
    key_name = aws_key_pair.terraformkey.key_name
    vpc_security_group_ids = [aws_security_group.allow_all_prac.id]
    depends_on = [aws_key_pair.terraformkey]
    tags = merge(
    var.tags, {
     Name = var.instances[count.index]
     })
}

resource "aws_key_pair" "terraformkey" {
  key_name   = "terraform"
  public_key = file("C:/DevOps/keys/terraform.pub")
}

resource "aws_security_group" "allow_all_prac" {
  name = "allow_all_prac"
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = var.tags
}

output "running" {
  value = {for k,i in data.aws_instance.details : k => i.tags["Name"]}

}
