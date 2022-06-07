resource "digitalocean_project" "diploma" {
  name        = "Diploma"
  description = "Organization of a virtual container system for remote work"
  resources   = [digitalocean_droplet.robotix.urn]
}
