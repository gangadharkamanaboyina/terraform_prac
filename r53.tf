resource "aws_route53_record" "main" {
  count = length (var.instances)
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.instances[count.index] == "frontend" ? var.domain_name : "${var.instances[count.index]}.${var.domain_name}"
  type    = "A"
  ttl     = 2
  records = var.instances[count.index] == "frontend" ? [aws_instance.main[count.index].public_ip] : [aws_instance.main[count.index].private_ip]
  allow_overwrite = true
}