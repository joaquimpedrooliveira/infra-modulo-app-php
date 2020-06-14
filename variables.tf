variable "aws_profile" {
  type = string
}

variable "project_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "app_instance_type" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "app_playbook_filename" {
  type = string
}

variable "allowed_ssh_ips" {
  type = list(string)
}

variable "ssh_key_name" {
  type = string
}