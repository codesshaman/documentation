# terraform yandex cloud provider

Copy last version number from [provider github](https://github.com/yandex-cloud/terraform-provider-yandex/releases "yandex_cloud provider").

```
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/yandex-cloud/yandex/${VERSION}/linux_amd64
```

```
cd ~/.terraform.d/plugins/registry.terraform.io/yandex-cloud/yandex/${VERSION}/linux_amd64
```

```
wget https://github.com/yandex-cloud/terraform-provider-yandex/releases/download/v${VERSION}/terraform-provider-yandex_${VERSION}_linux_amd64.zip
```

```
unzip terraform-provider-yandex_*_linux_amd64.zip
```

```
mv terraform-provider-yandex_* terraform-provider-yandex
```

```
terraform providers
```
