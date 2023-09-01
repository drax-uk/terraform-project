# Get the list of availability zones
data "aws_availability_zones" "available" {
state = "available"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block                     = var.vpc_cidr
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_dns_support             = var.enable_dns_support

  tags = merge(
    var.tags,
    {
      Name = format("%s-VPC", var.name)
    }
  )
}


# Create public subnet1
resource "aws_subnet" "public" {
  count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone =  element(data.aws_availability_zones.available.names, min(count.index, length(data.aws_availability_zones.available.names)-1))
  
  tags = merge(
    var.tags,
    {
      Name = format("%s-PublicSubnet-%s", var.name, count.index)
    } 
  )
}

resource "aws_subnet" "private" {
  count = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  availability_zone =  element(data.aws_availability_zones.available.names, min(count.index, length(data.aws_availability_zones.available.names)-1))
  
  tags = merge(
    var.tags,
    {
      Name = format("%s-PrivateSubnet-%s", var.name, count.index)
    } 
  )
}