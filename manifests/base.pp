node "puppet"{
  file{"/tmp/hello_master.txt":
    ensure        => present,
    content       => "I am the master \n",
  }
}

node "slave"{
  file{"/tmp/hello_slave.txt":
    ensure        => present,
    content       => "I am your slave \n",
  }
}