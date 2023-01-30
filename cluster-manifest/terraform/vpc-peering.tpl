terraform {
  backend "local" {
    path = "${REMOTE_STATE_DIR}/terraform.tfstate"
  }
}

provider "aws" {
  alias  = "rosa"
  region = "$ROSA_REGION"
}

provider "aws" {
  alias  = "db"
  region = "$DB_REGION"
}

resource "aws_vpc_peering_connection" "rosa-db-connection" {
  provider    = aws.rosa
  peer_vpc_id = "$DB_VPC_ID"
  vpc_id      = "$ROSA_VPC_ID"
  peer_region = "$DB_REGION"
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.db
  vpc_peering_connection_id = aws_vpc_peering_connection.rosa-db-connection.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

data "aws_route_tables" "rosa_rts" {
  provider = aws.rosa
  vpc_id   = "$ROSA_VPC_ID"

  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_route_tables" "db_rts" {
  provider = aws.db
  vpc_id   = "$DB_VPC_ID"

  filter {
    name   = "tag:Name"
    values = ["*rds-route-table*"]
  }
}

resource "aws_route" "rosa_route" {
  provider                  = aws.rosa
  count                     = length(data.aws_route_tables.rosa_rts.ids)
  route_table_id            = tolist(data.aws_route_tables.rosa_rts.ids)[count.index]
  destination_cidr_block    = "$DB_VPC_CIDR"
  vpc_peering_connection_id = aws_vpc_peering_connection.rosa-db-connection.id
}

resource "aws_route" "db_route" {
  provider                  = aws.db
  count                     = length(data.aws_route_tables.db_rts.ids)
  route_table_id            = tolist(data.aws_route_tables.db_rts.ids)[count.index]
  destination_cidr_block    = "$ROSA_VPC_CIDR"
  vpc_peering_connection_id = aws_vpc_peering_connection.rosa-db-connection.id
}
