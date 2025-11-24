1. Datacenter → Permissons → Users → Add | Named ``terraform``

2. Datacenter → Permissons → Roles → Create | Named ``TerraformProvision``

add next required permissions:

```
Datastore.AllocateSpace
Datastore.Audit
Pool.Allocate
SDN.Use
Sys.Audit
Sys.Console
Sys.Modify
Sys.PowerMgmt
VM.Allocate
VM.Audit
VM.Clone
VM.Config.CDROM
VM.Config.CPU
VM.Config.Cloudinit
VM.Config.Disk
VM.Config.HWType
VM.Config.Memory
VM.Config.Network
VM.Config.Options
VM.Migrate
VM.Monitor
VM.PowerMgmt
```

