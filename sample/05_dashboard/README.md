# Kubernetes Dashboard

## 1 インストール(v2.6.1)

その他のバージョンは[こちら](https://github.com/kubernetes/dashboard/tags)

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
```

kubernetes-dashboard のサービスタイプを`NodePort`に変更

```bash
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}'
```

## 2 Helm と Argo CD を利用したインストール

詳しくは[こちら](https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard)

## 参考

- [Web UI (Dashboard)](https://kubernetes.io/ja/docs/tasks/access-application-cluster/web-ui-dashboard/)
- [kubernetes / dashboard](https://github.com/kubernetes/dashboard) (GitHub)
- [Kubernetes Dashboard をインストールする](https://thr3a.hatenablog.com/entry/20220729/1659054811)
- [Kubernetes v1.24 で ServiceAccount のトークンを生成・取得する](https://zaki-hmkc.hatenablog.com/entry/2022/07/27/002213)
