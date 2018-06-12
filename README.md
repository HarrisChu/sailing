
## 功能

* Install Docker 17.03
* Install kubeadm, kubelet and kubectl
* Make sure the cgroup driver used by kubelet is the same as the one used by docker
* Pull build-in images on every node
* Kubeadmin init
* Install a pod network. (use Flannel)
* Install plugins
    * Cluster DNS server
    * Dashboard
    * EFK (optional)
    * heapster & grafana (optional)

* SSH access for master nodes
* HA etcd cluster (using master)

590942



[dockerrepo]name=Docker Repository
baseurl=https://mirrors.tuna.tsinghua.edu.cn/docker/yum/repo/centos7
enabled=1
gpgcheck=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/docker/yum/gpg 