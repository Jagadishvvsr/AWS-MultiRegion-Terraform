terraform {
          required_providers {
          aws  = { 
               source = "hashicorp/aws" 
               version = "6.36.0"
          } 
       }
 } 

 provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
}