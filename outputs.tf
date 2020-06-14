output "app_public_dns" {
    value = module.apache-php.public_dns
}

output "app_public_ip" {
    value = module.apache-php.public_ip
}

output "db_private_ip" {
    value = module.db.private_ip
}
