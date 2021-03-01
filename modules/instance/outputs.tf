output "lb_url" {
    value = aws_alb.web_server_alb.dns_name
}
