# Prerequisites

- This tutorial assumes that you use a Linux machine
- A `gmail` account is needed to operate on GCP
- You might want to familiarise a little with [`gcloud`](#more-on-gcloud "gcloud specific section")

# Hardware and System Requirements

* Processor:  
    2.66 GHz Intel  Core i5 or similar (minimum)  
    2.66 GHz Intel  Core i7 or similar (recommended)
* Memory:  
    4GB (minimum), 8GB (recommended)
* Hard drive:  
    SSD (recommended)
* Disk space available (for the virtual machine):  
    10GB (minimum), 40GB (recommended)
* Screen resolution:  
    1440x900 (minimum)
* Supported platforms:  
    All the platforms that can run the blow mentionned software

Requirements from the [Excalibur website](https://messir.uni.lu/confluence/display/EXCALIBUR/Installation).

----------------------------------------------------------------
# Required tools

## Host machine

* You will need [`Ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW) which is the tool used to handle all the provisioning  
  Use `sudo apt install ansible` to install on your machine.

* You will need to have `python >= 2.6` on your machine.  
  Use `sudo apt install python` to install if not available.

* You also need `apache-libcloud`:
    - `>= 0.13.3`,
    - `>= 0.17.0` if using JSON credentials,
    - `>= 0.20.0` if using preemptible option

## Remote machine

* `Python` needs to be installed on the remote machine in order for the `Ansible` provisioning to work.  
  Install using `sudo apt install python`.

------------------------------------------------------------------
# Table of Contents
1. [Setting up GCP](#setting-up-gcp)
2. [Creating Virtual Machines](#creating-virtual-machines)
3. [Connecting to Virtual Machines](#connecting-to-virtual-machines)
4. [More on `gcloud`](#more-on-gcloud)
5. [Test Case for Assessment](#test-case)



# Setting Up GCP
- log-in to [GCP](https://cloud.google.com/) using your gmail account
- to the top-right, click on `Console`  
  Here is where you will manage your project and your VMs  
  <img src=Images/gcp_login.png width=1000> 
- Now chose a project in which you want to work, or create a new one.  
	<img src=Images/gcp_project.png width=1000>  
	1) click here to manage projects
	2) select an organization if you are part of one
	3) create a new project ...
	4) or select a project if you already have one
- if you create a new project, fill out all the fields and click `CREATE`  
	<img src=Images/gcp_project_create.png width=1000>
	**NOTE**: if you are part of an organization, you can select it for the `Billing account`.
- It will take a little while to create the project. After it is done, select it.  
	<img src=Images/gcp_project_select.png width=1000>
	1) click here to manage projects
	2) click here to select newly creaed project (or any other project of your choice)
	
Now you are all set for creating virtual machines! Remember to use the project of your choice for manipulating VMs in the following. Not doing so may result in unexpected billing to occur.



# Creating Virtual Machines

1. [Manual Creation](#manual-creation)
2. [Creation using `gcloud`](#creation-using-gcloud)
3. [Creation using script (provided in this repository)](#creation-using-script)

## Manual Creation

- go to the VM Instances page <a name=VMInstancesPage></a>  
	<img src=Images/vm_create_1.png width=1000>
	1) open navigation menu
	2) select `Compute Engine` section
	3) select `VM instances` page
- it may take a few minutes for GCE to get ready. Wait for it to finish.
- if you already have VMs you will be presented with a screen similar to this
	<img src=Images/vm_create_2-1.png width=1000>
	Select `CREATE INSTANCE` to create a new VM instance
- if you don't have any VMs you will be presented with the following screen. Select `CREATE`.  
	<img src=Images/vm_create_2.png width=1000>
- This is the VM creation window. For now the default is good enough. Click on `Create`.
	<img src=Images/vm_create_3.png width=1000>
	1) Name of the instance. You can change it afterwards, however the id of the machine will remain the same.
	2) Select `Region` and `Zone` of the project. Depending on which you use, the costs will change. It seems as if it selects the cheapest by default.
	3) Here you can select various CPUs and set the amount of cores and memory. The cost will vary based on these settings.
	4) Select the `Boot dist`. By default it will select Debian. This essentially means that you will have the Debian OS running on the VM.
	5) Select `Allow HTTP traffic`. _Not sure what it does however, it was proposed in some tutorial_.
- Creating the instance will take a while. Wait for it to finish.
	<img src=Images/vm_create_4.png width=1000>
	
And you are good to go!

## Creation using `gcloud`

- If you have [set up gcloud](#gcloudSetup) accordingly, you can run the following command to create new instances:  
	```bash
	gcloud compute instances create "<NAME>" \
        	--machine-type="<MACHINE_TYPE>" \
        	--boot-disk-size="<BOOT_DISK_SIZE>" \
        	--image-project="<IMAGE_PROJECT>" \
        	--image-family="<IMAGE_FAMILY>" \
        	--metadata="<METADATA>" 
	```
	
	| argument | value |
	| ------------- | ------- |
	| `<NAME>` | is the name of the instance |
	| `<MACHINE_TYPE>` | see available machine type by running:  `gcloud compute machine-types list` |
	| `<BOOT_DISK_SIZE>` | a value larger than 10GB |
	| `<IMAGE_PROJECT>` look at the `PROJECT` | column from the command:  `gcloud compute images list` |
	| `<IMAGE_FAMILY>` look at the `FAMILY` | column of the previous command |
	| `<METADATA>` | set instance specific metadata |
	
	_**NOTE** from gcloud manual:_ When a family is specified instead of an image, the latest non-deprecated image associated with that family is used. It is best practice to use --image-family when the latest version of an image is needed.
	
- if you have not [set up gcloud](#gcloudSetup) yet, then you have to add a few flags to the previous command:  
	`gcloud compute --project "<PROJECT>" instances create ...`
	1. `<PROJECT>` is the project ID to which you want to add the new VM
	2. `...` is meant to say that the rest of the command is identical to the previous one


## Creation using script

Run the script `scripts/new_vm.sh <NAME>`. It takes one argument, namely the name of the instance to create. This script assumes you have [set up gcloud](#gcloudSetup).

To provision the machine with the necessary tools for the Excalibur Environment, run the script `scripts/provision.sh <NAME> <USER>`. User is the main user on the machine. Not the new ones you will create for RDP. You have to ensure SSH connection for the provisioning to work.

To do both at the same time, so create a new machine and have it provisioned right away, use `scripts/create.sh <NAME> <USER>`.  
**As of writing this, this scripts does not work properly because it does not manage to create SSH access by itself. So you will have to do that yourself, which basicall means you are better off using the two previous scripts.**


# Connecting to Virtual Machines

1. [SSH](#ssh)
2. [gcloud](#gcloud)
3. [RDP (Remote Desktop Protocol)](#rdp)

## SSH

1. [Connect manually using SSH](#connect-manually)
2. [Connect to SSH from GCP](#connect-from-gcp)

### connect manually

We are going to use the [cloud shell](#gcloudAccess) for the following. You might want to read [GCP's documentation](https://cloud.google.com/compute/docs/instances/connecting-advanced#thirdpartytools) on this topic. They have a few handy tools that make this a bit easier, so that you do not need to set up everything manually every time.

- create a private-public key pair with the following command:
	`$ ssh-keygen`
	<img src=Images/connect-ssh-1.png width=1000>
	1. Leave empty to use the default
	2. Leave empty to set no password
	3. Private key
	4. Public key

- ask the administrator to put the public key file one the remote machine  
	The simplest way do this is to ssh into the VM [through GCP](#connect-from-gcp). Then you can upload files as follows
	<img src=Images/connect-ssh-2.png width=1000>
	You will be prompted to upload a local file on your computer.
	If you created the keys in the cloud shell you can download them as follows
	<img src=Images/connect-ssh-3.png width=1000>
	
- you need to put the public key into the `~/.ssh/` directory. The private key should remain private and only the corresponding user should have it.

- now you should have the private and public key and the public key is also in `~/.ssh/` on the remote machine you want to connect to

- ask the administrator to give you the `External IP` of the instance you wish to connect to and which has your public key file
	<img src=Images/connect-ssh-4.png width=1000>
	**NOTE** that by default the external IP of the instances changes every time you boot it.

- if everything is set up you can run _in the shell that contains the private key_  
	`ssh [-i <KEY_FILE>] <USER>@<EXTERNAL_IP>`  
	
	| argument | value |
	| ------------ | -------- |
	| `<KEY_FILE>` | path to the private key file. You do not need to specify it if you chose the default file when running `ssh-keygen` |
	| `<USER>` | user with whom you want to log in to on the remote machine |
	| `<EXTERNAL_IP>` | external IP of the remote machine |
	
### connect from GCP

- go to VM Instances page (explained [above](#VMInstancesPage "Access VM Instances page"))
- click on `SSH` for the corresponding VM
	<img src=Images/connect-ssh-gcp.png width=1000>
- a new window with a shell will open up. This is the VM.
	<img src=Images/connect-ssh-gcp-vm.png width=1000>

## gcloud

- if you have [set up gcloud](#gcloudSetup), you can simply run:  
	`gcloud compute ssh <NAME>`
	where `<NAME>` is the name of the instance to connect to. You might want to set up [OS Login](https://cloud.google.com/compute/docs/instances/managing-instance-access) for easing access to VMs

- if you have not [set up gcloud](#gcloudSetup), go to VM Instances page (explained [above](#VMInstancesPage "Access VM Instances page"))
- get the gcloud command from GCP  
	<img src=Images/connect-gcloud-1.png width=1000>
	1) Click on the arrow to get the drop-down menu
	2) Click on `View gcloud command`
- a box will appear containing the command. Copy it and paste it into a [terminal](#gcloudAccess "Ways to access gcloud") that has `gcloud` installed.

## RDP

- Create user account on the VM to be used for getting access with XRDP
	`$ sudo adduser name.surname --force-badname`
- [set up ssh](#ssh) connections for this user. If you already have a public key on it, then just copy it to `~/.ssh/` in the user's home you want to connect to.
	
	
_Instructions from are from [here](https://messir.uni.lu/confluence/pages/viewpage.action?spaceKey=NGTEAM&title=Google+Cloud+Platform#GoogleCloudPlatform-LinuxUser(ubuntutype))._

- install `remmina` on your local machine as follows
```bash
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt-get update
sudo apt-get install remmina remmina-plugin-rdp libfreerdp-plugins-standard
```
- Click on the green cross in the left upper corner to create a new connection.
	<img src=Images/connect-rdp-1.png width=1000>
- Fill out the necessary fields
	<img src=Images/connect-rdp-2.png width=1000>
	- Fill in a meaningful name for the connection. 
	- Set the colour depth to `True colour (24 bpp)`.
	- To be able to fill the rest of the needed fields, the User needs the following information from an Administrator
		1. An external IP address related to the Instance he tries to connect to (Field Server)
		2. Credentials of a user account related to the User willing to connect (Fields User name and User password)
	- Save the connection to be able to connect to it later. 
- After saving, the User will be redirected to the first window. Right click on the newly created instance and select `Connect`.

# More on `gcloud`

Check out the official documentation on [`gcloud`](https://cloud.google.com/sdk/gcloud)

1. [Install `gcloud` on your machine](#gcloudInstall)
2. [Setup `gcloud`](#gcloudSetup)
3. [Ways to access `gcloud`](#gcloudAccess)

<a name=gcloudInstall></a> 
## Install `gcloud` on your machine

Get instructions on how to install `gcloud` [here](https://cloud.google.com/sdk/install)

<a name=gcloudSetup></a>
## Set up `gcloud`

- Instructions for initializing `gcloud` can be found [here](https://cloud.google.com/sdk/docs/initializing].

- run `gcloud config list` to check if everything is in order

- if somethings is wrong or needs tweaking, run any the following commands to configure `gcloud`. This way you do not need to explicitly specify the `--project`, `--region` and `--zone` flags when using `gcloud`.

```bash
gcloud config set core/account <ACCOUNT>
gcloud config set core/project <PROJECT>
gcloud config set compute/region <REGION>
gcloud config set compute/zone <ZONE>
```
| argument | value |
| ------------- | ------- |
| `<ACCOUNT>`| Account gcloud should use for authentication |
| `<PROJECT>` |  Project ID of the Cloud Platform project to operate on by default. This can be overridden by using the global --project flag. | 
| `<REGION>` | Default region to use when working with regional Compute Engine resources |
| `<ZONE>` | Default zone to use when working with zonal Compute Engine resources | 

<a name=gcloudAccess></a>
## Ways to access `gcloud`

There are mainly two way to access gcloud.

- [Install `gcloud`](#gcloudInstall) on your local machine. Now you can open a terminal and use `gcloud` from there

- open [GCP](https://console.cloud.google.com/)  
	<img src=Images/gcloud-access.png width=1000>
	1. active the Cloud Shell
	2. a new shell should open up. In the cloud shell `gcloud` is already installed so you do not need to worry about aqcuiring it

---

# Test Case

Due to time constraints, we are not going to use the [Excalibur Tutorial](https://messir.uni.lu/confluence/display/EXCALIBUR/Getting+Started+in+15+minutes) as our test case. Instead, we will do a few basic tasks to check if the machine is usable.

We are going to download and install [`Remarkable`](https://remarkableapp.github.io/) for this purpose. Since downloading and installing software will be part of the tasks required to set up Excalibur, this seems like a good trade off.

Further, to make this test case more adapted to a _real lift situation_, we will be running one or two Youtube videos in the background as well as having a word editor opened while doing the installation.




















