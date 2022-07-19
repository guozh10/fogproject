FROM guozh10/fogserver:dev-v1
MAINTAINER guozh10

ENV ipxe=/var/www/html/fog/service/ipxe

COPY image/ ${ipxe}/

RUN chown fog:www-data ${ipxe}/bzImage*
RUN chown fog:www-data ${ipxe}/refind*
COPY entry.sh /entry.sh

CMD bash entry.sh
