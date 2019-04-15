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

resource "null_resource" "create_port_app" {
  provisioner "local-exec" {
    command = "gcloud compute instance-groups set-named-ports ${var.k8s_instance_group_name} --named-ports=port${var.zero_app_port}:${var.zero_app_port} --zone asia-southeast1-a"
  }
  provisioner "local-exec" {
    command = "gcloud compute instance-groups set-named-ports ${var.k8s_instance_group_name} --named-ports=port${var.zero_app_port}:${var.zero_app_port} --zone asia-southeast1-b"
  }
  provisioner "local-exec" {
    command = "gcloud compute instance-groups set-named-ports ${var.k8s_instance_group_name} --named-ports=port${var.zero_app_port}:${var.zero_app_port} --zone asia-southeast1-c"
  }
}

resource "google_compute_global_forwarding_rule" "g-forwarding-rule" {
  name       = "zero-forwarding-rule"
  target     = "${google_compute_target_http_proxy.g-target-http-proxy.self_link}"
  port_range = "80"
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
      paths   = ["/service01"]
      service = "${google_compute_backend_service.g-backend-01.self_link}"
    }
  }
}

resource "google_compute_backend_service" "g-backend-01" {
  name                             = "zero-backend-01"
  port_name                        = "port31233"
  protocol                         = "HTTP"
  timeout_sec                      = 4
  connection_draining_timeout_sec  = 120
  health_checks                    = ["${google_compute_http_health_check.g-healthcheck-01.self_link}"]
  backend {
    group = "https://www.googleapis.com/compute/v1/projects/g-zero/zones/asia-southeast1-a/instanceGroups/k8s-ig--b1d0437c6f1da8fe"
    balancing_mode = "RATE"
    max_rate_per_instance = 10
  }
  backend {
    group = "https://www.googleapis.com/compute/v1/projects/g-zero/zones/asia-southeast1-b/instanceGroups/k8s-ig--b1d0437c6f1da8fe"
    balancing_mode = "RATE"
    max_rate_per_instance = 10
  }
  backend {
    group = "https://www.googleapis.com/compute/v1/projects/g-zero/zones/asia-southeast1-c/instanceGroups/k8s-ig--b1d0437c6f1da8fe"
    balancing_mode = "RATE"
    max_rate_per_instance = 10
  }
}

resource "google_compute_http_health_check" "g-healthcheck-01" {
  name               = "zero-healthcheck-01"
  request_path       = "/"
  check_interval_sec = 4
  timeout_sec        = 2
  port               = 31233
}
