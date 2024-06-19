import yaml


def get_values():
    with open('ansible/applications/env_variables', 'r') as f:
        variables = yaml.safe_load(f)

    #####################
    # VULNAPP VARIABLES #
    #####################
    global vulnapp_url, vulnapp_path

    vulnapp_url = variables['vuln_app']['repo_url']
    vulnapp_path = variables['vuln_app']['repo_path']

    ####################
    # GITLAB VARIABLES #
    ####################
    global gitlab_user, gitlab_token, gitlab_api_url, gitlab_url 
    global gitlab_project_name, gitlab_project_description, gitlab_project_readme, gitlab_project_visibility
    global gitlab_repo_path, gitlab_reports_path

    gitlab_user = variables['gitlab']['token']['user']
    gitlab_token = variables['gitlab']['token']['string']
    gitlab_api_url = variables['gitlab']['api_url']
    gitlab_url = variables['gitlab']['url']
    gitlab_project_name = variables['gitlab']['project']['name']
    gitlab_project_description = variables['gitlab']['project']['description']
    gitlab_project_readme = variables['gitlab']['project']['initialize_with_readme']
    gitlab_project_visibility = variables['gitlab']['project']['visibility']
    gitlab_repo_path = variables['gitlab']['repo_path']
    gitlab_reports_path = variables['gitlab']['reports_path']

    ###################
    # SONAR VARIABLES #
    ###################
    global sonar_url, sonar_username, sonar_password
    global sonar_project_token, sonar_project_name, sonar_project_visibility
    global sonar_gitlab_key, sonar_token_name

    sonar_url = variables['sonarqube']['url']
    sonar_username = variables['sonarqube']['username']
    sonar_password = variables['sonarqube']['password']
    sonar_project_token = variables['sonarqube']['project']['token']
    sonar_project_name = variables['sonarqube']['project']['name']
    sonar_project_visibility = variables['sonarqube']['project']['visibility']
    sonar_gitlab_key = variables['sonarqube']['gitlab']['key']
    sonar_token_name = variables['sonarqube']['token']['name']

    ########################
    # DEFECTDOJO VARIABLES #
    ########################
    global defectdojo_url, defectdojo_username, defectdojo_password
    global defectdojo_product_type_name, defectdojo_product_type_desc
    global defectdojo_product_name, defectdojo_product_desc
    global defectdojo_engagement_name, defectdojo_engagement_desc, defectdojo_engagement_start, defectdojo_engagement_end, defectdojo_engagement_type

    defectdojo_url = variables['defectdojo']['url']
    defectdojo_username = variables['defectdojo']['username']
    defectdojo_password = variables['defectdojo']['password']
    defectdojo_product_type_name = variables['defectdojo']['product_type']['name']
    defectdojo_product_type_desc = variables['defectdojo']['product_type']['description']
    defectdojo_product_name = variables['defectdojo']['product']['name']
    defectdojo_product_desc = variables['defectdojo']['product']['description']
    defectdojo_engagement_name = variables['defectdojo']['engagement']['name']
    defectdojo_engagement_desc = variables['defectdojo']['engagement']['description']
    defectdojo_engagement_start = variables['defectdojo']['engagement']['target_start']
    defectdojo_engagement_end = variables['defectdojo']['engagement']['target_end']
    defectdojo_engagement_type = variables['defectdojo']['engagement']['type']
    