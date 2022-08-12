# Terraform を使い Proxmox に k8s 環境を構築する

## 1 はじめに

Kubernetes クラスタを作るにあたり、[Proxmox VE](https://proxmox.com/en/)を使用します。  
下の表はデフォルトで Terraform が構築する VM のリストです。  
環境に合わせて `terraform.tfvars`と`resource.tf`を編集して下さい。

| ユーザ名 |  ホスト名  |  役割  | VMID | CPU | メモリ | ストレージ | ディスクサイズ |       IP        |     OS      |
| :------: | :--------: | :----: | :--: | :-: | :----: | :--------: | :------------: | :-------------: | :---------: |
|   k8s    | k8s-master | master | 1000 |  2  |  2GB   |   local    |      20GB      | 192.168.0.10/24 | Ubuntu20.04 |
|   k8s    | k8s-node1  | worker | 1001 |  2  |  2GB   |   local    |      20GB      | 192.168.0.11/24 | Ubuntu20.04 |
|   k8s    | k8s-node2  | worker | 1002 |  2  |  2GB   |   local    |      20GB      | 192.168.0.12/24 | Ubuntu20.04 |

## 2 準備

- [Terraform](https://www.terraform.io/)をインストール
- [Proxmox に cloud-init テンプレートを作成](cloud-init.md)

## 3 Terraform の Proxmox ユーザーとロールの作成

Proxmox クラスタまたはホストのシェルで以下を実行する

### 1 TerraformProv ロールを作成

```bash
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
```

### 2 terraform-prov@pve ユーザーを作成

```bash
pveum user add terraform-prov@pve --password <password>
```

### 3 ユーザーにロールを付与

```bash
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```

---

## 4 初期化と実行

`terraform.tfvars.example`を`terraform.tfvars`に変更し、`proxmox_api_url`の変数を環境に合わせることで最低限動くと思います。

```bash
terraform init
```

```bash
terraform apply
```

VM を削除する

```bash
terraform destroy
```

## 参考

- [Terraform provider plugin for Proxmox](https://registry.terraform.io/providers/Telmate/proxmox/)
- [User Management](https://pve.proxmox.com/wiki/User_Management) (公式 wiki)
