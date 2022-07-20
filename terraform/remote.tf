terraform {
  backend "s3" {
    bucket = "jm3-state"
    key    = "aws-transit-gw-udp-test.tfstate"
    region = "us-east-1"
    #dynamodb_table  = "jm3-state"
  }
}
