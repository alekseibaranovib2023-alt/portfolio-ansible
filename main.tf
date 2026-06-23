terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

variable "environment" {
  default = "staging"
}

variable "app_port" {
  default = 8080
}

resource "local_file" "terraform_inventory" {
  content = jsonencode({
    all = {
      hosts = {
        "localhost" = {
          ansible_connection = "local"
          ansible_python_interpreter = "/usr/bin/python3"
          provisioned_by = "terraform"
          environment = var.environment
          app_port = var.app_port
          created_at = timestamp()
        }
      }
    }
  })
  filename = "${path.module}/inventory/tf_inventory.json"
}
