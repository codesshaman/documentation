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


Bash automatic script:

```
#!/bin/bash
VERSION=0.171.0
ARCH=linux_amd64

mkdir -p /tmp/yandex-provider
cd /tmp/yandex-provider

wget https://github.com/yandex-cloud/terraform-provider-yandex/releases/download/v${VERSION}/terraform-provider-yandex_${VERSION}_${ARCH}.zip
unzip terraform-provider-yandex_${VERSION}_${ARCH}.zip

mkdir -p ~/.terraform.d/plugins/registry.terraform.io/yandex-cloud/yandex/${VERSION}/${ARCH}
cp terraform-provider-yandex_v${VERSION} \
   ~/.terraform.d/plugins/registry.terraform.io/yandex-cloud/yandex/${VERSION}/${ARCH}/terraform-provider-yandex_v${VERSION}

echo "Провайдер yandex-cloud v${VERSION} установлен локально"
```
