output "web-server-public-ip" {
  description = "Public IPv4 for Web Server"
  value       = aws_instance.my-web-server.public_ip
}

output "all-available-azs-names" {
  description = "Available Availability Zones"
  value       = data.aws_availability_zones.azs.names
}

output "all-available-azs-ids" {
  description = "Available Availability Zones"
  value       = data.aws_availability_zones.azs.zone_ids
}

output "alb-dns-name" {
  description = "DNS name for ALB"
  value       = aws_lb.web-server-alb.dns_name
}
