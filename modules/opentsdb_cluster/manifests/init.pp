class opentsdb_cluster (
  $puppet_hostname    = "master",
  $slave_hostname     = "slave",
  $slave_ip           = "192.168.33.21",
  $myuser_name        = "gwdg",
  $myuser_id          = "1010",
  $myuser_passwd      = '\$6\$aqzOtgCM\$OxgoMP4JoqMJ1U1F3MZPo2iBefDRnRCXSfgIM36E5cfMNcE7GcNtH1P/tTC2QY3sX3BxxJ7r/9ciScIVTa55l0', 
  # #vagrant
  $mygroup_name       = "goettingen",
  $mygroup_id         = "1010",
  
  $hadoop_parent_dir  = "/usr/local",
  $hadoop_version     = "1.0.4",
  $hadoop_source_link = "http://apache.openmirror.de/hadoop/core/hadoop-1.0.4/hadoop-1.0.4.tar.gz",
  
  $java_home          = "/usr/lib/jvm/java-1.6.0-openjdk-amd64",
  $service_path       = "/etc/init.d",
  
  $hbase_parent_dir   = "/usr/local",
  $hbase_version       = "0.94.6",
  $hbase_source_link  = "http://mirror.cogentco.com/pub/apache/hbase/hbase-0.94.6/hbase-0.94.6.tar.gz",
  
  $opentsdb_parent_dir = "/usr/local",
  $opentsdb_port       = '4242',
  $compression        = 'NONE',
  $master_node        = 'false'
  ) {
  $hadoop_working_dir = "${hadoop_parent_dir}/hadoop-${hadoop_version}"
  $hbase_working_dir  = "${hbase_parent_dir}/hbase-${hbase_version}"
  $opentsdb_working_dir = "${opentsdb_parent_dir}/opentsdb"
  
  include opentsdb_cluster::virtual_user
  User <| title == "gwdg" |>
  Group <| title == "goettingen" |>
  include opentsdb_cluster::virtual_user::add_role

  if $::hostname == "${puppet_hostname}" {
    include opentsdb_cluster::virtual_user::ssh_conn
  }
  include opentsdb_cluster::virtual_user::auth_file
  include opentsdb_cluster::hadoop
  #  if $::hostname == $puppet_hostname{
  #    include opentsdb_cluster::hadoop::format
  #    include opentsdb_cluster::hadoop::service
  #  }
}