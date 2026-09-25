variable "tenancy_ocid" {
  description = "OCID do Tenancy OCI"
  type        = string
}

variable "user_ocid" {
  description = "OCID do usuário OCI"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint da chave de API OCI"
  type        = string
}

variable "private_key" {
  description = "Conteúdo da chave privada de API OCI"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Região OCI"
  type        = string
  default     = "sa-saopaulo-1"
}

variable "compartment_id" {

  description = "The OCID of the parent compartment where the resources will be created."
  type        = string
}

variable "compartment_name" {
  description = "Compartment Name"
  type        = string
  default     = "cloudquicklabs-compartment"
}

variable "compartment_description" {
  description = "Compartment Description"
  type        = string
  default     = "test-compartment description"
}

############################################
# VCN
############################################

variable "vcn1" {
  description = "The details of VCN1."
  default = {
    cidr_blocks : ["10.23.0.0/20"]
    display_name : "vcn01"
  }
}

############################################
# Public Subnet, Route Table, and Internet Gateway
############################################

variable "subnetA_pub" {
  description = "The details of the subnet"
  default = {
    cidr_block : "10.23.11.0/24"
    display_name : "IC_pub_snet-A"
    is_public : true
    route_table : {
      display_name = "routeTable-Apub"
      description  = "routeTable-Apub"
    }
  }
}

variable "internet_gateway_A" {
  description = "The details of the internet gateway"
  default = {
    display_name : "IC_IG-A"
    ig_destination = "0.0.0.0/0"
  }
}

############################################
# Compute Instance
############################################

variable "ic_pub_vm_A" {
  description = "The details of the compute instance"
  default = {
    display_name : "IC_pub_vm-A"
    assign_public_ip : true
    availability_domain : "zsFf:SA-SAOPAULO-1-AD-1" # TODO: substituir pelo AD correto
    image_ocid : "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaajdztjtffhallfzqvmfzsaefyrig4rfeu25vcitky2aqzjb4feiwa"
    shape : {
      name          = "VM.Standard.E2.1.Micro"
      ocpus         = 1
      memory_in_gbs = 1
    }
    ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9jJIrDjMI9g7uG0qkeJ5sBuMe7dsTy1cE1AFOjBaZYuJSmb9C62OamRX9VCl3r42umkDU/L0eD++5iMjP7y5yceaJJARuXBogcBwjtEqydpR9eep290X/juhjgd9jQehTrQMhJ5SqTtVQeqwAj0LcDVwYq0Xea/o+ZZvUe36z1me23EzEWdDm4HYI+qDJ2wM+4gjuHCyXlP4RQTd/Cf672nkqn+5+1HLrOthPldcXrJSS5oUkMeUjg+V/JgR7r4y3c2JJJQYFBKrAk8PslPhr5vlMMNxEnt2CuJVmUc/QLaacASEVpPVqP2P9g/LCq52d2779743g7vwRZOHP0Tap gustavogabriellaismann@MacBook-Air-de-Gustavo.local"]
  }
}