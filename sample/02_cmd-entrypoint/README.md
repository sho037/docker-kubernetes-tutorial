# CMD-EMTRYPOINT

## 01_Dockerfile(Exec 形式の CMD・ENTRYPOINT)

イメージを作成

```bash
docker image build --tag exec-figlet --file 01_Dockerfile .
```

```bash
docker container run --rm exec-figlet
```

```bash
docker container run --rm exec-figlet -f slant OIT HxS
```

## 02_Dockerfile(Exec 形式の CMD・Shell 形式の ENTRYPOINT)

イメージを作成

```bash
docker image build --tag shell-figlet --file 02_Dockerfile .
```

```bash
docker container run --rm shell-figlet
```

```bash
docker container run --rm shell-figlet -f slant OIT HxS
```

## 03_Dockerfile(Exec 形式の CMD・ENTRYPOINT)

- フォント  
  `banner`,
  `big`,
  `block`,
  `bubble`,
  `digital`,
  `ivrit`,
  `lean`,
  `mini`,
  `mnemonic`,
  `script`,
  `shadow`,
  `slant`,
  `small`,
  `smscript`,
  `smshadow`,
  `smslant`,
  `standard`,
  `term`,

イメージを作成

```bash
docker image build --tag exec2-figlet --file 03_Dockerfile .
```

```bash
docker container run --rm exec2-figlet
```

```bash
docker container run --rm exec2-figlet slant
```
