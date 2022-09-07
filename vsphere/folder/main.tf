terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

data "vsphere_datacenter" "dc" {
}

# resource
resource "vsphere_folder" "folder" {
  path          = var.folder_path
  type          = var.folder_type
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# output
output "FOLDER" {
  value = "folder-${var.folder_type}-${var.folder_path}"
}

# variable
variable "folder_path" {
  description = "The path of the folder to be created"
  type        = string
  default     = "terraform-test-folder"
}

variable "folder_type" {
  description = "The type of folder to create. Allowed options: `datacenter`, `host`, `vm`, `datastore` and `network`"
  type        = string
  default     = "vm"
}
