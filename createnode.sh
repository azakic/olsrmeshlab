#!/bin/bash

eval "$(python main.py)"

file="nodenumber" #the file where you keep your string name

name=$(cat "$file")        #the output of 'cat $file' is assigned to the $name variable

docker run -i --privileged --name node$name -p 222$name:22 -i -t -d azakic/olsrmeshlab004 
#docker start node$name
docker exec -id node$name squirrel-worker -m 172.17.42.1:1234 -i $name -t tap0

#Start OLSRd
#tar -cv /root/olsrdconf_containers/* | docker exec -i node$name tar x -C /root
#tar -cv /root/olsrdmeshlab.conf | docker exec -i node$name tar x -C /
docker exec -id node$name olsrd -f /olsrdmeshlab.conf
