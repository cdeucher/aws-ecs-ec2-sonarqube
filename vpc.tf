data "aws_vpc" "aws-vpc" {
  id = var.vpc_id
}
/*source "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = data.aws_vpc.aws-vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name        = "${app_name}-public-subnet-${count.index + 1}"
  }
}*/