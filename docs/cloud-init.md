# Proxmox に cloud-init テンプレートを作成する

## 1 はじめに

Proxmox のスナップショット機能を使いたいために、`local`ストレージ上に cloud-init のストレージを配置しています。  
デフォルトではディスクイメージを配置できないため、設定を変更します。

<img src="./image/storage.jpg" width="30%">

## 2 準備

[Ubuntu Server 20.04 (Focal Fossa)](https://cloud-images.ubuntu.com/focal/current/)を使用しています。  
ディスクイメージに`QEMUゲストエージェント`をインストールする。

```bash
sudo apt install libguestfs-tools -y
```

```bash
curl -O https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
```

```bash
virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
```

## 3 テンプレートの作成

Proxmox クラスタまたはホストのシェルで以下を実行する

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

Next> [Terraform の Proxmox ユーザーとロールの作成](./terraform.md#3-%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%81%AB%E3%83%AD%E3%83%BC%E3%83%AB%E3%82%92%E4%BB%98%E4%B8%8E)

## 参考

- [Cloud-Init Support](https://pve.proxmox.com/wiki/Cloud-Init_Support) (公式 wiki)
- [Proxmox Import And Use Cloud Images](https://codingpackets.com/blog/proxmox-import-and-use-cloud-images/)
