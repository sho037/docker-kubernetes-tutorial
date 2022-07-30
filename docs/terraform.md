# Terraform を使い Proxmox に k8s 環境を構築する

## 1 準備

- [Terraform](https://www.terraform.io/)をインストール
- [Proxmox に cloud-init テンプレートを作成](cloud-init.md)

## 2 Terraform の Proxmox ユーザーとロールの作成

Proxmox クラスタまたはホストのシェルで以下を実行する

### 1 TerraformProv ロールを作成

```bash
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
```

### 2 ユーザーにロールを付与

```bash
pveum user add terraform-prov@pve --password <password>
```

### 3 terraform-prov@pve ユーザーを作成

```bash
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```
