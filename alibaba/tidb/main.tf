# Generate SSH key pair
resource "tls_private_key" "default" {
  algorithm = "RSA"
}

locals {
  public_key          = tls_private_key.default.public_key_openssh
  private_key_content = tls_private_key.default.private_key_pem
  private_key_path    = "/root/.ssh/id_rsa"
  tikv1_ip            = alicloud_instance.tikv.0.private_ip
  tikv2_ip            = alicloud_instance.tikv.1.private_ip
  tikv3_ip            = alicloud_instance.tikv.2.private_ip

}

# Create VMs
resource "alicloud_ecs_key_pair" "default" {
  depends_on = [tls_private_key.default]
  public_key = local.public_key
}

resource "alicloud_ecs_key_pair_attachment" "default" {
  key_pair_name = alicloud_ecs_key_pair.default.key_pair_name
  instance_ids  = [
    alicloud_instance.tikv.0.id, alicloud_instance.tikv.1.id, alicloud_instance.tikv.2.id,
    alicloud_instance.pd.id, alicloud_instance.tidb.id,
    alicloud_instance.tiflash.id, alicloud_instance.monitoring.id, alicloud_instance.grafana.id
  ]
  force = true
}

module "security-group" {
  source  = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/ecs/security-group"
  zone_id = var.zone_id
}


resource "alicloud_instance" "tikv" {
  count                      = 3
  availability_zone          = var.zone_id
  instance_name              = var.name
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

resource "alicloud_instance" "pd" {
  availability_zone          = var.zone_id
  instance_name              = "pd"
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

resource "alicloud_instance" "tidb" {
  availability_zone          = var.zone_id
  instance_name              = "tidb"
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

resource "alicloud_instance" "tiflash" {
  availability_zone          = var.zone_id
  instance_name              = "tiflash"
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

resource "alicloud_instance" "monitoring" {
  availability_zone          = var.zone_id
  instance_name              = "monitoring"
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

resource "alicloud_instance" "grafana" {
  availability_zone          = var.zone_id
  instance_name              = "grafana"
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

resource "alicloud_instance" "provisioner" {
  availability_zone          = var.zone_id
  instance_name              = "provisioner"
  security_groups            = [module.security-group.SECURITY_GROUP_ID]
  vswitch_id                 = module.security-group.VSWITCH_ID
  instance_type              = var.provisioner_instance_type
  system_disk_category       = var.system_disk_category
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = var.image_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.password
  data_disks {
    name        = var.name
    size        = var.ecs_size
    category    = var.category
    description = var.description
    encrypted   = true
  }
}

# prepare TiDB topology
data "template_file" "topology" {
  template = file("${path.module}/assets/topo.yaml")
  vars     = {
    monitoring_ip = alicloud_instance.monitoring.private_ip
    tikv1_ip      = alicloud_instance.tikv.0.private_ip
    tikv2_ip      = alicloud_instance.tikv.1.private_ip
    tikv3_ip      = alicloud_instance.tikv.2.private_ip
    pd_ip         = alicloud_instance.pd.private_ip
    tidb_ip       = alicloud_instance.tidb.private_ip
    tiflash_ip    = alicloud_instance.tiflash.private_ip
    grafana_ip    = alicloud_instance.grafana.private_ip
    password      = var.password
  }
}

# prepare TiDB topology
data "template_file" "install" {
  template = file("${path.module}/assets/install.sh")
  vars     = {
    private_key_path = local.private_key_path
  }
}

# Copy files to provisioner VM
resource "null_resource" "copy_files" {
  depends_on = [
    data.template_file.topology,
    data.template_file.install,
    alicloud_instance.provisioner
  ]

  connection {
    type     = "ssh"
    user     = "root"
    password = var.password
    host     = alicloud_instance.provisioner.public_ip
  }

  provisioner "file" {
    content     = data.template_file.topology.rendered
    destination = "/root/topo.yaml"
  }

  provisioner "file" {
    content     = local.private_key_content
    destination = local.private_key_path
  }

  provisioner "file" {
    content     = data.template_file.install.rendered
    destination = "/root/install.sh"
  }
}

# TiDB installation
resource "null_resource" "provisioner" {
  depends_on = [
    null_resource.copy_files,
    alicloud_ecs_key_pair_attachment.default
  ]

  connection {
    type     = "ssh"
    user     = "root"
    password = var.password
    host     = alicloud_instance.provisioner.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ./install.sh",
      "./install.sh",
    ]
  }
}

