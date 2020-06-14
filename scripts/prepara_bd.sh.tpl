#!/bin/bash

# Bug do cloud-init vs ansible requer que a variável HOME esteja explicitamente setada.
# Ver https://github.com/ansible/ansible/issues/31617#issuecomment-337029203
export HOME=/root

wget ${config_download_url} -O /tmp/provisioning.zip
unzip /tmp/provisioning.zip -d /tmp/provisioning
cd /tmp/provisioning

ansible-playbook provision_db.yml --extra-vars "wp_app_ip=% mysql_root_pwd=${db_root_pwd} wp_db_name=${db_name} wp_db_user=${db_user} wp_db_pwd=${db_password}"

cd /tmp
rm -rf /tmp/provisioning
rm /tmp/provisioning.zip