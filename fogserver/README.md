### dockerized fogserver

An quick and dirty fogserver without dhcp service.
https://fogproject.org/

Start fogserver with set the hostip(IP) environment. If don't set, the container use containerip.
```
docker run -itd --name fogserver --hostname fogserver.local -p 80:80 -p 69:69/udp -p 2049:2049/udp -e IP="192.168.178.123" unclesamwk/fogserver
```
Use docker-compose:
```
fogserver:
  container_name: fogserver
  hostname: fogserver.local
  image: unclesamwk/fogserver
  volumes:
    - ./images:/images
    - ./backup:/backup
  ports:
    - 80:80
    - 69:69/udp
    - 2049:2049/udp
  environment:
    IP: "192.168.178.123"
  privileged: true
  restart: always

```

Please configure your current DHCP-Server:
* On a Linux DHCP server you must set: next-server and filename
* On a Windows DHCP server you must set options 066 and 067
* Option 066/next-server is the IP of the FOG Server: (e.g. 172.17.0.2)
* Option 067/filename is the bootfile: (e.g. undionly.kpxe)

#### Backup
Every 24 hours the container create an fullbackup in /backup folder.
