variable region {
  type = string
  default = "us-east-1"
}
variable "vpc_id" {
  type = string
  default = "vpc-e2199884"
}
variable "images" {
  type = string
  default = "ami-0e1ce54e679f83a66" #"ami-04351e12"
}

variable "zones" {
  type = list(string)
  default = []
}

variable "public_subnets" {
    type = list(string)
    default = []
}

variable "app_name" {
  type = string
  default = ""
}

variable "custom_environments" {
  type = map(string)
}

variable "instance_type" {
  type = string
  default = "t3a.xlarge"
}
variable "rds_parameters" {
  type = list(object({
    name = string,
    value = string,
    apply = string
  }))
  description = "Parameter for RDS"
}

variable "key_name" {
  default = ""
}