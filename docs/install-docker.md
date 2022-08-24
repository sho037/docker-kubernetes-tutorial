# Docker, Docker Compose のインストール

## 1 Docker (Rootless モード)のインストール

これにより、Docker デーモンとコンテナを root 以外のユーザが実行できるようになります

### 1 uidmap のインストール

```bash
sudo apt install -y uidmap
```

### 2 ワンライナーでの Docker のインストール

root ユーザーで実行しないでください

```bash
curl -fsSL https://get.docker.com/rootless | sh
```

### 3 Docker コマンドを使えるようにする

スクリプトが終了すると下のようなものを`.bashrc`にコピペするよう促されるので`~/.bashrc`ファイルの最後に追加する  
以下は例です

```bash
export PATH=/home/$USER/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock
```

### 4 systemd

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

### 5 コマンドライン補完のインストール

```bash
sudo curl \
    -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker \
    -o /etc/bash_completion.d/docker
```

### 6 ターミナルを再読込する

ターミナルを閉じて新しいものを開くか、現在のターミナルで以下のコマンドを実行して下さい

```bash
source ~/.bashrc
```

### 7 インストールを確認

```bash
docker -v
```

```bash
docker ps
```

---

## 2 Docker Compose のインストール

以下のコマンドは例ですので[Compose リポジトリのリリースページ](https://github.com/docker/compose/releases)を確認して、URL を修正して下さい

### 1 Docker Compose の最新版をダウンロード (v2.10.0 の場合)

```bash
curl \
    -L https://github.com/docker/compose/releases/download/v2.10.0/docker-compose-`uname -s`-`uname -m` \
    -o ~/bin/docker-compose
```

### 2 バイナリに対して実行権限を付与する

```bash
chmod +x ~/bin/docker-compose
```

### 3 インストールを確認

```bash
docker-compose -v
```

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

## 参考

- [root ユーザー以外による Docker デーモン起動](https://matsuand.github.io/docs.docker.jp.onthefly/engine/security/rootless/)
- [Docker デーモンをルート以外のユーザで実行](https://docs.docker.jp/engine/security/rootless.html)
- [Docker を安全に一般ユーザで実行する](https://e-penguiner.com/rootless-docker-for-nonroot/)
- [BuildKit によるイメージ構築](https://matsuand.github.io/docs.docker.jp.onthefly/develop/develop-images/build_enhancements/)