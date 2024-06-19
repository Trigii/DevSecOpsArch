FROM ubuntu:22.04@sha256:67211c14fa74f070d27cc59d69a7fa9aeff8e28ea118ef3babc295a0428a6d21

#################################
# INSTALL TERRAFORM AND ANSIBLE #
#################################
USER root

# se instalan las dependencias
RUN apt-get update && apt-get install -y curl gnupg software-properties-common

# se descarga y agrega la clave GPG para el repositorio de HashiCorp
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp.gpg > /dev/null

# se agrega el repositorio de HashiCorp al contenedor
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# Añadir el repositorio de Ansible
RUN apt-add-repository ppa:ansible/ansible

# Instalar Terraform y Ansible y sudo y añadir al usuario al grupo sudoers para que pueda ejecutar el playbook con become:true (DEBIAN_FRONTEND evita preguntas sobre el usuario)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y terraform ansible sudo

###########################
# SETTING THE ENVIRONMENT #
###########################

# Las variables sensibles se inicializan en el docker run por seguridad
ENV ARM_CLIENT_ID="" 
ENV ARM_CLIENT_SECRET="" 
ENV ARM_TENANT_ID="" 
ENV ARM_SUBSCRIPTION_ID=""
# para evitar el fingerprint al ejecutar los playbooks de ansible:
ENV ANSIBLE_HOST_KEY_CHECKING="False"

# se copian los archivos necesarios para el trabajo
COPY ../ /tfg
WORKDIR /tfg/

RUN chmod +x ansible/entrypoint.sh

#######################################################################################
# CREATE THE INFRASTRUCTURE, DOWNLOAD THE SOFTWARE, DEPLOY THE APPS AND AUTOMATE THEM #
#######################################################################################
ENTRYPOINT [ "sh", "-c", "ansible/entrypoint.sh" ]