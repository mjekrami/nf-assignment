variable "min_size" {
  type        = number
  default     = 2
  description = "Minimum number of instances to start"
}
variable "max_size" {
  type        = number
  default     = 5
  description = "Maximum number of instances"
}
variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type = string

}

variable "public_subnet_id" {
  type = string
}

variable "recurrence_up" {
  type        = string
  description = "Cron style time format for starting the infra"
}
variable "recurrence_down" {
  type        = string
  description = "Cron style time format for shuting down the infra"
}
variable "desired_capacity" {
  type = number
}
variable "instance_security_group" {
  type        = string
  description = "Security group for instances"
}

variable "loadbalacner_target_group" {
  type = string
}
