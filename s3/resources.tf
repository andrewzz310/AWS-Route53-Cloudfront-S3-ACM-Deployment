provider "aws" {
  region = "${var.region}"
}


#root domain allow all s3 gets from internet
resource "aws_s3_bucket" "MyWebsiteRootDomain" {
  bucket = "${var.rootDomain}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.rootDomain}/*"
            ]
        }
    ]
}
EOF

  tags = {
    Name = "RootDomainWebsite"
  }
}

#redirect to root domain by excluding www
resource "aws_s3_bucket" "MyWebsiteSubDomain" {
  bucket = "${var.subDomain}"


  website {
    redirect_all_requests_to = "${var.rootDomain}"
  }
  tags = {
    Name = "SubDomainWebsite"
  }

}

# this allows us to upload the site contents all at once based on running a local bash aws-cli command
resource "null_resource" "UploadSiteToS3" {
  provisioner "local-exec" {
    command = "aws s3 sync _site/ s3://${aws_s3_bucket.MyWebsiteRootDomain.id}"
  }
}



output "S3BucketRootWebsiteDomain" {
  value = "${aws_s3_bucket.MyWebsiteRootDomain.website_domain}"
}

output "S3RootWebsiteHostedZoneID" {
  value = "${aws_s3_bucket.MyWebsiteRootDomain.hosted_zone_id}"
}

output "S3WebsiteSubDomain" {
  value = "${aws_s3_bucket.MyWebsiteSubDomain.website_domain}"
}

