#!/bin/bash

# remove obsolet pifdiles
rm -f /var/run/fog/FOG*
rm -rf /var/run/mysqld/mysqld.sock.lock

/etc/init.d/rsyslog start

source /opt/fog/.fogsettings

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
/etc/init.d/mysql start

# search and replace ip
if [ ${IP} ] && [ -f /INIT ] ; then
  mysqldump -u root fog > dump.sql
  sed -i 's,'${ipaddress}','${IP}',g' /dump.sql \
                                      /tftpboot/default.ipxe \
                                      /var/www/fog/lib/fog/config.class.php \
                                      /var/www/html/fog/lib/fog/config.class.php \
                                      /etc/apache2/sites-enabled/001-fog.conf
  mysql -u root fog < dump.sql && rm -f dump.sql
fi

/etc/init.d/xinetd start
/etc/init.d/php7.1-fpm start
/etc/init.d/apache2 start
/etc/init.d/rpcbind start 
/etc/init.d/nfs-kernel-server start
/etc/init.d/vsftpd start
/etc/init.d/FOGImageReplicator start
/etc/init.d/FOGImageSize start
/etc/init.d/FOGMulticastManager start
/etc/init.d/FOGPingHosts start
/etc/init.d/FOGScheduler start
/etc/init.d/FOGSnapinHash start
/etc/init.d/FOGSnapinReplicator start

if [ -f /INIT ] ; then

  echo ""
  echo "You can now login to the FOG Management Portal using
the information listed below.  The login information
is only if this is the first install.

This can be done by opening a web browser and going to:"
  if [ ${IP} ] ; then
    echo "http://${IP}/fog/management"
  else
    echo "http://${ipaddress}/fog/management"
  fi
  echo "
Default User Information
  Username: fog
  Password: password
  "

  rm -f /INIT
fi

while true ; do

  # create a backup every 24 hours
  sleep 86400
  /usr/local/bin/fog_backup -B /backup

done
