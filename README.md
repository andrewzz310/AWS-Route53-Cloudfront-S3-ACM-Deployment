# S3  Website with Route 53 DNS
> Deploy a website on AWS hosted on S3 with route 53 (DNS), Cloudfront (CDN), ACM Certificates, (AWS Certificate Manager for SSL/TLS) deployed using Terraform for Infrastructure-As-Code(IAC).
> The following below will allow you to  one push deployment for your website similar to what was done for [andrewzhu.me](https://www.andrewzhu.me)

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
### Overview of Resources to be Created
* AWS ACM: Generates an wildcard SSL certificate
* Route 53: Handles the user request and hosts the DNS entry which directs to cloudfront.
* Cloudfront: CDN which uses the SSL cert created and returns the content to the user based on its cache or required retrieval from S3.
* S3: Object Storage for your website that cloudfront uses as its origin.

### Prerequisites
- [Terraform Installed](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [AWS Account](https://aws.amazon.com/console/)
- [AWS-CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Register a Domain Name on Route 53 in a Hosted Zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html)
- IAM User with Permissions for S3 Writes/Reads, Route53 Record Creation, Cloudfront Creation, ACM
- Your Website Ready to be deployed

### Clone
- Clone this repo to your local machine using 'https://github.com/andrewzz310/AWS-Route53-Cloudfront-S3-ACM-Deployment.git'

### Setup
> Verify AWS-CLI and Terraform is correctly installed and credentials are configured
```shell
$ aws --version
$ aws configure
$ terraform --version
```

> Configure your environment for Terraform (.tfvars includes your rootDomain, subDomain, HostedZoneID)
```shell
$ export AWS_ACCESS_KEY_ID="youraccesskey"
$ export AWS_SECRET_ACCESS_KEY="yoursecretkey"
$ cd personalPortfolio
$ touch terraform.tfvars
```

###Modifications
> You will need to modify your S3 module "null_resource" to sync your own site to S3 (replace the command)

```hcl
# this allows us to upload the site contents all at once based on running a local bash cmd
resource "null_resource" "UploadSiteToS3" {
  provisioner "local-exec" {
    command = "aws s3 sync _site/ s3://${aws_s3_bucket.MyWebsiteRootDomain.id}"
  }
}
```

### Deployment
> Now we are able to Deploy!
```shell
$ terraform init # run in the root module (same directly where you created your .tfvars file)
$ terraform plan # You will see a blueprint of the resources to be created/modified/destroyed
$ terraform apply # This will create your entire stack of resources
```

### Notes
> Given the dependencies between the modules, cloudfront may not beable to verify your validated certificate instantaneously. If this occurs to you, simply run terraform apply again and it will proceed with the cloudfront module.


## Contributing

- *Fork the Repo*
- Create a new pull request using [https://github.com/andrewzz310/Jenkins-On-AWS/compare](https://github.com/andrewzz310/Jenkins-On-AWS/compare)



License
----

MIT


**Free Software!**






