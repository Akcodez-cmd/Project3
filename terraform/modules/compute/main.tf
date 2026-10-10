
resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}

resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
      <head><title>Project 3</title></head>
      <body>
        <h1>Project 3 - AWS Infrastructure Automation</h1>
        <p>Deployed using Terraform and GitHub Actions.</p>
      </body>
    </html>
    HTML
    systemctl enable --now nginx
  EOF

  tags = {
    Name = "${var.project_name}-web"
  }
}

resource "aws_eip" "web" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-web-eip"
  }
}

resource "aws_eip_association" "web" {
  allocation_id = aws_eip.web.id
  instance_id   = aws_instance.web.id
}
