# CMD-EMTRYPOINT

イメージを作成

```bash
docker image build . --tag <tag> --file <file>
```

## 00_Dockerfile(Exec 形式の CMD・ENTRYPOINT)

```bash
docker container run --rm exec-figlet
```

```bash
docker container run --rm exec-figlet -f slant OIT HxS
```

## 01_Dockerfile(Exec 形式の CMD・Shell 形式の ENTRYPOINT)

```bash
docker container run --rm shell-figlet
```
```bash
docker container run --rm shell-figlet -f slant OIT HxS
```
