terraform {
  required_providers {
    oci = {
        source = "hashicorp/oci"
    }
  }
}
terraform {
  backend "http" {
    address       = "https://objectstorage.sa-saopaulo-1.oraclecloud.com/p/jSALM1bS9wpmZO8K6qZYLrvafneotUvGwPW7nqZ94RofzQ9nueONBF69KeJ2Qi6r/n/grpfm3smgtze/b/bucket-20261008-1224/o/terraform.tfstate"
    update_method = "PUT"
  }
}