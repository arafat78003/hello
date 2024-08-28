resource "aws_lb" "mylb" {
    name = "myalb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.sg_id]
    subnets = var.alb_subnet

  
}
#listner
resource "aws_lb_listener" "frontend" {
    load_balancer_arn = aws_lb.mylb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.mytarget.arn
    }
  
}



#target group

resource "aws_lb_target_group" "mytarget" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.myvpc
}




#target group attachment
resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.mytarget.arn
  count = length(var.instances)
  target_id        = var.instances[count.index]
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.mytarget.arn
  target_id        = var.private_instance
  port             = 80
}

