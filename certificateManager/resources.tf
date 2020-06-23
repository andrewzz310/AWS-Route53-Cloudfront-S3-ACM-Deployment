provider "aws" {
  region = "${var.region}"
}


# creates certificate for root domain and additional sub-domains
resource "aws_acm_certificate" "WildCardRootDomainCert" {
  domain_name = "*.${var.rootDomain}"
  validation_method = "DNS"

}

data "aws_route53_zone" "zone_alt" {
  name         = "${var.rootDomain}"
  private_zone = false
}


#route 53 record for wildcard
resource "aws_route53_record" "WildCardCertValidation" {
  name    = "${aws_acm_certificate.WildCardRootDomainCert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.WildCardRootDomainCert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone_alt.zone_id}"
  records = ["${aws_acm_certificate.WildCardRootDomainCert.domain_validation_options.0.resource_record_value}"]
  ttl = 60
}




resource "aws_acm_certificate_validation" "ValidateCert" {
  certificate_arn = "${aws_acm_certificate.WildCardRootDomainCert.arn}"
  validation_record_fqdns = ["${aws_route53_record.WildCardCertValidation.fqdn}"]
  depends_on = [aws_route53_record.WildCardCertValidation]
    provisioner "local-exec" {
    command = "sleep 55"
  }
}


output "RootCertificateARN" {
  value = "${aws_acm_certificate.WildCardRootDomainCert.arn}"
}



