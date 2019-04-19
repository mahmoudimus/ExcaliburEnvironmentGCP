# Prerequisites

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

* You will need [`Ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW)
  which is the tool used to handle all the provisioning  
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


# Table of Contents
1. [Setting up GCP](#setting-up-gcp)
2. [Creating Virtual Machines](#creating-virtual-machines)
3. [Connecting to Virtual Machines](#connecting-to-virtual-machines)
4. [More on `gcloud`](#more-on-gcloud)



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
	NOTE: if you are part of an organization, you can select it for the `Billing account`.
- It will take a little while to create the project. After it is done, select it.  
	<img src=Images/gcp_project_select.png width=1000>
	1) click here to manage projects
	2) click here to select newly creaed project (or any other project of your choice)
	
Now you are all set for creating virtual machines! Remember to use the project of your choice for manipulating VMs in the following. Not doing so may result in unexpected billing to occur.



# Creating Virtual Machines

1. [Manual Creation](#manual-creation)
2. [Creation using `gcloud`](#creation-using-gcloud)
3. [Creation using script](#creation-using-script)

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

## Creation using script



# Connecting to Virtual Machines

1. [SSH](#ssh)
2. [gcloud](#gcloud)
3. [RDP (Remote Desktop Protocol)](#rdp)

## SSH

1. [Connect manually using SSH](#connect-manually)
2. [Connect to SSH from GCP](#connect-from-gcp)

### connect manually

### connect from GCP

- go to VM Instances page (explained [above](#VMInstancesPage "Access VM Instances page"))
- click on `SSH` for the corresponding VM
	<img src=Images/connect-ssh-gcp.png width=1000>
- a new window with a shell will open up. This is the VM.
	<img src=Images/connect-ssh-gcp-vm.png width=1000>

## gcloud

- got to VM Instances page (explained [above](#VMInstancesPage "Access VM Instances page"))
- get the gcloud command from GCP  
	<img src=Images/connect-gcloud-1.png width=1000>
	1) Click on the arrow to get the drop-down menu
	2) Click on `View gcloud command`
- a box will appear containing the command. Copy it and paste it into a [terminal](#gcloudAccess "Ways to access gcloud") that has `gcloud` installed.

## RDP



# More on `gcloud`

1. [Install `gcloud` on your machine](#gcloudInstall)
2. [Setup `gcloud`](#gcloudSetup)
3. [Ways to access `gcloud`](#gcloudAccess)

<a name=gcloudInstall></a> 
## Install `gcloud` on your machine

<a name=gcloudSetup></a>
## Setup `gcloud`

<a name=gcloudAccess></a>
## Ways to access `gcloud`




























