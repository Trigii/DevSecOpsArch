# import requests
import variables_config as Vars
from sonarqube import SonarQubeClient


def init_sonar():
    print("---------------- INITIALIZING SONARQUBE ----------------")

    global sonar_user_token

    # Inicializar la API de SonarQube con las credenciales
    sonar = SonarQubeClient(sonarqube_url=Vars.sonar_url, username=Vars.sonar_username, password=Vars.sonar_password, verify=False)
    #sonar.users.change_user_password(password="1234", previousPassword="12345")

    # obtenemos una lista de los tokens del usuario
    token = None
    user_tokens = sonar.user_tokens.search_user_tokens(login=Vars.sonar_username)
    for user_token in user_tokens['userTokens']:
        if user_token['name'] == Vars.sonar_token_name:
            token = user_token
            break
    
    if token == None:            
        new_token = sonar.user_tokens.generate_user_token(Vars.sonar_token_name)
        sonar_user_token = new_token['token']
    else:
        sonar_user_token = None
    
    # En la demo, se enchufaron el create project de la biblioteca de python. Si sigue roto, hacer peticiones mediante requests descomentando esto
    # url = f'{Vars.sonar_url}/api/projects/create'
    # params = {
    #     'project': Vars.sonar_project_token,
    #     'name': Vars.sonar_project_name,
    #     'visibility': Vars.sonar_project_visibility
    # }

    # username = 'admin'
    # password = 'admin'

    projects = sonar.projects.search_projects()
    if len(projects['components']) > 0:
        idem_project = False
        for project in projects['components']:
            if project['name'] == Vars.sonar_project_name:
                idem_project = True
                break
        if not idem_project:
            # requests.post(url, data=params, auth=HTTPBasicAuth(username=username, password=password), verify=False) # demo
            sonar.projects.create_project(project=Vars.sonar_project_token, name=Vars.sonar_project_name, visibility=Vars.sonar_project_visibility) # project = token
    else:
        # requests.post(url, data=params, auth=HTTPBasicAuth(username=username, password=password), verify=False) # demo
        sonar.projects.create_project(project=Vars.sonar_project_token, name=Vars.sonar_project_name, visibility=Vars.sonar_project_visibility) # project = token