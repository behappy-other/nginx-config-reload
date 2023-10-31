# nginx-config-reload  
1.nginx-configmap配置热加载  
2.sidecar方式共享process、volume   
3.打开共享进程命名空间特性：shareProcessNamespace: true  

# 基于该Dockerfile构建nginx-reloader镜像：
docker build -t wangxiaowu950330/nginx-reloader:latest .
docker push wangxiaowu950330/nginx-reloader:latest

# 测试  
``` 
1.创建nginx configmap  
kubectl create -f k8s-nginx/nginx-config.yaml
kubectl create -f k8s-nginx/proxy-conf.yaml

2.部署nginx
kubectl create -f k8s-nginx/nginx-deploy-service.yaml

3.修改configmap:nginx-config-v1 
kubectl edit configmap nginx-config-v1  
```

手动修改proxy-conf.yaml 后再apply，reloader监测到configmap变化，会主动向nginx主进程发起HUP信号，实现配置热更新。
