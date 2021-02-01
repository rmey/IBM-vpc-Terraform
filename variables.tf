#---------------------------------------------------------
# MODIFY VARIABLES AS NEEDED
#---------------------------------------------------------
variable "ibmcloud_api_key" {}

#---------------------------------------------------------
## DEFINE sshkey to be used for compute instances
#---------------------------------------------------------
variable "ssh_keyname" {}

#---------------------------------------------------------
# 1 vpc generation classic, 2 vpc
#---------------------------------------------------------
variable "ibmcloud_vpc_generation" {
  description = "You can change between GEN1 und GEN2 with value 1 or 2"
  default = "2"
}

#---------------------------------------------------------
## DEFINE VPC name and available Ressource Group (IAM)
#---------------------------------------------------------
variable "vpc-name" {
  description = "Provide the name of your VPC"
  default = "vpc-space"
}

variable "resource_group" {
  description = "The Ressource Roup must be defined in IBM Cloud IAM"
  default = "resource-vpc-space"
}

#---------------------------------------------------------
## DEFINE Region and Zones in US-South Dallas or
## Frankfurt region eu-de
## To switch regin via CLI:  $ibmcloud target -r us-south
## or   ibmcloud target -r eu-de
#---------------------------------------------------------
# cloud region like eu-de (GEN1) or us-south (GEN2)
variable "ibmcloud_region" {
  description = "Region of VPC like eu-de (GEN1) or us-south (GEN2)"
  default = "us-south"
}
#---------------------------------------------------------
## can use us-south-1 / use-south-2 / use-south-3
## or eu-de-1 / eu-de-2 /eu-de-3
#----------------------------------------------------------
variable "zone1" {
  description = "use  eu-de-1 for GEN1 or us-south-1 for GEN2"
  default = "us-south-1"
}

variable "zone2" {
    description = "use  eu-de-2 for GEN1 or us-south-3 for GEN2"
  default = "us-south-2"
}

variable "zone3" {
    description = "use  eu-de-3 for GEN1 or us-south-3 for GEN2"
  default = "us-south-3"
}

#---------------------------------------------------------
## DEFINE CIDR Blocks for VPC in Region
#---------------------------------------------------------
variable "vpc-address-prefix-1" {
  description = "The VPC address prefix"
  default = "172.21.1.0/24"
}

variable "vpc-address-prefix-2" {
  description = "The VPC address prefix"
  default = "172.21.2.0/24"
}

variable "vpc-address-prefix-3" {
  description = "The VPC address prefix"
  default = "172.21.3.0/24"
}

#---------------------------------------------------------
## DEFINE subnets for server in each zone
#---------------------------------------------------------
variable "server-subnet-zone-1" {
  default = "172.21.1.0/24"
}
variable "server-subnet-zone-2" {
  default = "172.21.2.0/24"
}
variable "server-subnet-zone-3" {
  default = "172.21.3.0/24"
}

#---------------------------------------------------------
## DEFINE subnets for server in each zone
#---------------------------------------------------------
variable "server-subnet-zone-1" {
  default = "172.21.1.0/24"
}
variable "server-subnet-zone-2" {
  default = "172.21.2.0/24"
}
variable "server-subnet-zone-3" {
  default = "172.21.3.0/24"
}

#---------------------------------------------------------
## DEFINE variables for ROKS cluster
#---------------------------------------------------------

variable cluster_name {
  default = "myrokscluster"
}
variable cluster_kube_version {
  default = "4.5.24_openshift"
}
variable cluster_flavor{
  default = "bx2.4x16"
}
variable cluster_worker_count{
  default = "1"
}
variable cluster_cos_instance_name{
  default = "myrokscluster_cos"
}

variable "ibmcloud_timeout" {
   default = 300
}
