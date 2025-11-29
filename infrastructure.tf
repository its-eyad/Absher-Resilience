# Terraform: Auto-Scaling Group for Absher API
resource "aws_autoscaling_group" "absher_api_asg" {
  name                = "absher-resilient-api"
  max_size            = 100 # Scale up to 100 servers during Hajj/Eid
  min_size            = 10  # Minimum baseline
  desired_capacity    = 20
  
  # Health Check: If a server fails, kill it and replace it immediately
  health_check_type   = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Environment"
    value               = "Production-Critical"
    propagate_at_launch = true
  }
}

# Circuit Breaker Configuration (simulated for config)
variable "circuit_breaker_threshold" {
  description = "Error rate % to trigger circuit breaker"
  default     = 15
}
