Create a SAE application with custom configuration


```
terraform apply -auto-approve -var app_name=dev-0302 -var image_url=registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9 -var namespace_name=demo2022 -var namespace_id=cn-beijing:demo2022 -var zone_id=cn-beijing-a
```