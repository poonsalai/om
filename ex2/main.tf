# AWS
# Here we have an instance in stopped state on aws and getting the instance_type and state of it in output.tf
data "aws_instance" "ex2" {
  filter {
    name   = "tag:Name"
    values = ["ex2aws"]
  }
}

/*
# GCP
# Here we have an instance in stopped state on gcp and getting the machine_type and description of it in output.tf
data "google_compute_instance" "ex2" {
  name = "ex2gcp"
}
*/