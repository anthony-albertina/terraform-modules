# Fetches default subnets, pass as variable to override

# Declare vpc
data "aws_vpc" "default" {
  default = true
}

# Declare subnets
data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}