terraform {
  backend "gcs" {
    bucket = "g-zero-terraform"
    prefix = "g-network"
    credentials = "g-zero-3009d398406e.json"
  }
}

provider "google" {
  credentials = "${file("g-zero-3009d398406e.json")}"
  project     = "g-zero"
  region      = "asia-southeast1"
}

resource "google_compute_network" "g-network" {
  name                    = "g-one"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "g-subnetworki-gce" {
  name          = "one-gce"
  network       = "${google_compute_network.g-network.self_link}"
  ip_cidr_range = "10.0.0.0/22"
  region        = "asia-southeast1"
}

resource "google_compute_subnetwork" "g-subnetworki-gke" {
  name          = "one-gke"
  network       = "${google_compute_network.g-network.self_link}"
  ip_cidr_range = "10.0.4.0/22"
  region        = "asia-southeast1"
  secondary_ip_range {
      range_name    = "one-gke-0"
      ip_cidr_range = "172.16.0.0/15"
  }
  secondary_ip_range {
      range_name    = "one-gke-1"
      ip_cidr_range = "172.18.0.0/15"
  }
}

resource "google_compute_router" "g-router" {
  name    = "one-router"
  region  = "asia-southeast1"
  network = "${google_compute_network.g-network.self_link}"
}

resource "google_compute_router_nat" "g-nat" {
  name                               = "one-nat"
  router                             = "${google_compute_router.g-router.name}"
  region                             = "asia-southeast1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
