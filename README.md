# DevSecOpsArch: DevSecOps Architecture to Automate Security Testing in Container Based Applications

This repository contains the TFG made by Tristán Vaquero Povedano. It consists of a DevSecOps architecture for the automation of security tests in container-based applications.

## Requirements

- Have Docker installed
- Have a Microsoft Azure account with 'Owner' permissions 
> Free accounts dont work

## Use
### First Execution

1. Create a **Service Principal** on Microsoft Azure:
    
    - Create it through [Azure portal](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
    - Create it thorugh **azure cli** running:
```bash
az login --tenant TENANT_ID --use-device-code`
```

> You can find the TENANT_ID in the Subscriptions section on the Azure Portal 
> The subscription must have Owner Permissions

```bash
`az ad sp create-for-rbac --display-name NAME --role="Owner" --scopes="/subscriptions/SUBSCRIPTION_ID"` 
```

This command will output 5 variables:

```json
{
"appId": "00000000-0000-0000-0000-000000000000",
"displayName": "azure-cli-2017-06-05-10-41-15",
"name": "http://azure-cli-2017-06-05-10-41-15",
"password": "0000-0000-0000-0000-000000000000",
"tenant": "00000000-0000-0000-0000-000000000000"
}
```

- `appId` is the client_id defined above.
- `password` is the client_secret defined above.
- `tenant` is the tenant_id defined above.
        
2. Go to `terraform/modules/aks/main.tf` and change the service principal credentials

3. Go to `ansible/software/env_variables` and change `.az.login` and `.az.account_set` credentials to the personal Microsoft Azure subscription and Service Principal credentials

4. Go to `terraform/modules/network_security_group/main.tf` and change `'source_address_prefixes'` on `tfg-vm-inbound` rule to your personal **public IP**

5. Go to `terraform/modules/firewall/main.tf` and change all `'source_addresses'` to your personal **public IP**

6. Go to `ansible/applications/env_variables` and change `.vuln_app.repo_url` to the desired **target**

7. Make sure Docker is running on your machine

8. **Build** the Docker image (on the root dir of the project): and Run the image (on the root dir of the project): 
```bash
docker build -t tfg-demo . --file docker/Dockerfile --no-cache
```

9. **Run** the Docker image (on the root dir of the project):
```bash
docker run -v ${PWD}:/tfg -e ARM_CLIENT_ID="****" -e ARM_CLIENT_SECRET="****" -e ARM_TENANT_ID="****" -e ARM_SUBSCRIPTION_ID="****" -it tfg-demo
```

> It will take 30 mins aprox to finish the execution

### Subsequent Executions

1. Go to `ansible/software/env_variables` and change `'install'` flags to `'false'`

2. Go to `ansible/applications/env_variables` and change `'install'` flags to `'false'`

3. If you want to change the target, go to `ansible/applications/env_variables` and modify the repo on `.vuln_app.repo_url`

4. Reset the container

> It will take 5 mins aprox to finish the execution

### Access to Applications

- To access the Virtual machine, run on the root dir of the project: 
```bash
ssh -i terraform/private_keys/vm_private_key.pem tfgadmin@FIREWALL_PUBLIC_IP
```

- Modify `‘/etc/hosts’` on **Linux**, or `‘C:\Windows\System32\drivers\etc\hosts’` on **Windows** with:
    - `FIREWALL_PUBLIC_IP https://gitlab.142.10.0.156.nip.io`
    - `FIREWALL_PUBLIC_IP https://sonarqube.142.10.0.156.nip.io`
    - `FIREWALL_PUBLIC_IP https://defectdojo.142.10.0.156.nip.io`

- To access **Gitlab**, go to 'https://gitlab.142.10.0.156.nip.io'
    - **User** is 'root'
    
    - To get the **password**, run on the virtual machine: 
```bash
kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' -n gitlab | base64 -d ; echo
```

- To access **Sonarqube**, go to 'https://sonarqube.142.10.0.156.nip.io'
    - **User** and **password** are '**admin**'

- To access **DefectDojo**, go to 'https://defectdojo.142.10.0.156.nip.io'
    - **User** is 'admin'

    - To get the **password**, run on the virtual machine: 
```bash
echo "DefectDojo admin password: $(kubectl get secret defectdojo -- namespace=defectdojo --output jsonpath='{.data.DD_ADMIN_PASSWORD}' | base64 --decode)"
```

> It is highly recommended to modify the Helm Charts and change the default passwords

### Troubleshooting

- If you get an error while downloading a Helm Chart, it is very posible that the server handeling the Chart is offline. Wait until the server is up again (turn off the instalation flags of the tasks that are done).

- If you get a timeout error while trying to connect to Sonarqube/Gitlab/Defectdojo instances on the python scrips, try to reset the docker container until it works (turn off the instalation flags of the tasks that are done).

- There could be errors on Python or Helm due to the incompatibility of the versions of the tools installed. This is because the project is configured to use the latest versions of the tools.

### Reference
All the documentation about the architecture is detailed [here](https://oa.upm.es/75213/).
