# Kubernetes クラスタ構築(1) 【master / worker 共通】

2022 年 8 月時点

## 1 はじめに

これから作成した仮想マシン 3 台にそれぞれセットアップをしていきます。  
構築するにあたり、公式のクラスタ作成及び管理ツールである kubeadm を利用します。  
また、このドキュメントは間違ったことを書いているかもしれません。  
詳しくは[公式ドキュメント](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)をお読み下さい。

## 2 構築環境

| パッケージ | バージョン |    役割    |
| :--------: | :--------: | :--------: |
| Kubernetes |   1.24.4   | Kubernetes |
| containerd |   1.6.7    |    CRI     |
|  flannel   |   0.19.1   |    CNI     |

## 3 準備

予め管理者権限に切り替えておくと便利です。

### 1 Swap をオフにする

kubelet が正常に動作するためには swap は必ずオフでなければなりません。

```bash
swapoff -a
```

再起動すると Swap 領域がもとに戻ってしまうので、`/etc/fstab`の Swap 領域に関する部分をコメントアウトします。

### 2 iptables がブリッジを通過するトラフィックを処理できるようにする

```bash
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
```

```bash
sysctl --system
```

### 3 iptables が nftables バックエンドを使用しないようにする

レガシーバイナリがインストールされていることを確認

```bash
sudo apt-get install -y iptables arptables ebtables
```

レガシーバージョンに切り替え

```bash
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo update-alternatives --set arptables /usr/sbin/arptables-legacy
sudo update-alternatives --set ebtables /usr/sbin/ebtables-legacy
```

## 4 コンテナランタイムのインストール

Kubernetes v1.24 から kubelet から dockershim コンポーネントが削除されました。  
Docker エンジンを使用する場合は、cri-dockerd を利用する必要があります。  
今回は containerd を使用します。

### 1 設定の追加

```bash
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
```

```bash
modprobe overlay
```

```bash
modprobe br_netfilter
```

```bash
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
```

```bash
sysctl --system
```

### 2 containerd のインストール

```bash
apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common
```

Docker 公式の GPG 鍵を追加

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
```

Docker の apt リポジトリの追加

```bash
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
```

containerd のインストール

```bash
apt-get update && apt-get install -y containerd.io
```

containerd の設定

```bash
mkdir -p /etc/containerd
```

```bash
containerd config default | sudo tee /etc/containerd/config.toml
```

containerd の再起動

```bash
systemctl restart containerd
```

systemdcgroup ドライバの構成
`/etc/containerd/config.toml`のファイルに記載されている
`SystemdCgroup = false`を変更する

```txt
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]

  ...

  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
```

containerd の再起動

```bash
systemctl restart containerd
```

## 5 kubeadm, kubelet, kubectl のインストール

Kubernetes apt リポジトリを使用するために必要なパッケージをインストール

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl
```

Google Cloud 公開署名鍵をダウンロードし、Kubernetes apt リポジトリを追加

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

```bash
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
```

```bash
sudo apt-get update
```

```bash
sudo apt-get install -y kubelet kubeadm kubectl
```

バージョンを固定

```bash
sudo apt-mark hold kubelet kubeadm kubectl
```

## 6 kubectl の自動補完を有効にする

Bash による補完は`bash-completion`をインストールしている必要があります。

```bash
sudo apt-get install bash-completion
```

すべてのシェルセッションにて kubectl の補完スクリプトを source できるようにするには 2 つの方法があります。

- 補完スクリプトを`/etc/bash_completion.d`ディレクトリに追加する

```bash
kubectl completion bash >/etc/bash_completion.d/kubectl
```

- 補完スクリプトを`~/.bashrc`内で source する

```bash
echo 'source <(kubectl completion bash)' >>~/.bashrc
```

Next> [Kubernetes クラスタ構築(2)](./setup-k8s-master.md)

## 参考

ドキュメント作成にあたり[kubeadm のインストール](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) (公式)を参考にしています
- [kubectlのインストールおよびセットアップ](https://kubernetes.io/ja/docs/tasks/tools/install-kubectl/)
- [【おうち k8s クラスタ】 Kubernetes クラスタ構築編 (containerd + flannel)](https://4mo.co/k8s-setup-home-cluster/)
- [Kubernetes 1.20 から Docker が非推奨になる理由](https://blog.inductor.me/entry/2020/12/03/061329)
- [Ubuntu 22.04 に Kubernetes をインストールして自宅クラウド](https://rabbit-note.com/2022/08/09/build-kubernetes-home-cluster/)
