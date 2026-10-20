provider "aws"{
    region = "sa-east-1"
}

terraform {
    backend "s3"{
        bucket = "intelitech-terraform"
        key    = "terraform.tfstate"
        region = "sa-east-1"  
    }
}