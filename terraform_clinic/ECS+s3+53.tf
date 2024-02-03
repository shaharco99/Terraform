resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_route53_zone" "zone" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.route53_record_name
  type    = "A"
  alias {
    name                   = var.load_balancer_arn
    zone_id                = aws_lb.nlb.zone_id
    evaluate_target_health = true
  }
}
