

#module for hosting static website on s3
module "s3BucketStaticWebsite" {
  source = "./s3"
  rootDomain = "${var.rootDomain}"
  subDomain = "${var.subDomain}"
}


