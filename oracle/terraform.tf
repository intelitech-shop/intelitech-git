terraform {
  required_providers {
    oci = {
        source = "hashicorp/oci"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "bucket-20261008-1224"
    key    = "terraform.tfstate"
    region = "sa-saopaulo-1"

    endpoints = {
      s3 = "https://grpfm3smgtze.compat.objectstorage.sa-saopaulo-1.oraclecloud.com"
    }

    use_path_style              = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}