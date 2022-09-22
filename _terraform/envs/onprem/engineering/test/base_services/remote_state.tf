#
# Cannot use variables here since this happens before anything else.
#
terraform {
  backend "s3" {
    bucket         = "terraformstate.mydomain.com"
    key            = "devops/environments/onprem/test/base_services/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}