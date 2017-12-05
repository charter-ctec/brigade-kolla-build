#!/bin/sh

if [ -z $KUBECONFIG ]; then
    echo "KUBECONFIG is not set"
#    exit 1
fi

############################################################
#
# Build the following kolla images with Brigade
# nova neutron cinder
# glance heat horizon
# magnum mistral senlin keystone
#
############################################################

PROJECTS="nova neutron cinder glance heat horizon magnum mistral senlin keystone ceilometer barbican"
for proj in $PROJECTS; do
    sed  "s/\(KOLLA_PROJECT\": \).*$/\1 \"$proj\",/" brigade.js > brigade-$proj.js
    echo "building for $proj"
    brig run -f brigade-$proj.js lukepatrick/KollaBrigade
    #sudo docker rm $(sudo docker ps -a | grep -i exit | awk '{print $1}')
    wait 60
done