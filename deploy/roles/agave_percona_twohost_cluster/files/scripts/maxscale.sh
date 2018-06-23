#!/usr/bin/env bash

name="galera"
rm maxscale.cnf
cp pxc-MaxScale.cnf maxscale.cnf

hosts=()
ids=()
cnt="$(docker ps | grep $name | wc -l)"
[[ $cnt -eq 0 ]] && echo "No galera containers running" && exit 1
for ((i=1; i<=cnt; i++)); do
    container_id=$(docker ps | grep "$name-$i" | awk '{print $1}')
    echo "container id : $container_id"
    ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress  }}' $container_id)
    echo "container ip : $ip"
    #echo "docker exec $c \"sed -i \"s|.*wsrep_cluster_address.*=.*|$address|g\" $mycnf\""
    sed -i  "s|{{dbserv$i}}|$ip|g"  maxscale.cnf
    #hosts+=($ip)
    #ids+=($container_id)
done
