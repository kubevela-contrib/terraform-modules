```

# All necessary variables are as below

```
    new_nat_gateway: true
    vpc_name: "tf-k8s-vpc-poc"
    vpc_cidr: "10.0.0.0/8"
    vswitch_name_prefix: "tf-k8s-vsw-poc"
    vswitch_cidrs: [ "10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16" ]
    k8s_pod_cidr: "192.168.5.0/24"
    k8s_service_cidr: "192.168.2.0/24"
    k8s_worker_number: 2
    cpu_core_count: 4
    memory_size: 8
```