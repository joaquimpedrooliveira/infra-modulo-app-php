variable "ami_id" {
    type = string
    description = "ID da AMI a ser utilizada"
}

variable "instance_type" {
    type = string
    description = "Tipo de instância EC2 do servidor"
}

variable "ssh_key_name" {
    type = string
    description = "Chave SSH utilizada para acesso remoto"
}

variable "security_groups_ids" {
    type = list
    description = "Lista dos IDs dos grupos de segurança para adicionar a máquina. Por padrão, já é adicionada nos grupos 'allow_ssh' e 'web_egress'"
}

variable "allowed_ssh_ips" {
    type = list(string)
    description = "Lista de IPs a partir dos quais o SSH é permitido"
}

variable "user_data" {
    type = string
    description = "Script para inicialização do servidor"
}

variable "tags" {
    type = map
    description = "Tags a serem aplicadas na instância"
}