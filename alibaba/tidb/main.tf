module "security-group" {
  source  = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/ecs/security-group"
  zone_id = var.zone_id
}

data "template_file" "topology" {
  template = file("${path.module}/assets/topo.yaml")
  vars     = {
    monitor_ip = alicloud_instance.monitor.private_ip
    tikv1_ip   = alicloud_instance.tikv.0.private_ip
    tikv2_ip   = alicloud_instance.tikv.1.private_ip
    tikv3_ip   = alicloud_instance.tikv.2.private_ip
    password   = var.password
  }
}

resource "null_resource" "copy_files2" {
  depends_on = [
    data.template_file.topology, alicloud_instance.provisioner
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
}

resource "null_resource" "provisioner2" {
  depends_on = [
    null_resource.copy_files2,
  ]

  connection {
    type     = "ssh"
    user     = "root"
    password = var.password
    host     = alicloud_instance.provisioner.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh",
      "source /root/.bash_profile",
      "tiup cluster",
      "echo 'MaxSessions 20' >> /etc/ssh/sshd_config",
      "systemctl restart sshd",
      "tiup cluster deploy db v5.4.0 ./topo.yaml --user root -p --yes", # need to manually set password
      "tiup cluster start db --init"
    ]
  }
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

resource "alicloud_instance" "monitor" {
  availability_zone          = var.zone_id
  instance_name              = "monitor"
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
