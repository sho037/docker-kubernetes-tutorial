# echo-pods

[Docker イメージ](https://hub.docker.com/r/muruu1/echo-pods)  
`muruu1/echo-pods:latest`  
`muruu1/echo-pods:v4.0`  
`muruu1/echo-pods:v3.0`  
`muruu1/echo-pods:v2.0`  
`muruu1/echo-pods:v1.0`

---

## Docker

### 1 コンテナイメージを見る

```bash
$ mkdir -p ~/kc3-docker/dumpimage
$ cd ~/kc3-docker

# コンテナイメージをtar形式で出力
$ docker save muruu1/echo-pods | tar -xC ./dumpimage
$ tree ./dumpimage

# レイヤーに含まれるファイル群を確認
$ tar --list -f ./dumpimage/........../layer.tar

# ビルド時にCOPYしたファイルがある
$ tar xOf ./dumpimage/........../layer.tar var/www/html/index.php
```

### 2 イメージの履歴を表示する

```bash
$ docker pull muruu1/echo-pods
$ docker history muruu1/echo-pods
```

### 3 コンテナを起動

```bash
$ docker container run --publish 8080:80 muruu1/echo-pods:v1.0

$ docker run --name test -dp 8080:80 muruu1/echo-pods:v2.0

$ docker exec test pwd

$ docker exec test ls

$ docker exec -it test /bin/bash
```

---

## Kubernetes

### Pod

リソースの作成及び更新

```bash
kubectl apply -f wl-pod.yaml
```

Pod の削除

```bash
kubectl delete pods <pod name>
```

Pod の詳細情報を表示

```bash
kubectl describe pods <pod name>
```

### ReplicaSet

リソースの作成及び更新

```bash
kubectl apply -f wl-replicaset.yaml
```

ReplicaSet,Pod の確認

```bash
kubectl get replicasets,pods
```

レプリカ数を変更

```bash
kubectl scale replicaset <replicaset name> --replicas <number>
```

Pod の削除

```bash
kubectl delete pods <pod name>
```

ReplicaSet の詳細情報を表示

```bash
kubectl describe replicasets <replicaset name>
```

### Deployment

アップデートの履歴を保存するオプションを付けて Deployment を起動

```bash
kubectl apply -f wl-deployment-recreate.yaml --record
```

Deployment,ReplicaSet,Pod の確認

```bash
kubectl get deployments,replicasets,pods
```

リソースを追従して出力

```bash
kubectl get [pods/replicasets] --watch
```

変更履歴の確認

```bash
kubectl rollout history deployment echo-pods-dep
```

1 つ前にロールバック

```bash
kubectl rollout undo deployment echo-pods-dep
```

リビジョンを指定してロールバック

```bash
kubectl rollout undo deployment echo-pods-dep --to-revision 1
```

Deployment 更新の一時停止

```bash
kubectl rollout pause deployment echo-pods-dep
```

Deployment 更新の一時停止解除

```bash
kubectl rollout resume deployment echo-pods-dep
```

リソースの再起動

```bash
kubectl rollout restart -n default deployment echo-pods
```

## 参考

- [docker-library / php](https://github.com/docker-library/php/tree/master/8.1/bullseye/apache) (GitHub)
- [php:apache-buster](https://hub.docker.com/layers/php/library/php/apache-buster/images/sha256-3116abca1a9a1314af1818fd96d3ad2e777408a1c10798fa11aa66ac88759243?context=explore) (Docker Hub)
- [PHP-FPM の Dockerfile の ENTRYPOINT や CMD を上書きしたらエラーが起きた](https://zenn.dev/flyingbarbarian/articles/bedd7961d74b83)
- [【Docker / php-fpm】docker-php-entrypoint の動作](https://qiita.com/shim-hiko/items/653059fab63af962a21f)
- [Shellscript でランダムなカラーコード生成](https://lookbackmargin.blog/2019/10/08/random-color-shellscript/)
