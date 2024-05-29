variable "recipients" {
  type        = string
  description = "A list of recipients to send the email to seperated by ;"
}
variable "source_email" {
  type        = string
  description = "Source email that a sender recieves"
}

variable "report_granularity" {
  type        = string
  description = "report granularity.the billing report can be grouped by HOURLY,DAILY,MONTHLY"
  default     = "HOURLY"
}

