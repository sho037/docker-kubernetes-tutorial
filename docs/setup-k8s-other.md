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

---

## Node の停止/復旧

> これが正しいのかは分かりません

ノード上で実行している全ての Pod を退避させる

```bash
kubectl drain <node name> --ignore-daemonsets --force --delete-emptydir-data
```

Pod の状態を確認

```bash
kubectl get pods -A -o wide
```

ノードへの新しいポッドのスケジューリングを再開

```bash
kubectl uncordon <node name>
```

---

## メトリクスサーバーのインストール

メトリクスサーバーをデプロイ

```bash
curl -O https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Deployment の args に追加（最善の方法ではありません）

```bash
spec:
      containers:
      - args:
        - --cert-dir=/tmp
        - --secure-port=4443
        - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
        - --kubelet-use-node-status-port
        - --metric-resolution=15s
        - --kubelet-insecure-tls   <- 追加
```

```bash
kubectl appply -f components.yaml
```

## 参考

- [kubectl のインストールおよびセットアップ](https://kubernetes.io/ja/docs/tasks/tools/install-kubectl/)

- [Controlling your cluster from machines other than the control-plane node](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#optional-controlling-your-cluster-from-machines-other-than-the-control-plane-node)

- [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/)
- [metrics-server error because it doesn't contain any IP SANs](https://github.com/kubernetes-sigs/metrics-server/issues/196)
