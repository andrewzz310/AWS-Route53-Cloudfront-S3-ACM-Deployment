variable "region" {
  default = "us-east-1"
}

variable "rootDomain" {
  description = "your root domain"
  default = ""
}


variable "subDomain" {
  description = "this is the subdomain for example"
  default = ""
}

variable "HostedZoneID" {
  description = "the zone ID of your hosted zone"
  default = ""
}

