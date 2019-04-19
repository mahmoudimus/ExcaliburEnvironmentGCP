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

----------------------------------------------------------------
# Creating the virtual machine and setting up Excalibur Environment

1. Put the `Vagrantfile` and all the necessary files for `Ansible`, namely the
   `playbook` directory, in a same directory.
2. Using a terminal, navigate to the directory in which you put the previous
   files.
3. Run `vagrant up` and wait for the magic to happen. The virtual machine will
   be created and a few tools will be downloaded as well as all the necessary
   packages for the Excalibur Environment.
4. Login using user "vagrant" (password is the same)
5. In the corresponding console enter either of the the following commands (if no
   desktop launches)  
	 `sudo reboot` (in the virtual machine) or  
   `vagrant reload` (in the host machine)
6. Download [Eclipse](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/photon/R/eclipse-dsl-photon-R-linux-gtk-x86_64.tar.gz)
   or follow this step from the [Excalibur website](https://messir.uni.lu/confluence/pages/viewpage.action?pageId=3014662#Installationonyourlocalmachine(recommended)-4-InstallExcalibur)
   and download Ecplise for Linux. **You have to do the download from within the virtual machine**.
7. Launch Eclipse and install the Excalibur plugin from Eclipse Marketplace
   using the menu _Help → Eclipse Marketplace_
8. Look at the [Checklist of Preferences](https://messir.uni.lu/confluence/pages/viewpage.action?pageId=3014662#Installationonyourlocalmachine(recommended)-5-ChecklistofPreferences(mandatory))
   which are mandatory

And you are set!



## Remarks

* Be prepared that the creation may take quite a while because the first time,
  the box may be downloaded, furthermore the Desktop will be downloaded and if
  you chose to install all the LaTeX packages then even more time has to be
  taken into account.

* Rest reassured that it is only the first time you run `vagrant up` that will
  take this much time. Afterwards it should go much quicker. 

* Lastly if you change something on the provisioning, you can make these changes
  apply to the machine by running `vagrant provision`. This will run all the
  provisioning again, so if there is anything new it will be handled as well.
  Running the provisioning again will not take as much time as it did in the
  first run since `Ansible` will skip steps that have already been done.

## PDF Editor

If you follow the [tutorial](https://messir.uni.lu/confluence/display/EXCALIBUR/Getting+Started+in+15+minutes),
there will be a point where you have to set up a pdf editor. When it comes down
to chosing the software, the tutorial proposes Adobe Reader. In case you have
not installed it, chose `Document Viewer` in the `External programs` in the
`Editor Selection` window. This is the default pdf viewer on ubuntu.




----------------------------------------------------------------
## Tweaking the installation

### Disk size and memory

Check the above requirements to make sure the machine still works properly. As a
side note: If you want to run the full latex installation, then 10GB might not
be enough (it should take around 6GB).

### LaTeX

For LaTeX you can chose if you only want to install the minimal amount of
necessary packages or if you want to install all the packages. By default only
the necessary packages will be installed.

You can change this by going into the `playbook.yml` file and you will
see at the very bottom that there is a variable called `version`. You set it to
`minimal` to only install the necessary packages or set it to `full` to download
all the packages.

Mind you that downloading all the packages may take quite a while.

### Shell tools

You can add more packages to be downloaded automatically by adding them to the
file `playbook.yml`. You will see there is a list (to be precise a
variable) of `packages`. Just add your desired packages below that by putting a
dash followed by the name of the package.  **Make sure that the dashes are all
aligned.**



----------------------------------------------------------------
# Versions of the tools used for testing

* OS: Ubuntu 16.04 LTS and Mac OS
* Ansible: 2.7.2



----------------------------------------------------------------
# Test cases 

The [Getting started in 15 minutes](https://messir.uni.lu/confluence/display/EXCALIBUR/Getting+Started+in+15+minutes)
tutorial on the Excalibur Website.
