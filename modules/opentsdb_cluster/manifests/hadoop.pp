class opentsdb_cluster::hadoop{
  
  package{"openjdk-6-jdk":
    ensure          => installed,
    require         => Exec["download_hadoop"],
  }
  
  ##download hadoop
  exec{"download_hadoop":
    command                 => "apt-get update; apt-get upgrade; wget ${opentsdb_cluster::hadoop_source_link}; tar xzf hadoop-${opentsdb_cluster::hadoop_version}.tar.gz",
    cwd                     => "${opentsdb_cluster::hadoop_parent_dir}",
    creates                 => "${opentsdb_cluster::hadoop_working_dir}",
    path                    => $::path,
  }
  ## re-own file
  file{"reown_hadoop":
    path                    => "${opentsdb_cluster::hadoop_working_dir}",
    backup                  => false,
    recurse                 => true,
    owner                   => "${opentsdb_cluster::myuser_name}",
    group                   => "${opentsdb_cluster::mygroup_name}",
    require                 => [Exec["download_hadoop"], User["gwdg"]],
  }
  ## add environment variable
  $var      = template("opentsdb_cluster/hadoop_env_var.erb")
  exec{"add_env_var":
    command                 => "echo ${var} >> /home/${opentsdb_cluster::myuser_name}/.bashrc",
    path                    => $::path,
    unless                  => "grep -q 'HADOOP' /home/${opentsdb_cluster::myuser_name}/.bashrc",
    require                 => File["reown_hadoop"],
  }
  ##create folder to store data
  file{["/app","/app/hadoop", "/app/hadoop/tmp"]:
    ensure                  => directory,
    owner                   => "${opentsdb_cluster::myuser_name}",
    group                   => "${opentsdb_cluster::mygroup_name}",
    require                 => User["gwdg"],
    before                  => File["reown_hadoop"],
    mode                    => 750,
  }
  
}



