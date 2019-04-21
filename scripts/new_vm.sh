#!/bin/bash

# $1 : Name of the VM to create

MACHINE_TYPE="n1-standard-1"
BOOT_DISK_SIZE="30GB"
IMAGE_PROJECT="ubuntu-os-cloud"
#IMAGE="ubuntu-1804-bionic-v20190404"
IMAGE_FAMILY="ubuntu-1804-lts"
METADATA="enable-oslogin=TRUE"



# Make sure gcloud is installed
[[ -e $(which gcloud) ]] || exit 1



# Make sure everything is set-up
# project, zone, region, account?



# create instance
# To see the available machine-types run:
#       gcloud compute machine-types list
# To see the available boot-disk-types run:
#       gcloud compute disk-types list
# To see the available images run:
#       gcloud compute images list

gcloud compute instances create "$1" \
        --machine-type="$MACHINE_TYPE" \
        --boot-disk-size="$BOOT_DISK_SIZE" \
        --image-project="$IMAGE_PROJECT" \
        --image-family="$IMAGE_FAMILY" \
        --metadata="$METADATA" 

        #--image="$IMAGE" \
