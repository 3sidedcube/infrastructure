resource "aws_wafv2_web_acl" "main" {
  name  = "${var.project_name}-WAF"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project_name}-WAF"
    sampled_requests_enabled   = true
  }
}