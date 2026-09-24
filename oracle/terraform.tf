terraform {
  required_providers {
    oci = {
        source = "hashicorp/oci"
    }
  }
}

terraform {
  backend "http" {
    address = "https://objectstorage.sa-saopaulo-1.oraclecloud.com/p/UFt6R9QjSuiUfHxThbg_wZSaM4ybjjNMXT0R4OQBryONgOgtEOdb_z_0tzpr6CeY/n/grpfm3smgtze/b/bucket-20260924-0834/o/terraform.tfstate"
    update_method = "PUT"
    
  }
}