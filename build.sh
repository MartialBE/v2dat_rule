#!/bin/bash

TMP_GEOIP="geoip.dat"
TMP_GEOSITE="geosite.dat"
TMP_HOSTS="hosts.txt"
GEOIP=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
GEOSITE=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
HOSTS=https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts

mkdir rule

wget --timeout=30 --waitretry=2 --tries=3 -q $GEOIP -O ./rule/$TMP_GEOIP

if [ $? -eq 0 ];then
    echo "[NOTICE] get geoip.dat successfully!"
    ./v2dat unpack geoip -o ./rule -f cn ./rule/$TMP_GEOIP
else
    echo "get geoip.dat failed! please check your network!"
    exit 1
fi

wget --timeout=30 --waitretry=2 --tries=3 -q $GEOSITE -O ./rule/$TMP_GEOSITE
if [ $? -eq 0 ];then
    echo "[NOTICE] get geosite.dat successfully!"
    ./v2dat unpack geosite -o ./rule -f cn ./rule/$TMP_GEOSITE
    ./v2dat unpack geosite -o ./rule -f category-ads-all ./rule/$TMP_GEOSITE
    ./v2dat unpack geosite -o ./rule -f geolocation-\!cn ./rule/$TMP_GEOSITE
    ./v2dat unpack geosite -o ./rule -f category-games@cn ./rule/$TMP_GEOSITE
    ./v2dat unpack geosite -o ./rule -f apple-cn ./rule/$TMP_GEOSITE
    mv ./rule/geosite_geolocation-\!cn.txt ./rule/geolocation-no-cn.txt
else
    echo "get geosite.dat failed! please check your network!"
    exit 1
fi

wget --timeout=30 --waitretry=2 --tries=3 -q $HOSTS -O ./rule/$TMP_HOSTS
if [ $? -eq 0 ];then
    echo "[NOTICE] get hosts.txt successfully!"
else
    echo "get hosts.txt failed! please check your network!"
    exit 1
fi
