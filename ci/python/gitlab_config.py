import os
import platform
import variables_config as Vars
import gitlab
import sonar_config as Sonar


def create_gitlab_project():
    print("---------------- CREATING GITLAB PROJECT ----------------")
    
    global gl
    gl = gitlab.Gitlab(url=Vars.gitlab_url, private_token=Vars.gitlab_token, ssl_verify=False)
    
    # obtenemos una lista de todos los proyectos
    gitlab_projects = []
    projects = gl.projects.list(iterator=True)
    for project in projects:
        gitlab_projects.append(project.attributes['name'])

    # si el proyecto no existia previamente lo creamos
    if Vars.gitlab_project_name not in gitlab_projects:
        project = gl.projects.create({'name': Vars.gitlab_project_name, 'description': Vars.gitlab_project_description, 'initialize_with_readme': Vars.gitlab_project_readme, 'visibility': Vars.gitlab_project_visibility})
        return project
    # en caso contrario utilizamos el proyecto ya creado
    else:
        for project in gl.projects.list(iterator=True):
            if project.attributes['name'] == Vars.gitlab_project_name:
                return project
            
def create_gitlab_k8_secrets(project_id):
    user = os.getlogin()
    
    variables_manager = gl.projects.get(project_id).variables
    
    ########### Kubernetes Cluster Config ###########
    try:
        print("---------------- CREATING KUBECONFIG SECRET ----------------")
        variables_manager.get('KUBECONFIG')
        gl.projects.get(project_id).variables.delete('KUBECONFIG')
        if platform.system() == "Windows":
            with open(f'C:\\Users\\{user}\\.kube\\config', 'r') as file:
                value = file.read()
        else:
            with open(f'/home/{user}/.kube/config', 'r') as file:
                value = file.read()
        
        variable = {
            'key': 'KUBECONFIG',
            'value': value,
            'variable_type': 'file',
            'protected': True,
            'masked': False
        }
        gl.projects.get(project_id).variables.create(variable)

    except gitlab.exceptions.GitlabGetError as e:
        if platform.system() == "Windows":
            with open(f'C:\\Users\\{user}\\.kube\\config', 'r') as file:
                value = file.read()
        else:
            with open(f'/home/{user}/.kube/config', 'r') as file:
                value = file.read()
        
        variable = {
            'key': 'KUBECONFIG',
            'value': value,
            'variable_type': 'file',
            'protected': True,
            'masked': False
        }
        gl.projects.get(project_id).variables.create(variable)

    ########### ZAP Scan Config ###########
    try:
        print("---------------- CREATING ZAP SCAN SECRET ----------------")
        variables_manager.get('ZAP_SCAN')
        gl.projects.get(project_id).variables.delete('ZAP_SCAN')
        with open(f'/home/{user}/tfg/helm/zap/zap-scan.yaml', 'r') as file:
            value = file.read()

        variable = {
            'key': 'ZAP_SCAN',
            'value': value,
            'variable_type': 'file',
            'protected': True,
            'masked': False
        }
        gl.projects.get(project_id).variables.create(variable)
    
    except gitlab.exceptions.GitlabGetError as e:
        with open(f'/home/{user}/tfg/helm/zap/zap-scan.yaml', 'r') as file:
            value = file.read()

        variable = {
            'key': 'ZAP_SCAN',
            'value': value,
            'variable_type': 'file',
            'protected': True,
            'masked': False
        }
        gl.projects.get(project_id).variables.create(variable)

def set_gitlab_project_variables(project_id):
    print("---------------- SETTING GITLAB PROJECT VARIABLES ----------------")

    variables_manager = gl.projects.get(project_id).variables

    try:
        variables_manager.get('SONAR_HOST_URL')
        if Vars.sonar_url is not None:
            gl.projects.get(project_id).variables.delete('SONAR_HOST_URL')
            gl.projects.get(project_id).variables.create({'key': 'SONAR_HOST_URL', 'value': Vars.sonar_url, 'protected': True})
    except gitlab.exceptions.GitlabGetError:
        if Vars.sonar_url is not None:
            gl.projects.get(project_id).variables.create({'key': 'SONAR_HOST_URL', 'value': Vars.sonar_url, 'protected': True})

    try:
        variables_manager.get('SONAR_PROJECT_KEY')
        if Vars.sonar_project_token is not None:
            gl.projects.get(project_id).variables.delete('SONAR_PROJECT_KEY')
            gl.projects.get(project_id).variables.create({'key': 'SONAR_PROJECT_KEY', 'value': Vars.sonar_project_token, 'protected': True})
    except gitlab.exceptions.GitlabGetError:
        if Vars.sonar_project_token is not None:
            gl.projects.get(project_id).variables.create({'key': 'SONAR_PROJECT_KEY', 'value': Vars.sonar_project_token, 'protected': True})

    try:
        variables_manager.get('SONAR_TOKEN')
    except gitlab.exceptions.GitlabGetError:
        if Sonar.sonar_user_token is not None:
            gl.projects.get(project_id).variables.create({'key': 'SONAR_TOKEN', 'value': Sonar.sonar_user_token, 'protected': True})