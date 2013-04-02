class opentsdb_cluster::hbase{
  include opentsdb_cluster::hadoop
  ## download and reown
  exec{"download_hbase":
    command => "wget ${opentsdb_cluster::hbase_source_link}; tar xzf hbase-${opentsdb_cluster::hbase_version}.tar.gz",
    cwd     => $opentsdb_cluster::hbase_parent_dir,
    path    => $::path,
    creates => "${opentsdb_cluster::hbase_working_dir}",
    require => User["gwdg"],
  }
  file{"reown_hbase":
    path    => $opentsdb_cluster::hbase_working_dir,
    ensure  => directory,
    recurse => true,
    backup  => false,
    owner   => $opentsdb_cluster::myuser_name,
    group   => $opentsdb_cluster::mygroup_name,
    require => Exec["download_hbase"],
  }
  
  ## copy file jar in hadoop to hbase
  file{"hadoop-core-1.0.0.jar":
    path    => "${opentsdb_cluster::hbase_working_dir}/lib/hadoop-core-1.0.0.jar",
    ensure  => absent,
    require => File["reown_hbase"],
  }
  exec{"copy_jar":
    command => "cp ${opentsdb_cluster::hadoop_working_dir}/hadoop-core-1.0.3.jar ${opentsdb_cluster::hbase_working_dir}/lib/hadoop-core-1.0.3.jar",
    creates => "${opentsdb_cluster::hbase_working_dir}/lib/hadoop-core-1.0.3.jar",
    require => [File["reown_hbase"],File["reown_hadoop"]],
    path    => $::path,
  }
  file{"hadoop-core-1.0.3.jar":
    path    => "${opentsdb_cluster::hbase_working_dir}/lib/hadoop-core-1.0.3.jar",
    ensure  => present,
    mode    => 777,
    owner   => $opentsdb_cluster::myuser_name,
    group   => $opentsdb_cluster::mygroup_name,
    require => Exec["copy_jar"],
  }
  
}


