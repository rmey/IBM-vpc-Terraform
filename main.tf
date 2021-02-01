#---------------------------------------------------------
# Get resource_group id
#---------------------------------------------------------
data "ibm_resource_group" "group" {
  name = var.resource_group
}

#---------------------------------------------------------
# Create new VPC
#---------------------------------------------------------
resource "ibm_is_vpc" "vpc1" {
  name                = var.vpc-name
  resource_group      = data.ibm_resource_group.group.id
  address_prefix_management = "manual"
#  default_network_acl = ibm_is_network_acl.default_all_acl.id
}

#---------------------------------------------------------
# Create new address prefixes in VPC
#---------------------------------------------------------
resource "ibm_is_vpc_address_prefix" "prefix1" {
  name = "zone1-cidr-1"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
  cidr = var.vpc-address-prefix-1
}

resource "ibm_is_vpc_address_prefix" "prefix2" {
  name = "zone1-cidr-2"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone2
  cidr = var.vpc-address-prefix-2
}

resource "ibm_is_vpc_address_prefix" "prefix3" {
  name = "zone1-cidr-3"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone3
  cidr = var.vpc-address-prefix-3
}
