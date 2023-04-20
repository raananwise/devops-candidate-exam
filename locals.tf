# Locals should be consider as variables for all env, if you need different value per env use the regular variable block
locals {

  # Lambdas Names
  lambda_function_name                        = "AviH_Lambda" 

  # Sec Group Shared Configuration
  ingress_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]

  # VPC
  vpc_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}
