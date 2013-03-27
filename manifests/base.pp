node "puppet"{
  include opentsdb_cluster
#  include opentsdb_cluster::virtual_user
#  User <|title == "gwdg"|>
#  Group <|title == "goettingen"|>
#  include opentsdb_cluster::virtual_user::add_role
 
}

node "slave"{
  include opentsdb_cluster
#  include opentsdb_cluster::virtual_user
#  User <|title == "gwdg"|>
#  Group <|title == "goettingen"|>
#  include opentsdb_cluster::virtual_user::add_role
}