# Docker, Docker Compose のインストール

## 目次

1. [パッケージ](#docker-docker-compose-のインストール-パッケージ)
2. [Rootless パッケージ](#dockerrootless-mode-docker-compose-のインストール-スクリプト)
3. [Rootless スクリプト](#dockerrootless-mode-docker-compose-のインストール-スクリプト)
4. [BuildKit の有効化](#buildkit-での構築を有効化する)
5. [参考](#参考)

---

## Docker, Docker Compose のインストール [パッケージ]

apt パッケージのインデックスを更新

```bash
sudo apt-get update
```

HTTPS 経由でリポジトリを使用できるようにする

```bash
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

Docker の公式 GPG キーを追加

```bash
sudo mkdir -p /etc/apt/keyrings
```

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

リポジトリをセットアップ

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Docker エンジンをインストールする

```bash
sudo apt-get update
```

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

docker グループの作成

```bash
sudo groupadd docker
```

ユーザーを docker グループに追加

```bash
sudo usermod -aG docker $USER
```

再ログインする

以上でセットアップは完了です

---

## Docker(Rootless mode), Docker Compose のインストール [パッケージ]

apt パッケージのインデックスを更新

```bash
sudo apt-get update
```

HTTPS 経由でリポジトリを使用できるようにする

```bash
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

Docker の公式 GPG キーを追加

```bash
sudo mkdir -p /etc/apt/keyrings
```

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

リポジトリをセットアップ

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Docker エンジンをインストールする

```bash
sudo apt-get update
```

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

root 以外のユーザーとしてデーモンをセットアップする

```bash
dockerd-rootless-setuptool.sh install
```

以上でセットアップは完了です

---

## Docker(Rootless mode), Docker Compose のインストール [スクリプト]

### 1 Docker (Rootless モード)のインストール

これにより、Docker デーモンとコンテナを root 以外のユーザが実行できるようになります

### uidmap のインストール

```bash
sudo apt install -y uidmap
```

### ワンライナーでの Docker のインストール

root ユーザーで実行しないでください

```bash
curl -fsSL https://get.docker.com/rootless | sh
```

### Docker コマンドを使えるようにする

スクリプトが終了すると下のようなものを`.bashrc`にコピペするよう促されるので`~/.bashrc`ファイルの最後に追加する  
 以下は例です

```bash
export PATH=/home/$USER/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock
```

### systemd

systemd unit ファイルは`~/.config/systemd/user/docker.service`にあります

```bash
systemctl --user start docker
```

```bash
systemctl --user enable docker
```

```bash
sudo loginctl enable-linger $(whoami)
```

### コマンドライン補完のインストール

```bash
sudo curl \
   -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker \
   -o /etc/bash_completion.d/docker
```

### ターミナルを再読込する

ターミナルを閉じて新しいものを開くか、現在のターミナルで以下のコマンドを実行して下さい

```bash
source ~/.bashrc
```

### インストールを確認

```bash
docker -v
```

```bash
docker ps
```

### 2 Docker Compose のインストール

以下のコマンドは例ですので[Compose リポジトリのリリースページ](https://github.com/docker/compose/releases)を確認して、> URL を修正して下さい

### Docker Compose の最新版をダウンロード (v2.10.0 の場合)

```bash
curl \
    -L https://github.com/docker/compose/releases/download/v2.10.0/docker-compose-`uname -s`-`uname -m` \
    -o ~/bin/docker-compose
```

### バイナリに対して実行権限を付与する

```bash
chmod +x ~/bin/docker-compose
```

以上でセットアップは完了です

---

## BuildKit での構築を有効化する

有効化の方法は 2 つあります

- `~/.bashrc`に追記する

```bash
export DOCKER_BUILDKIT=1
```

- daemon.json に記述

本来の Docker は`/etc/docker/daemon.json`に記述しますが、Rootless モードの場合は`~/.config/docker/daemon.json`ファイルを作る必要があります。

```bash
{ "features": { "buildkit": true } }
```

以上でセットアップは完了です

## 参考

- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) (docker docs)
- [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/) (docker docs)
- [Run the Docker daemon as a non-root user (Rootless mode)](https://docs.docker.com/engine/security/rootless/) (docker docs)
- [root ユーザー以外による Docker デーモン起動](https://matsuand.github.io/docs.docker.jp.onthefly/engine/security/rootless/)
- [Docker デーモンをルート以外のユーザで実行](https://docs.docker.jp/engine/security/rootless.html)
- [Docker を安全に一般ユーザで実行する](https://e-penguiner.com/rootless-docker-for-nonroot/)
- [BuildKit によるイメージ構築](https://matsuand.github.io/docs.docker.jp.onthefly/develop/develop-images/build_enhancements/)
- [Docker の rootless を試す](https://tech.virtualtech.jp/entry/2022/07/15/142433) (仮想化通信)
