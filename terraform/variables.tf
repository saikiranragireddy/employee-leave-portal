variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  default = "c7i-flex.large"
}

variable "kops_state_bucket" {
  default = "saikiran-kops-state-2026"
}
