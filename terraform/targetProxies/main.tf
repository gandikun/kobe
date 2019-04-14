terraform {
  backend "gcs" {
    bucket = "g-zero-terraform"
    prefix = "g-target-http-proxy"
    credentials = "g-zero-3009d398406e.json"
  }
}

provider "google" {
  credentials = "${file("g-zero-3009d398406e.json")}"
  project     = "g-zero"
  region      = "asia-southeast1"
}

resource "google_compute_target_http_proxy" "g-target-http-proxy" {
  name        = "zero-target-http-proxy"
  url_map     = "${google_compute_url_map.g-url-map.self_link}"
}

resource "google_compute_url_map" "g-url-map" {
  name        = "zero-url-map"
  default_service = "${google_compute_backend_service.g-backend-01.self_link}"

  host_rule {
    hosts        = ["kobe.gandi.id"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.g-backend-01.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.g-backend-01.self_link}"
    }
  }
}

resource "google_compute_backend_service" "g-backend-01" {
  name                             = "zero-backend-01"
  port_name                        = "http"
  protocol                         = "TCP"
  timeout_sec                      = 4
  connection_draining_timeout_sec  = 120
  health_checks                    = ["${google_compute_http_health_check.g-healthcheck-01.self_link}"]
  backend {
    group = "https://www.googleapis.com/compute/v1/projects/g-zero/zones/asia-southeast1-a/instanceGroups/k8s-ig--d236e50573ffddaf"
    balancing_mode = "CONNECTION"
    max_connections = 1000
  }
}

resource "google_compute_http_health_check" "g-healthcheck-01" {
  name               = "zero-healthcheck-01"
  request_path       = "/"
  check_interval_sec = 4
  timeout_sec        = 2
  port               = 8484
}
