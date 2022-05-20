terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
    shared_config_files      = ["./.aws/conf"]
    shared_credentials_files = ["./.aws/credentials"]

    assume_role {
    # The role ARN within Account B to AssumeRole into. Created in step 1.
    role_arn    = "arn:aws:iam::441029311384:role/AdminRoleEx1"

  }
}
/*
provider "google" {
project     = "omproject-350619"
region      = "us-central1"
zone        = "us-central1-c"
}
*/