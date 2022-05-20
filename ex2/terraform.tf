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

}
/*
provider "google" {
project     = "omproject-350619"
region      = "us-central1"
zone        = "us-central1-c"
}
*/