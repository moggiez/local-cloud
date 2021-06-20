terraform {
  backend "local" {
  }
}


provider "aws" {
  region     = "eu-west-1"
  access_key = "123"
  secret_key = "xyz"

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_force_path_style         = true

  endpoints {
    dynamodb     = "http://localhost:4566"
    s3           = "http://localhost:4566"
    codeartifact = "http://localhost:4566"
    kms          = "http://localhost:4566"
    iam          = "http://localhost:4566"
    lambda       = "http://localhost:4566"
    apigateway   = "http://localhost:4566"
    acm          = "http://localhost:4566"
    route53      = "http://localhost:4566"
  }
}

provider "aws" {
  alias      = "acm_provider"
  region     = "eu-west-1"
  access_key = "123"
  secret_key = "xyz"

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_force_path_style         = true

  endpoints {
    dynamodb     = "http://localhost:4566"
    s3           = "http://localhost:4566"
    codeartifact = "http://localhost:4566"
    kms          = "http://localhost:4566"
    iam          = "http://localhost:4566"
    lambda       = "http://localhost:4566"
    apigateway   = "http://localhost:4566"
    acm          = "http://localhost:4566"
    route53      = "http://localhost:4566"
  }
}

data "aws_route53_zone" "public" {
  private_zone = false
  name         = "moggies.io"
}

locals {
  hosted_zone = data.aws_route53_zone.public
  authorization_enabled = false
}
