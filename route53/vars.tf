variable "HostedZoneID" {
  description = "the zone ID of your hosted zone"
  default = ""
}
variable "region" {
  default = "us-west-2"
}
variable "rootDomain" {
  description = "your root domain"
  default = ""
}

variable "subDomain" {
  description = "this is the subdomain for example"
  default = ""
}

variable "s3RootWebsiteDomain" {
  description = "S3 Website Root Domain output created in S3 module"
  default = ""
}
variable "s3RootWebsiteHostedZoneID" {
  description = "S3 website Root Hosted Zone ID created in S3 module"
  default = ""
}

variable "S3WebsiteSubDomain" {
  description = "S3 website SubDomain output created in S3 module"
  default = ""
}


variable "CloudfrontDistributionName" {
  description = "the distribution name from cloudfront module"
  default = ""
}

variable "CloudfrontZoneID" {
  default = ""
}
