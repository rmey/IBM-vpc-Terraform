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

#---------------------------------------------------------
# Get Public Gateway's for Zone 1
#---------------------------------------------------------
resource "ibm_is_public_gateway" "pubgw-zone1" {
  name = "${var.vpc-name}-${var.zone1}-pubgw-1"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
}
#---------------------------------------------------------
# Get Public Gateway's for Zone 2
#---------------------------------------------------------
resource "ibm_is_public_gateway" "pubgw-zone2" {
  name = "${var.vpc-name}-${var.zone2}-pubgw-2"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone2
}
#---------------------------------------------------------
# Get Public Gateway's for Zone 3
#---------------------------------------------------------
resource "ibm_is_public_gateway" "pubgw-zone3" {
  name = "${var.vpc-name}-${var.zone2}-pubgw-3"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone3
}

#---------------------------------------------------------
## Create subnet in Zone1
#---------------------------------------------------------
resource "ibm_is_subnet" "server-subnet-zone1" {
  name            = "${var.vpc-name}-${var.zone1}-server"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone1
  ipv4_cidr_block = var.server-subnet-zone-1
  public_gateway  = ibm_is_public_gateway.pubgw-zone1.id
}

#---------------------------------------------------------
## Create subnet in Zone2
#---------------------------------------------------------
resource "ibm_is_subnet" "server-subnet-zone2" {
  name            = "${var.vpc-name}-${var.zone2}-server"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone2
  ipv4_cidr_block = var.server-subnet-zone-2
  public_gateway  = ibm_is_public_gateway.pubgw-zone2.id
}

#---------------------------------------------------------
## Create subnet in Zone3
#---------------------------------------------------------
resource "ibm_is_subnet" "server-subnet-zone3" {
  name            = "${var.vpc-name}-${var.zone3}-server"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone3
  ipv4_cidr_block = var.server-subnet-zone-3
  public_gateway  = ibm_is_public_gateway.pubgw-zone3.id
}

#---------------------------------------------------------
# Create Rule in default Security Group for Cluster
#---------------------------------------------------------
resource "ibm_is_security_group_rule" "cluster_rule" {
  group     = ibm_is_vpc.vpc1.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 30000
    port_max = 32767
  }
}
