#!/bin/bash

# Bug do cloud-init vs ansible requer que a variável HOME esteja explicitamente setada.
# Ver https://github.com/ansible/ansible/issues/31617#issuecomment-337029203
export HOME=/root

wget ${config_download_url} -O /tmp/provisioning.zip
unzip /tmp/provisioning.zip -d /tmp/provisioning
cd /tmp/provisioning

ansible-playbook ${playbook_name} --extra-vars "wp_db_ip=${db_instance_ip} wp_db_name=${db_name} wp_db_user=${db_user} wp_db_pwd=${db_password}"
