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

### 4 コマンドライン補完のインストール

```bash
sudo curl \
    -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker \
    -o /etc/bash_completion.d/docker
```

### 5 ターミナルを再読込する

ターミナルを閉じて新しいものを開くか、現在のターミナルで以下のコマンドを実行して下さい

```bash
source ~/.bashrc
```

### 6 インストールを確認

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
