FROM guozh10/fogserver:latest
MAINTAINER guozh10

ENV ipxe=/var/www/html/fog/service/ipxe

COPY image/ ${ipxe}/

RUN chown fog:www-data ${ipxe}/bzImage*

COPY entry.sh /entry.sh

CMD bash entry.sh
