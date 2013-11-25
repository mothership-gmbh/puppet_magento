#About
This Repository could be useful for anyone, who wants to set up a virtual machine for magento. It is mainly used by Mothership GmbH for internal use.

#Installation

##Requirements
As this is configured for Ubuntu-Machines, also an Ubuntu VM is required. It has been tested on Ubuntu 12.04 LTS.

##Puppet
You can easily install Puppet on Ubuntu using APT.

`
apt-get install puppet
`

##Puppet-Modules
The Puppet-Modules can be found in this repository in the folder modules. You need to setup a symbolic link for the modules folder

`
 # change to root home directory
 # cd
 # create puppet folder
 mkdir .puppet
 # Checkout Git Repository
 https://github.com/mothership-gmbh/puppet_magento
 # set symbolic link (example)
 ln -s /opt/puppet_magento/modules ~/modules
`

##Debuggen

`
puppet config print modulepath
`

##Puppet ausführen

`
puppet apply --verbose --debug --detailed-exitcodes
`