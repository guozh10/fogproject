FROM ubuntu:18.04
MAINTAINER Sam <unclesamwk@googlemail.com>
# Joh 3,16 "For God so loved the world,9 that he gave his only Son, that whoever believes in him should not perish but have eternal life."
RUN apt update \
 && apt upgrade -y

RUN apt install -y wget iproute2 software-properties-common language-pack-en jq
#RUN apt-get  install  -y libapache2-mod-php

ENV VERSION=1.5.4

RUN wget https://github.com/FOGProject/fogproject/archive/${VERSION}.tar.gz \
 && tar xvfz ${VERSION}.tar.gz \
 && cd fogproject-${VERSION}/bin \
 && mkdir -p /backup \
 && bash ./installfog.sh --autoaccept -B /backup

RUN usermod -d /var/lib/mysql/ mysql \
 && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# delete obsolet line
RUN sed -i '/NameVirtualHost.*/d' /etc/apache2/sites-enabled/001-fog.conf

# remove obsolet pifdiles
RUN rm -f /var/run/fog/FOG*

# add backup/update scripts to /usr/local/bin
COPY fogupdater.patch fogbackup.patch utils.patch /
RUN mv fogproject-${VERSION}/utils/FOGBackup/FOGBackup.sh /usr/local/bin/fog_backup \
 && mv fogproject-${VERSION}/utils/FOGUpdater/fogupdater.sh /usr/local/bin/fog_update \
 && mv fogproject-${VERSION}/lib/common/utils.sh /opt/fog/utils.sh \
 && mv fogproject-${VERSION}/lib/common/functions.sh /opt/fog/functions.sh \
 && patch /usr/local/bin/fog_update fogupdater.patch \
 && patch /usr/local/bin/fog_backup fogbackup.patch \
 && patch /opt/fog/utils.sh utils.patch \
 && rm -f /*.patch

# remove fog-sources
RUN rm -rf fogproject-${VERSION} /${VERSION}.tar.gz

# patch vsftpd init file because start with failure
ADD vsftpd.patch .
RUN patch /etc/init.d/vsftpd vsftpd.patch && rm -f vsftpd.patch

ADD entry.sh .
RUN touch /INIT
CMD bash entry.sh
