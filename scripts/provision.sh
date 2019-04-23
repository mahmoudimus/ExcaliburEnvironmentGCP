#!/bin/bash

# $1 : instance name
# $2 : user name at the instance

HOST_FILE=$(mktemp --suffix=.hosts)
PLAYBOOK="../playbook.yml"

# Make sure Ansible is installed
[ -e $(which ansible) ] || { echo "'ansible' not installed!"; exit 1; }

provision-instance(){
        IP=$(gcloud compute instances list --format="csv(name,networkInterfaces[0].accessConfigs[0].natIP)" | grep "^$1," | cut -d"," -f2)
        [ -z "$IP" ] && { echo "No IP found for '$1'"; exit 2; }
        echo "$IP ansible_user=$2" #>> "$HOST_FILE"
        ansible-playbook -i "$HOST_FILE" "$PLAYBOOK"
}

provision-all(){
        TMP_FILE=$(mktemp --suffix=.gcph)
        gcloud compute instances list --format="csv(name,networkInterfaces[0].accessConfigs[0].natIP)" | tail -n +2 | tr "," " " > "$TMP_FILE"
        while read line
        do
                host=($line)
                if [ -z ${host[1]} ]
                then
                        echo "${host[0]} has no external ip. It is probably not running."
                else
                        echo "Provisioning ${host[0]} ..."
                        provision-instance "${host[0]}" "$1"
                fi
        done < "$TMP_FILE"
        rm "$TMP_FILE"
}


if [ $# -ne 1 ] && [ $# -ne 2 ]
then
        echo "Invalid parameters for $0"
        echo "Use either of these two"
        echo "  $0 -a USER_NAME                 Provision all running instances"
        echo "  $0 INSTANCE_NAME USER_NAME      Provision specific instance"
elif [ "$1" = "-a" ] 
then
        provision-all "$2"
else
        provision-instance "$1" "$2"
        echo 
        echo "NOTE: To provision all the files run $0 -a"
fi
