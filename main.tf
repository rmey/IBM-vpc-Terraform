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
#  default_network_acl = ibm_is_network_acl.default_all_acl.id
}

#---------------------------------------------------------
# Create new address prefixes in VPC
#---------------------------------------------------------
resource "ibm_is_vpc_address_prefix" "prefix1" {
  name = "zone1-cidr-1"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
  cidr = var.vpc-address-prefix
}

#---------------------------------------------------------
# Get Public Gateway's for Zone 1
#---------------------------------------------------------
resource "ibm_is_public_gateway" "pubgw-zone1" {
  name = "${var.vpc-name}-${var.zone1}-pubgw"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
}
#---------------------------------------------------------
# Get Public Gateway's for Zone 2
#---------------------------------------------------------
resource "ibm_is_public_gateway" "pubgw-zone2" {
  name = "${var.vpc-name}-${var.zone2}-pubgw"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone2
}
#---------------------------------------------------------
# Get Public Gateway's for Zone 3
#---------------------------------------------------------
resource "ibm_is_public_gateway" "pubgw-zone3" {
  name = "${var.vpc-name}-${var.zone2}-pubgw"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone3
}

#---------------------------------------------------------
## Create Webapp in Zone1
#---------------------------------------------------------
resource "ibm_is_subnet" "server-subnet-zone1" {
  name            = "${var.vpc-name}-${var.zone1}-server"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone1
  ipv4_cidr_block = var.server-subnet-zone-1
  public_gateway  = ibm_is_public_gateway.pubgw-zone1.id
}

#---------------------------------------------------------
## Create Webapp in Zone2
#---------------------------------------------------------
resource "ibm_is_subnet" "server-subnet-zone2" {
  name            = "${var.vpc-name}-${var.zone2}-server"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone2
  ipv4_cidr_block = var.server-subnet-zone-2
  public_gateway  = ibm_is_public_gateway.pubgw-zone2.id
}

#---------------------------------------------------------
## Create Webapp in Zone3
#---------------------------------------------------------
resource "ibm_is_subnet" "server-subnet-zone3" {
  name            = "${var.vpc-name}-${var.zone3}-server"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone3
  ipv4_cidr_block = var.server-subnet-zone-3
  public_gateway  = ibm_is_public_gateway.pubgw-zone3.id
}
