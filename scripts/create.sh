#!/bin/bash

# $1 : instance name
# $2 : user name at the instance

bash ./new_vm.sh "$1"
bash ./provision.sh "$1" "$2"
