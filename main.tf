provider "aws" {
  profile    = var.aws_profile
  region     = "us-east-1"  
}

locals {
  mysql_ami_version      = "0.0.1"
  apache_php_ami_version = "0.0.1"
}

module "s3_config_db" {
  source       = "./modules/s3_bucket"
  bucket_name  = "${var.project_name}-ansible-db-config"
  # Com ${path.module}, irá pegar a partir do diretório do módulo
  upload_dir   = "${path.module}/ansible"
  zipfile_name = "db_config.zip"
  dest_dir     = "ansible"
  tags         = {
                    Name = "${var.project_name}-configs"
                 }
}

data "aws_ami" "ami_mysql" {
  owners           = ["self"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["MySQL-${local.mysql_ami_version}*"]
  }
}

module "db" {
  source              = "./modules/server"
  ami_id              = data.aws_ami.ami_mysql.id
  instance_type       = var.db_instance_type
  security_groups_ids = [aws_security_group.allow_mysql.id]
  ssh_key_name        = var.ssh_key_name
  allowed_ssh_ips     = var.allowed_ssh_ips
  user_data           = templatefile("${path.module}/scripts/prepara_bd.sh.tpl",
      {
        config_download_url = module.s3_config_db.url_arquivo
        db_root_pwd         = "MySQLr00t1234"
        db_name             = var.db_name
        db_user             = var.db_user
        db_password         = var.db_password
      }
    )
  tags = {
    Name = "${var.project_name}-db"
  }
}

module "s3_config_app" {
  source       = "./modules/s3_bucket"
  bucket_name  = "${var.project_name}-ansible-app-config"
  # Sem ${path.module}, irá pegar a partir do diretório de onde foi chamado
  upload_dir   = "./ansible"
  zipfile_name = "app_config.zip"
  dest_dir     = "ansible"
  tags         = {
                    Name = "${var.project_name}-configs"
                 }
}

data "aws_ami" "ami_apache_php" {
  owners           = ["self"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["Apache/PHP-${local.apache_php_ami_version}*"]
  }
}

module "apache-php" {
  source              = "./modules/server"
  ami_id              = data.aws_ami.ami_apache_php.id
  instance_type       = var.app_instance_type
  security_groups_ids = [aws_security_group.allow_http.id]
  ssh_key_name        = var.ssh_key_name
  allowed_ssh_ips     = var.allowed_ssh_ips
  user_data           = templatefile("${path.module}/scripts/prepara_web.sh.tpl", 
      { 
        config_download_url = module.s3_config_app.url_arquivo
        playbook_name       = var.app_playbook_filename
        db_name             = var.db_name
        db_user             = var.db_user
        db_password         = var.db_password
        db_instance_ip      = module.db.private_ip
      }
    )
  tags = {
    Name = "${var.project_name}-app"
  }
}
