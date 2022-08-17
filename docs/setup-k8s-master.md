# Kubernetes クラスタ構築(2) 【master】

2022 年 8 月時点

## 1 はじめに

これから、master ノードをセットアップしていきます。  
以下の条件の場合でのコマンドを記載します。
|ホスト名|IP|
|--|--|
|k8s-master|192.168.0.10/24|
|k8s-node1|192.168.0.11/24|
|k8s-node2|192.168.0.12/24|

## 2 コントロールプレーンノードの初期化

予め管理者権限に切り替えておくと便利です。  
flannel のデフォルトのサイダーは`10.244.0.0/16`です。

```bash
kubeadm init --apiserver-advertise-address=192.168.0.10 --pod-network-cidr=10.244.0.0/16
```

プロンプトが返ってくるまで待ちます。  
`kubeadm init`が出力した`kubeadm join`コマンドをコピーする。

```bash
You can now join any number of machines by running the following on each node
as root:

  kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

`kubectl init`の出力されたコマンドを実行する。

```bash
mkdir -p $HOME/.kube
```

```bash
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
```

```bash
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## 3 Pod ネットワークアドオンのインストール

flannel を利用します

```bash
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

Next> [Kubernetes クラスタ構築(3)](./setup-k8s-worker.md)

## 参考

- [flannel-io / flannel](https://github.com/flannel-io/flannel) (GitHub)
- [kubeadm を使用したクラスターの作成](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) (公式)
