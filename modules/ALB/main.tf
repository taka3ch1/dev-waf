##############################################
# 目的:
# 作成日: 2023/3/19
# Version: 0.1
# 作成者: taka3chi
##############################################

resource "aws_lb" "alb" {
  name                       = ""
  load_balancer_type         = ""
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = true
  subnets = {

  }
  # アクセスのログの保存先を指定。
  # 指定先 バケット
  access_logs {

  }
  # ALBに適用されるセキュリティグループを指定
  security_groups = {

  }
  tags = {

  }
}

resource "alb_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = ""
  protocol          = ""

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plan"
      message_body = "これはHTTPです"
      status_code  = "200"
    }
  }

}