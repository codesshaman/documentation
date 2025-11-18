# terraform_base_template

### Step 1. Install proxmox plugin

Download [last release](https://github.com/Telmate/terraform-provider-proxmox/releases "proxmox provider") of proxmox provider

Unpack archive. Copy plugin version. Create plugins directory if not exist:

```
mkdir -p ~/.terraform.d/plugins/registry.opentofu.org/telmate/proxmox/<past plugin version here>/linux_amd64
```

Copy terraform-provider-proxmox file to this directory:

```
cp ~/Downloads/terraform-provider-proxmox_<version> ~/.terraform.d/plugins/registry.opentofu.org/telmate/proxmox/<version>/linux_amd64
```

### Step 2. Create .env file

```
make env
```

Open in editor

```
nano .env
```

Change variables to realy.

If you use different plugins directory, choose PLUGINS_DIR variable.

### Step 3. Init variables

```
make vars
```

### Step 4. Launch VM creation

```
make init
```

```
make plan
```

```
make
```
