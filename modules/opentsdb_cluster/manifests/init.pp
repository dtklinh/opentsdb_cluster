class opentsdb_cluster(
  $puppet_hostname                = "puppet",
  $list_slave                     = "puppet, slave",
  $slave_ip                       = "192.168.33.21",
  $myuser_name                    = "gwdg",
  $myuser_id                      = "1010",
  $myuser_passwd                  = '\$6\$aqzOtgCM\$OxgoMP4JoqMJ1U1F3MZPo2iBefDRnRCXSfgIM36E5cfMNcE7GcNtH1P/tTC2QY3sX3BxxJ7r/9ciScIVTa55l0', ##vagrant
  $mygroup_name                   = "goettingen",
  $mygroup_id                     = "1010",
  $hadoop_parent_dir              = "/usr/local",
  $hadoop_version                 = "1.0.3",
  $hadoop_source_link             = "http://apache.openmirror.de/hadoop/core/hadoop-1.0.3/hadoop-1.0.3.tar.gz",
  $java_home                      = "/usr/lib/jvm/java-1.6.0-openjdk-amd64"

){
  $hadoop_working_dir             = "${hadoop_parent_dir}/hadoop-${hadoop_version}"
  include opentsdb_cluster::virtual_user
  User <|title == "gwdg"|>
  Group <|title == "goettingen"|>
  include opentsdb_cluster::virtual_user::add_role
  if $::hostname == "${puppet_hostname}" {
    include opentsdb_cluster::virtual_user::ssh_conn
  }
  include opentsdb_cluster::virtual_user::auth_file
}