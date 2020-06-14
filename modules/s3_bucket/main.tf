data "archive_file" "zip_files" {
  type          = "zip"
  source_dir    = var.upload_dir
  output_path   = var.zipfile_name
}

resource "aws_s3_bucket" "ansible_bucket" {
  bucket        = var.bucket_name
  acl           = "public-read"
  # Somente para fins de demonstração, não utilizar em produção!
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_object" "upload" {
  bucket        = aws_s3_bucket.ansible_bucket.bucket
  source        = data.archive_file.zip_files.output_path
  key           = "${var.dest_dir}/${var.zipfile_name}"
  acl           = "public-read"
  tags          = var.tags
}