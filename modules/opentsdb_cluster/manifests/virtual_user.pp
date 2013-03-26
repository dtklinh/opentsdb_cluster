class opentsdb_cluster::virtual_user{
  @user{"gwdg":
    name              => $opentsdb_cluster::myuser_name,
    ensure            => present,
    uid               => $opentsdb_cluster::myuser_id,
    gid               => $opentsdb_cluster::mygroup_id,
    #password          => '',#$opentsdb_cluster::myuser_passwd,
    home              => "/home/${opentsdb_cluster::myuser_name}",
    shell             => "/bin/bash",
    managehome        => true,
    require           => Group["goettingen"],
    
  }
  
  @group{"goettingen":
    name              => $opentsdb_cluster::mygroup_name,
    ensure            => present,
    gid               => $opentsdb_cluster::mygroup_id,
  }
  
}

class opentsdb_cluster::virtual_user::add_role{
  exec{"SetPasswd":
    command     => "usermod -p ${opentsdb_cluster::myuser_passwd} ${opentsdb_cluster::myuser_name}; adduser ${opentsdb_cluster::myuser_name} sudo",
    #path        => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin",
    path        => $::path,
    creates     => "/home/tmp_dir",
    require     => User["gwdg"],
#    refreshonly => true,
  }
  
  file{"/home/tmp_dir":
    ensure => directory,
    require => Exec["SetPasswd"],
  }
}