variable "bucket_name" {
    type = string
    description = "Nome do bucket a ser criado"
}

variable "upload_dir" {
    type = string
    description = "Diretório local a ser zipado e enviado"
}

variable "zipfile_name" {
    type = string
    description = "Nome do arquivo ZIP a ser criado com o diretório de origem"
}

variable "dest_dir" {
    type = string
    description = "Diretório de destino onde o ZIP será gravado no bucket"
}
   
variable "tags" {
    type = map(string)
    description = "Tags aplicadas ao bucket e ao arquivo enviado"
}