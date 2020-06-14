resource "aws_instance" "server" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name = var.ssh_key_name
    vpc_security_group_ids = concat(
          [ aws_security_group.allow_ssh.id, aws_security_group.web_egress.id ], 
          var.security_groups_ids
        )
    tags = var.tags
    user_data = var.user_data
}
