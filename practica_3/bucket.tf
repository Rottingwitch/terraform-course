resource "aws_s3_bucket" "provedores" {
  count  = 5
  bucket = "provedores-regional-col-${random_string.sufijo[count.index].id}"

  tags = {
    Owner       = "Walther"
    Environment = "Dev"
    Office      = "proveedores"
  }
}

resource "random_string" "sufijo" {
  count   = 5
  length  = 8
  special = false
  upper   = false
  numeric = false
}
