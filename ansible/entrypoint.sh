#!/bin/bash

# Comprobamos si el usuario actual es el administrador
#if [[ $(id -u) -ne 0 ]]; then
#   echo "Este script debe ser ejecutado como administrador." 
#   exit 1
#fi

# Ejecutamos el playbook de infraestructura de Ansible
ansible-playbook ansible/infrastructure/infrastructure.yml -vvvv
sleep 10 # Para prevenir errores de conexion con el remote host

# Ejecutamos el playbook de software de Ansible
ansible-playbook ansible/software/master.yml -i ansible/software/hosts -vvvv

# Ejecutamos el playbook que despliega las aplicaciones
ansible-playbook ansible/applications/master.yml -i ansible/applications/hosts -vvvv

# Bucle infinito para mantener el contenedor en ejecución
# while true; do
#   sleep 1
# done

exit 0