variable "region" {
  default = "us-east-1"
}

variable "S3WebsiteEndpoint" {
  description = "this is the s3 endpoint from the s3 module"
  default = ""
}


variable "subDomain" {
  description = "this is the subdomain for example"
  default = ""
}

variable "RootCertificateARN" {
  description = "this is the root certificate arn from the certificate module"
  default = ""
}


variable "rootDomain" {
  description = "your root domain"
  default = ""
}