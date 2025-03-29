resource "aws_s3_bucket_object" "object" {
  bucket = "mybuckets210899"
  key    = "new_object_key"
  source = "/root/terraform/s3object"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("/root/terraform/s3object")
}
