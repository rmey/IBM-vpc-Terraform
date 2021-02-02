data "ibm_resource_instance" "cos_instance" {
  name     = "COS4ROKS"
  service  = "cloud-object-storage"
  location = "global"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name              = var.cluster_name
  vpc_id            = ibm_is_vpc.vpc1.id
  kube_version      = var.cluster_kube_version
  flavor            = var.cluster_flavor
  worker_count      = var.cluster_worker_count
  cos_instance_crn  = data.ibm_resource_instance.cos_instance.id
  resource_group_id = data.ibm_resource_group.group.id
  zones [
         {
          subnet_id = ibm_is_subnet.server-subnet-zone1.id
          name      = var.zone1
         }
         {
          subnet_id = ibm_is_subnet.server-subnet-zone2.id
          name      = var.zone2
         }
        ]
}
