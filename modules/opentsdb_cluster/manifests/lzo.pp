class opentsdb_cluster::lzo{
  package{["liblzo2-dev", "ant"]:
    ensure  => installed,
  }  
  ##download
  exec{"download_lzo":
    command   => "git clone https://github.com/dtklinh/hadoop-lzo; mv  hadoop-lzo lzo",
    cwd       => $opentsdb_cluster::lzo_parent_dir,
    creates   => $opentsdb_cluster::lzo_working_dir,
    path      => $::path,
    require   => Package["git"],
  }
  file{"reown_lzo":
    path      => $opentsdb_cluster::lzo_working_dir,
    backup    => false,
    recurse   => true,
    owner     => "${opentsdb_cluster::myuser_name}",
    group     => "${opentsdb_cluster::mygroup_name}",
    require   => [Exec["download_lzo"], User["gwdg"]],
  }
  $my_var = "export CFLAGS=\\”-m64\\”"
  exec{"add_var":
    command   => "echo '${my_var}' >> /home/${opentsdb_cluster::myuser_name}/.bashrc",
    user      => $opentsdb_cluster::myuser_name,
    path      => $::path,
    unless    => "grep -q 'CFLAGS' /home/${opentsdb_cluster::myuser_name}/.bashrc",
    require   => File["reown_lzo"],
  }
  
  ##build up
  exec{"build_lzo":
    command   => "ant compile-native tar",
    cwd       => $opentsdb_cluster::lzo_working_dir,
    user      => $opentsdb_cluster::myuser_name,
    creates   => "${opentsdb_cluster::lzo_working_dir}/build",
    require   => [File["reown_lzo"], Package["ant"]],
  }
  
  
}

