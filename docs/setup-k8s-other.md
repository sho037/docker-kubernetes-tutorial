# Kubernetes クラスタ構築(4)

2022 年 8 月時点

## コントロールプレーンノード以外のマシンからのクラスター操作

### 1 Linux へ kubectl をインストールする

2 つの方法があります

- curl を使用して Linux へ kubectl のバイナリをインストールする

```bash
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
```

kubectl バイナリを実行可能にする

```bash
chmod +x ./kubectl
```

バイナリを PATH の中に移動する

```bash
sudo mv ./kubectl /usr/local/bin/kubectl
```

- ネイティブなパッケージマネージャーを使用してインストール

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
```

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

```bash
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
```

```bash
sudo apt-get update
```

```bash
sudo apt-get install -y kubectl
```

### 2 kubectl の自動補完を有効にする

[こちら](./setup-k8s-common.md#6-kubectl-の自動補完を有効にする)を見てください

### 3 kubeconfig ファイルをコピペする

コントロールプレーンの`~/.kube/config`をコピーし、コピー先の`~/.kube/config`にペーストする

## 参考

- [kubectl のインストールおよびセットアップ](https://kubernetes.io/ja/docs/tasks/tools/install-kubectl/)

- [Controlling your cluster from machines other than the control-plane node](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#optional-controlling-your-cluster-from-machines-other-than-the-control-plane-node)
