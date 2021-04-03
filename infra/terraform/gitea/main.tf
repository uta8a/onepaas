provider "google" {
  credentials = file("./cred.json")
  region      = "us-central1"
  zone        = "us-central1-c"
  project = var.project-name
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "gitea-server" {
  name         = "gitea-server"
  machine_type = "f1-micro"
  zone         = "us-central1-c"
  tags = [ "gitea-port" ]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-focal-v20210223a"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  metadata = {
    ssh-keys = "${var.username}:${file("~/.ssh/gitea-gcp.pub")}"
  }
}

resource "google_compute_firewall" "gitea-port" {
  name    = "gitea-port"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitea-port"]
}

output "ip" {
  value = google_compute_instance.gitea-server.network_interface.0.access_config.0.nat_ip
}
