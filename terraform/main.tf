provider "aws" {
  region = var.region
}

# Security Group - Jenkins
resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "jenkins-sg" }
}

# Security Group - K8s
resource "aws_security_group" "k8s_sg" {
  name = "k8s-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "k8s-sg" }
}

# Jenkins Server
resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = { Name = "Jenkins-Server" }
}

# K8s Master
resource "aws_instance" "k8s_master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = { Name = "K8s-Master" }
}

# K8s Worker 1
resource "aws_instance" "k8s_worker1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = { Name = "K8s-Worker-1" }
}

# K8s Worker 2
resource "aws_instance" "k8s_worker2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = { Name = "K8s-Worker-2" }
}

# S3 Bucket for kops state
resource "aws_s3_bucket" "kops_state" {
  bucket        = var.kops_state_bucket
  force_destroy = true
  tags = { Name = "kops-state" }
}
