//module "web_alb" {
//  source = "terraform-aws-modules/alb/aws"
//
//  name            = "${var.name}-web-alb"
//  security_groups = [var.web_sg]
//  subnets         = var.public_subnets
//  tags            = var.tags
//  vpc_id          = var.vpc_id
//
//  http_tcp_listeners = [
//    {
//      port               = 80
//      protocol           = "HTTP"
//      target_group_index = 0
//    }
//  ]
//
//  target_groups = [
//    {
//      name_prefix      = "pref-"
//      backend_protocol = "HTTP"
//      backend_port     = 8080
//      target_type      = "instance"
//    }
//  ]

resource "aws_lb" "web_alb" {
  name               = "${var.name}-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_sg]
  subnets            = var.public_subnets
  ip_address_type    = "ipv4"

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "test" {
  count            = 2
  target_group_arn = aws_lb_target_group.client.arn
  target_id        = var.instance_id[count.index]
  port             = 8080
}

resource "aws_lb_target_group" "client" {
  name        = "${var.name}-alb-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  depends_on  = [aws_lb.web_alb]
}

resource "aws_lb_listener" "client_fwd" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.client.arn
  }
}
