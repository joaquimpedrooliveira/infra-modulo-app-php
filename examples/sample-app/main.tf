provider "aws" {
  region     = "us-east-1"  
}

module "sample-php-app" {
  source = "../.."
  project_name          = "sample-app"

  db_name               = "sample_db"
  db_user               = "sample_user"
  db_password           = "sample_pwd"  # No mundo real, deve estar externalizado
  db_instance_type      = "t2.micro"

  app_instance_type     = "t2.micro"
  app_config_dir        = "config"
  app_playbook_filename = "provision_sample.yml"

  ssh_key_name          = "sample-key"
  allowed_ssh_ips       = ["192.168.1.1/32"]

}