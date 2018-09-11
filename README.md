# Sailing

## 目的

在阿里云上部署高可用的 Kubernetes。

## 主要功能

* 因为阿里云的 SLB，不支持 ECS 即作为 Real Server， 又作为客户端向 SLB 发送请求。单独在集群外的机器部署了 Haproxy。
* 添加了阿里云的 YUM repo，可以用 yum 安装 Kubernetes。
* 同步了 Kubernetes 需要的镜像到 Docker Hub，docker pull 后再改回原来的 tag，可以不需要翻墙下载镜像。
* 同样，同步了 flannel 的镜像。
* 在 master 上安装了 etcd 集群。 （非 TLS）
* 用 kubeadm 安装 Kubernetes HA。

## 准备

* 4 台阿里云机器，1台放 Haproxy，剩下 3 台机器部署 Kubernetes，操作系统 Centos 7.4.
* 配置阿里云的 SLB，6443 端口指向 Haproxy 机器的 6443 端口。
* (推荐) 安装 Docker，通过 Docker 部署。

## 安装集群

### Docker 部署集群

```sh
git clone https://github.com/HarrisChu/sailing.git
cd sailing
cp inventory.sample inventory
# vim inventory 修改 ssh 登录密码和机器信息

# vim env 修改 VIP 地址
make run

```

正常情况下，5分钟之内就会部署完毕。

### 本地 ansible 部署

```sh
git clone https://github.com/HarrisChu/sailing.git
cd sailing
pipenv --python 3.6
pipenv install

cp inventory.sample inventory
# vim inventory 修改 ssh 登录密码和机器信息

# vim env 修改 VIP 地址
pipenv run ansible-playbook -i inventory -e @env site.yaml -f 10
```

## 验证

* 登录 master1 机器

`kubectl get nodes` 查看 node 是否正常

`kubectl get pods --all-namespaces` 查看所有的 pods

* 将 master1 手动关机

* 登录 master2 机器

`kubectl get nodes` 查看 node 是否正常

`kubectl get pods --all-namespaces` 查看所有的 pods

可以看到虽然 master1 不可用了，但是 apiserver 还是正常的。

* 部署 nginx

复制 `example` 中的 yaml 到服务器上，分别执行：

`kubectl apply -f nginx-deploy.yaml`

`kubectl apply -f nginx-svc.yaml`

会创建一个 nginx 的服务，并且通过 nodePort 透传。

`curl localhost:30080` 就可以看到成功访问到 nginx 的页面了。

## 待完善

* 常用插件
    * Dashboard

* 安装 helm
* 部署的集群，自带一个 demo 服务
* 部署的集群，自带一个 ingress 和 ingress controller
