fogserver  docker-compose

#docker-compose cp to /usr/local/bin

cp ./bin/docker-compose /usr/local/bin/docker-compose

#添加执行权限

chmod +x /usr/local/bin/docker-compose

#创建网桥 

yum install bridge-utils

brctl addbr fog-net

brctl addif fog-net  eth0

#网桥配置在接口上
cat /etc/sysconfig/network-scripts/ifcfg-eth0
....
BRIDGE=fog-net

#载入NFS 模块

modprobe nfs
modprobe nfsd

#开机自动加载模块
cp -a modules/nfs.modules /etc/sysconfig/modules/

#获取网卡名为dhcp 提供ip


#修改 文件的dhcp 服务的网卡名eth0替换对应的网卡名 

vim docker-compose.yml

#网络可以使用默认即可，如果需要改网段请修改 

docker-compose.yml ip地址都要修改和./dhcp/dhcpd.conf 文件都要修改注意 fogserver 的ip是固定的

#后台启动
docker-compose up -d 

#查看日志
docker-compose logs -f 

#访问前端
http://ip/fog   fog/password


#更新内核版本请参考fog 官方文档

https://docs.fogproject.org/en/latest/reference/compile_fos_kernel.html

