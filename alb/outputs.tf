//output "app_dns_name" {
//  value = module.app_alb.this_lb_dns_name
//}

output "web_dns_name" {
  value = aws_lb.web_alb.dns_name
}