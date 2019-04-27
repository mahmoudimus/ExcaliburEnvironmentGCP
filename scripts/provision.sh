#!/bin/bash

# $1 : instance name
# $2 : main user name at the instance

HOST_FILE=$(mktemp --suffix=.hosts)
PLAYBOOK="../playbook.yml"

# Make sure Ansible is installed
[ -e $(which ansible) ] || { echo "'ansible' not installed!"; exit 1; }

generate-keys()(
        KEY_NAME="$1_key"
        [ -d "~/.ssh" ] || mkdir "~/.ssh"
        cd ~/.ssh
        if [ ! -e "$KEY_NAME" ]
        then
                echo Generating keys ${KEY_NAME}{,.pub} in $(pwd) ...
                ssh-keygen -f "$KEY_NAME" -N ""
        fi
        echo "Putting public key onto the VM ..."
        gcloud compute ssh "$1" --command="mkdir .ssh"
        gcloud compute scp "$HOME/.ssh/$KEY_NAME.pub" "${1}:~/.ssh/$KEY_NAME.pub"
)

provision-instance(){
        IP=$(gcloud compute instances list --format="csv(name,networkInterfaces[0].accessConfigs[0].natIP)" | grep "^$1," | cut -d"," -f2)
        [ -z "$IP" ] && { echo "No IP found for '$1'"; exit 2; }
        generate-keys "$1" "$2"
        echo "$IP ansible_user=$2" >> "$HOST_FILE"
        ansible-playbook --private-key "~/.ssh/$1_key" -i "$HOST_FILE" "$PLAYBOOK"
}

provision-all(){
        # $1 : main user name at the instance
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
        echo "NOTE: To provision all the files run $0 -a USER_NAME"
fi
