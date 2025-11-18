# terraform yandex cloud provider

### Step 1. Install proxmox plugin

Download [last release](https://github.com/yandex-cloud/terraform-provider-yandex/releases "yandex_cloud provider") of proxmox provider

```
cd ~/Downloads
```

```
unzip terraform-provider-yandex_*_linux_amd64.zip
```

```
mv terraform-provider-yandex_* terraform-provider-yandex
```

```
mkdir -p ~/.terraform.d/plugins/yandex-cloud/yandex/<past plugin version here>/linux_amd64/
```

```
cp ./terraform-provider-yandex ~/.terraform.d/plugins/yandex-cloud/yandex/<version>/linux_amd64
```

```
terraform providers
```
