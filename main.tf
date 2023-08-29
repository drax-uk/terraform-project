# Get the list of availability zones
data "aws_availability_zones" "available" {
state = "available"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block                     = var.vpc_cidr
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_dns_support             = var.enable_dns_support
}


# Create public subnet1
resource "aws_subnet" "public" {
  count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone =  data.aws_availability_zones.available.names[count.index]
}