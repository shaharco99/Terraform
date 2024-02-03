output "nlb_arn" {
  value = aws_lb.nlb.arn
}

output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}

output "s3_bucket_url" {
  value = "https://s3.${var.region}.amazonaws.com/${var.s3_bucket_name}"
}
