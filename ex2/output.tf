
# outputs for AWS instance
output "aws-ec2-type" {
    value = "${data.aws_instance.ex2.instance_type}"
}
output "aws-ec2-state" {
    value = "${data.aws_instance.ex2.instance_state}"
}

/* below outputs can be used while fetching details for gcp instance

# outputs for GCP instance
output "gcp-vm-type" {
    value = "${data.google_compute_instance.ex2.machine_type}"
}
output "gcp-vm-desc" {
    value = "${data.google_compute_instance.ex2.description}"
}

*/