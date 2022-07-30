# Proxmox に cloud-init テンプレートを作成する

## 1 準備

```bash
sudo apt install libguestfs-tools -y
```

## 2 テンプレートの作成

[Ubuntu Server 20.04](https://cloud-images.ubuntu.com/focal/current/)を使用しています  
Proxmox クラスタまたはホストのシェルで以下を実行する

```bash
curl -O https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
```

```bash
virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
```

```bash
qm create 9000 --name ubuntu2004-cloud-init --memory 2048 --net0 virtio,bridge=vmbr0
```

```bash
qm importdisk 9000 focal-server-cloudimg-amd64.img local --format qcow2
```

```bash
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local:9000/vm-9000-disk-0.qcow2
```

```bash
qm set 9000 --ide2 local:cloudinit
```

```bash
qm set 9000 --boot c --bootdisk scsi0
```

```bash
qm set 9000 --serial0 socket --vga serial0
```

```bash
qm template 9000
```

```bash
rm focal-server-cloudimg-amd64.img
```

## 参考

- [Cloud-Init Support](https://pve.proxmox.com/wiki/Cloud-Init_Support) (公式 wiki)
- [Proxmox Import And Use Cloud Images](https://codingpackets.com/blog/proxmox-import-and-use-cloud-images/)
