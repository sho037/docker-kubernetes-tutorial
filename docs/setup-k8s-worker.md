# Kubernetes クラスタ構築(3) 【worker】

2022 年 8 月時点

## 1 はじめに

これから、worker ノードをセットアップしていきます。  
それぞれの worker ノードに同一のコマンドを実行して下さい。

## 2 ノードをクラスタに参加させる

適宜 sudo をつけて実行する。  
コピーした`kubeadm join`コマンドを実行する。

```bash
kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

トークンがない場合は、master ノードで次のコマンドを実行する

```bash
sudo kubeadm token list
```

トークンの有効期限が切れた場合は、master ノードで次のコマンドを実行する

```bash
sudo kubeadm token create
```

## 3 セットアップの確認 (master ノードで実行)

全てのノードを取得  
STATUS が`Ready`になっていれば大丈夫です。

```bash
kubectl get nodes
```

全てのポッドを取得

```bash
kubectl get pods -A
```

以上でセットアップは終了です。

---

## トラブルシューティング (全てのノードで実行)

Kubernetes クラスタをセットアップ前の状態に戻す

```bash
kubeadm reset
```

Next> [Kubernetes クラスタ構築(4)](./setup-k8s-other.md)

## 参考

- [kubeadm を使用したクラスタの作成](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
