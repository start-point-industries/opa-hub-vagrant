# OPA Hub for Vagrant

### Why?
We wanted a quick and easy way to get an OPA Hub up and running for DEVELOPMENT use.  This forgoes all of the performance and security considerations of a proper production environment.  Do NOT use this in production.

We use this to test new versions of OPA and to develop against locally.  No need for someone to provision instances to developers.  No need for developers to have an internet connection.  Once you have Vagrant and VirtualBox installed, creating a new OPA Hub takes a couple of minutes.

### How does it work?
Vagrant is a tool for configuring and controlling virtual machines.  This particular configuration has been tested against VirtualBox, but Vagrant supports others including VMWare, Hyper-V, and Docker.  Vagrant creates a virtual machine, installs Tomcat and MySQL, then configures and installs OPA.  Feel free to raise any issues [here](https://github.com/start-point-industries/opa-hub-vagrant/issues).

Note: The configuration forwards the VM's Tomcat port 8080 to the host's port 8787.  This can be configured in the Vagrantfile, if your port 8787 is already in use.  

### Instructions
The dependencies below are the versions we've tested, however any relatively recent versions should work.
- Clone this repo
- Install [Vagrant 2.0.2](https://www.vagrantup.com/downloads.html)
- Install [VirtualBox 5.2.6](https://www.virtualbox.org/wiki/Downloads)
- Download [OPA Server 12.2.10](http://www.oracle.com/technetwork/apps-tech/policy-automation/downloads/index.html)
- Copy OPA zip into `opa-hub-vagrant/installers` directory
- Run `vagrant up` from this directory on the command line
- Access your new hub at http://localhost:8787/opa-hub (admin/password)

- `vagrant halt` to shutdown