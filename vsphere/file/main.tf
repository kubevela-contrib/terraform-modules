terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

# resource
resource "vsphere_file" "ubuntu_vmdk_upload" {
  datacenter         = var.datacenter
  datastore          = var.datastore
  source_file        = var.source_file
  destination_file   = var.destination_file
  create_directories = var.create_directories
}

resource "vsphere_file" "ubuntu_copy" {
  source_datacenter  = var.source_datacenter
  datacenter         = var.datacenter
  source_datastore   = var.source_datastore
  datastore          = var.datastore
  source_file        = var.source_file
  destination_file   = var.destination_file
  create_directories = var.create_directories
}

# output
output "DATASTORE" {
  value = vsphere_file.ubuntu_vmdk_upload.datastore
}

output "DATACENTOR" {
  value = vsphere_file.ubuntu_vmdk_upload.datacenter
}

# variable
variable "source_file" {
  description = "The path to the file being uploaded from the Terraform host to the vSphere environment or copied within vSphere environment"
  type        = string
  default     = "/my/src/path/custom_ubuntu.vmdk"
}

variable "destination_file" {
  description = " The path to where the file should be uploaded or copied to on the destination datastore in vSphere"
  type        = string
  default     = "/my/dst/path/custom_ubuntu.vmdk"
}

variable "source_datacenter" {
  description = "The name of a datacenter from which the file will be copied"
  type        = string
  default     = "dc-01"
}

variable "datacenter" {
  description = "The name of a datacenter to which the file will be uploaded"
  type        = string
  default     = "dc-01"
}

variable "source_datastore" {
  description = "The name of the datastore from which file will be copied"
  type        = string
  default     = "datastore-01"
}

variable "datastore" {
  description = "The name of the datastore to which to upload the file"
  type        = string
  default     = "datastore-01"
}

variable "create_directories" {
  description = " Create directories in destination_file path parameter on first apply if any are missing for copy operation"
  type        = bool
  default     = true
}
