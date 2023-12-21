# nginx-config-reload
> 该项目旨在实现nginx在kubernetes环境中实现热加载/加载

- nginx-configmap配置热加载
- sidecar方式共享process、volume
- 打开共享进程命名空间特性：shareProcessNamespace: true

# 使用
- 创建nginx configmap
```shell
kubectl create -f k8s-nginx/nginx-config.yaml
# 先修改路由配置
kubectl create -f k8s-nginx/nginx-proxy-conf.yaml
```
- 部署nginx
```shell
kubectl create -f k8s-nginx/nginx-deploy-service.yaml
```

- 修改configmap: nginx-proxy-config
```shell
kubectl edit configmap nginx-proxy-config
```

修改configmap：nginx-proxy-config，reloader监测到configmap变化，会主动向nginx主进程发起HUP信号，实现配置热更新。

# 构建nginx-reloader镜像
- `docker build -t wangxiaowu950330/nginx-reloader:latest .`
- `docker push wangxiaowu950330/nginx-reloader:latest`
