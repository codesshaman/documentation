# terraform proxmox provider

### Step 1. Install proxmox plugin

Download [last release](https://github.com/Telmate/terraform-provider-proxmox/releases "proxmox provider") of proxmox provider


```
cd ~/Downloads
```

```
unzip terraform-provider-proxmox_*_linux_amd64.zip
```

```
mv terraform-provider-proxmox_* terraform-provider-proxmox
```

```
mkdir -p ~/.terraform.d/plugins/registry.opentofu.org/telmate/proxmox/<past plugin version here>/linux_amd64
```

```
mv ./terraform-provider-proxmox ~/.terraform.d/plugins/registry.opentofu.org/telmate/proxmox/<version>/linux_amd64
```

```
terraform providers
```
