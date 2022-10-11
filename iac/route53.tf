resource "aws_route53_zone" "main" {
  name = var.dns_tld
}

resource "aws_route53_record" "demo-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.dns_subdomain
  type    = "A"
  
  alias {
    name                   = module.alb.aws_alb_dns_name
    zone_id                = module.alb.aws_alb_zone_id
    evaluate_target_health = true
  }
}