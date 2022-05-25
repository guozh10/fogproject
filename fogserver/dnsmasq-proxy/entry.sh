#!/bin/bash

if [ -z ${TFTP_SERVER_IP} ] ; then
  echo "Please set the TFTP_SERVER_IP variable like 192.168.178.141"
  exit 1
fi

if [ -z ${SUBNET} ] ; then
  echo "Please set the SUBNET variable like 192.168.178.0"
  exit 1
fi

echo "Starting dnsmasq ..."
echo "-----------------------------------"

dnsmasq --no-daemon \
        --dhcp-range=${SUBNET},proxy \
        --dhcp-boot=pxelinux.0,${TFTP_SERVER_IP},${SUBNET} \
        --pxe-service=x86PC,"Automatic Network boot",pxelinux,${TFTP_SERVER_IP} \
        --port=0
