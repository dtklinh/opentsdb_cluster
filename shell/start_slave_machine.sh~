#!/bin/sh
# dowload package from puppetlabs
wget https://apt.puppetlabs.com/puppetlabs-release-quantal.deb
sudo dpkg -i puppetlabs-release-quantal.deb
sudo apt-get update
sudo apt-get upgrade
sudo apt-get purge -y puppet puppetmaster hiera facter
sudo apt-get install -y puppet hiera facter

