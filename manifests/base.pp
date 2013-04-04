node "master" {
  class { 'opentsdb_cluster':
    install_hadoop     => true,
    install_hbase      => true,
    install_opentsdb   => true,
    install_tcollector => true,
  }
  /*
   * include opentsdb_cluster
   * include opentsdb_cluster::virtual_user
   * User <|title == "gwdg"|>
   * Group <|title == "goettingen"|>
   * include opentsdb_cluster::virtual_user::add_role
   */
  #  include

  /*
   *  file{"/tmp/hello.txt":
   *    ensure            => present,
   *    content           => "Hadoop is awesome \n",
   *  }
   *  exec{"add":
   *    command           => "echo 'Hadoop is shit' >> /tmp/hello.txt",
   *    unless            => "grep -q 'Hadoop' /tmp/hello.txt",
   *    require           => File["/tmp/hello.txt"],
   *    path              => $::path,
   *  }
   */
}

node "slave" {
  class{'opentsdb_cluster':
    install_hadoop    => true,
    install_hbase     => true,
  }
  /*
   * include opentsdb_cluster
   * include opentsdb_cluster::virtual_user
   * User <|title == "gwdg"|>
   * Group <|title == "goettingen"|>
   * include opentsdb_cluster::virtual_user::add_role
   */
}