packer {
  required_plugins {
    docker = { version = ">= 1.0.0", source = "github.com/hashicorp/docker" }
  }
}

source "docker" "nginx-base" {
  image  = "ubuntu:22.04"
  commit = true
}

build {
  name = "cookie-factory-image"
  sources = ["source.docker.nginx-base"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y nginx",
      "echo '<h1>Baked by Packer!</h1>' > /var/www/html/index.html"
    ]
  }
}
