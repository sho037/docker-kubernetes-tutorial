# ArgoCD

Argo CD は、Kubernetes 用の宣言型 GitOps 継続的デリバリー ツールです。

## 1 インストール

```bash
kubectl create namespace argocd
```

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

argocd-server のサービスタイプを`NodePort`に変更

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
```

初期パスワードを取得

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

`NodePort`によってアクセス可能なポート番号を確認

```bash
kubectl get svc -n argocd argocd-server
```

## サンプル

- [サンプル GUI](https://cd.apps.argoproj.io/)
- [サンプル Grafana](https://grafana.apps.argoproj.io/)

## 参考

- [Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/) (Argo CD)
