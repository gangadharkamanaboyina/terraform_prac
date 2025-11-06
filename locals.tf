locals {
    count = length (var.instances)
    common_name = "${var.project}-${terraform.workspace}"
    ami_id = data.aws_ami.amazon.id
    instance_type = lookup(var.instance_type, terraform.workspace)
    ports = ["22", "80"]
    common_name_suffix = [for name in var.instances : 
    merge(
     var.common_tags, {
     Name = "${local.common_name}-${name}"
     })]
}