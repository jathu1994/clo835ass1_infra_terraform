#Add variables
variable "instance_type" {
  default     = "t2.micro"
  description = "Type of the instance"
  type        = string
}

#Add variables
variable "default_tags" {
  default = {
    "Owner" = "Jatharthan"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

#Add variables
variable "prefix" {
  default     = "assignment1"
  type        = string
  description = "Name prefix"
}



