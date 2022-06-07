resource "digitalocean_ssh_key" "DigitalOcean" {
  name       = "DigitalOcean"
  public_key = file(".ssh/DigitalOcean.pub")
}
