resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}-key"
  public_key = file("~/.ssh/fork.pub")
}

resource "aws_instance" "bastion" {
  count                  = 2
  ami                    = var.image_id
  instance_type          = var.app_instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = var.public_subnets[count.index]
  vpc_security_group_ids = [var.web_sg]

  tags = {
    Name = "${var.name}-bastion-${count.index + 1}"
  }
}

resource "aws_instance" "app" {
  count                  = 2
  ami                    = var.image_id
  instance_type          = var.app_instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = var.private_subnets[count.index]
  vpc_security_group_ids = [var.app_sg]

  user_data = <<-EOF
              #! /bin/bash
              sudo yum install -y git
              curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
              export NVM_DIR="$HOME/.nvm"
              [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
              [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
              nvm install 14.15.0
              # setup sample app client
              git clone https://github.com/IBM/node-hello-world
              cd node-hello-world
              npm install
              npm install -g pm2
              pm2 start app.js
              EOF

  tags = {
    Name = "${var.name}-app-${count.index + 1}"
  }
}