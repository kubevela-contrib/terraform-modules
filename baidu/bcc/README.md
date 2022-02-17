# BCC

Though no changes, the bcc instance will be recreated.

```shell
  # baiducloud_instance.default[0] must be replaced
-/+ resource "baiducloud_instance" "default" {
      ~ auto_renew               = false -> (known after apply)
      - card_count               = "0" -> null # forces replacement
      ~ create_time              = "2022-02-17T08:04:13Z" -> (known after apply)
      + expire_time              = (known after apply)
      ~ id                       = "i-U7GYBjBN" -> (known after apply)
      ~ internal_ip              = "192.168.1.4" -> (known after apply)
      + keypair_id               = (known after apply)
      + keypair_name             = (known after apply)
        name                     = "short-terraform-01"
      ~ network_capacity_in_mbps = 0 -> (known after apply)
      ~ placement_policy         = "default" -> (known after apply)
      + public_ip                = (known after apply)
      ~ status                   = "Running" -> (known after apply)
        tags                     = {
            "testKey"  = "testValue"
            "testKey2" = "testValue2"
        }
      ~ vpc_id                   = "vpc-tqauwy0j4ymz" -> (known after apply)
```