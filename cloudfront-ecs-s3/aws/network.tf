resource "aws_vpc" "app-vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "eu-west-2a-public" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "eu-west-2a"
}
resource "aws_subnet" "eu-west-2b-public" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "eu-west-2b"
}
resource "aws_subnet" "eu-west-2a-private" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
}
resource "aws_subnet" "eu-west-2b-private" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app-vpc.id
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app-vpc.id
}
resource "aws_route_table_association" "eu_west_2a_public" {
  subnet_id      = aws_subnet.eu-west-2a-public.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "eu_west_2b_public" {
  subnet_id      = aws_subnet.eu-west-2b-public.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "eu_west_2a_private" {
  subnet_id      = aws_subnet.eu-west-2a-private.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "eu_west_2b_private" {
  subnet_id      = aws_subnet.eu-west-2b-private.id
  route_table_id = aws_route_table.private.id
}
resource "aws_eip" "nat" {
  vpc = true
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app-vpc.id
}
resource "aws_nat_gateway" "public" {
  subnet_id     = aws_subnet.eu-west-2a-public.id
  allocation_id = aws_eip.nat.id
  depends_on = [ aws_internet_gateway.igw ]
}
resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route" "private_ngw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.public.id
}
resource "aws_security_group" "http" {
  name        = "http"
  description = "HTTP traffic"
  vpc_id      = aws_vpc.app-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "https" {
  name        = "https"
  description = "HTTPS traffic"
  vpc_id      = aws_vpc.app-vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "egress-all" {
  name        = "egress_all"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.app-vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "api-ingress" {
  name        = "api_ingress"
  description = "Allow ingress to API"
  vpc_id      = aws_vpc.app-vpc.id
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
