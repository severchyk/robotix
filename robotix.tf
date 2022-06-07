resource "digitalocean_droplet" "robotix" {
  image    = "docker-20-04"
  name     = "robotix"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.DigitalOcean.fingerprint]

  connection {
    host        = self.ipv4_address
    type        = "ssh"
    private_key = file(".ssh/DigitalOcean")
    timeout     = "30m"
    user        = "root"
  }

  provisioner "file" {
    source      = "docker/"
    destination = "/root"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 755 config.sh",
      "./config.sh"
    ]
    on_failure = continue
  }
}
