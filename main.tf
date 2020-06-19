

#module for hosting static website on s3
module "s3BucketStaticWebsite" {
  source = "./s3"
  rootDomain = "${var.rootDomain}"
  subDomain = "${var.subDomain}"
}


#configure route53 to point to the endpoint of S3 bucket
module "route53DnsSetup" {
  source = "./route53"
  rootDomain = "${var.rootDomain}"
  subDomain = "${var.subDomain}"
  HostedZoneID = "${var.HostedZoneID}"
  s3RootWebsiteDomain = "${module.s3BucketStaticWebsite.S3BucketRootWebsiteDomain}"
  s3RootWebsiteHostedZoneID = "${module.s3BucketStaticWebsite.S3RootWebsiteHostedZoneID}"
  S3WebsiteSubDomain = "${module.s3BucketStaticWebsite.S3WebsiteSubDomain}"
}
