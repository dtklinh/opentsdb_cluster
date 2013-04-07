opentsdb_cluster
================
Development environment set up using vagrant and Puppet for distributed OpenTSDB.

Usage:
1) Prepare machines:
===================
vagrant up --no-provision
2) update machines:
vagrant ssh master(slave)
sudo apt-get update
sudo apt-get upgrade

3) Install OpenTSDB
In node master, set up parameters as following:
node "master" {
  class { 'opentsdb_cluster':
    install_hadoop     => true,
    install_hbase      => true,
    install_opentsdb   => true,
    install_tcollector => true,
    setup_user         => true, 
  }
}

In node slave:
node "slave" {
  class { 'opentsdb_cluster':
    install_hadoop     => true,
    install_hbase      => true,
    setup_user         => true, 
  }
}

