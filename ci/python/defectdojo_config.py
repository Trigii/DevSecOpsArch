import json
import os
import requests
import variables_config as Vars


def generate_defectdojo_token():
    print("---------------- GETTING DEFECTDOJO TOKEN ----------------")

    # Definir los datos de la solicitud de token de acceso
    token_data = {
        'username': Vars.defectdojo_username,
        'password': Vars.defectdojo_password
    }

    # Hacer una solicitud HTTP POST para obtener el token de acceso
    response = requests.post(Vars.defectdojo_url + '/api/v2/api-token-auth/', data=token_data, verify=False)

    # Comprobar si la solicitud fue exitosa y obtener el token de acceso
    if response.status_code == 200:
        token = json.loads(response.content)['token']
        return token
    else:
        print('ERROR: could not get the access token:', response.content)
        return None      

def create_defectdojo_prod_type(defectdojo_token):
    print("---------------- CREATING DEFECTDOJO PRODUCT TYPE ----------------")

    endpoint = Vars.defectdojo_url + '/api/v2/product_types/'
    HEADERS = {
        'Content-Type': 'application/json',
        'Authorization': f'Token {defectdojo_token}'
    }

    product_type_response = requests.get(endpoint, headers=HEADERS, verify=False)
    product_types = json.loads(product_type_response.content)
    if product_types['count'] == 0:
        product_type_data = {
            'name': Vars.defectdojo_product_type_name,
            'description': Vars.defectdojo_product_type_desc
        }

        product_type_response = requests.post(endpoint, headers=HEADERS, json=product_type_data, verify=False)

        if product_type_response.status_code == 201:
            product_type = json.loads(product_type_response.content)
            return product_type['id']
        else:
            print('ERROR: could not create product type:', product_type_response.content)
    else:
        return product_types['results'][0]['id']

def create_defectdojo_product(defectdojo_token, product_type_id):
    print("---------------- CREATING DEFECTDOJO PRODUCT ----------------")

    endpoint = Vars.defectdojo_url + '/api/v2/products/'
    HEADERS = {
        'Content-Type': 'application/json',
        'Authorization': f'Token {defectdojo_token}'
    }
    
    product_response = requests.get(endpoint, headers=HEADERS, verify=False)
    products = json.loads(product_response.content)
    if products['count'] == 0:
        product_data = {
            'name': Vars.defectdojo_product_name,
            'description': Vars.defectdojo_product_desc,
            'prod_type': product_type_id
        }

        product_response = requests.post(endpoint, headers=HEADERS, json=product_data, verify=False)

        if product_response.status_code == 201:
            product = json.loads(product_response.content)
            return [product['id'], product['name']]
        else:
            print('ERROR: could not create the product', product_response.content)
    else:
        return [products['results'][0]['id'], products['results'][0]['name']]

def create_defectdojo_engagement(defectdojo_token, product_id):
    print("---------------- CREATING DEFECTDOJO ENGAGEMENT ----------------")

    endpoint = Vars.defectdojo_url + '/api/v2/engagements/'
    HEADERS = {
        'Content-Type': 'application/json',
        'Authorization': f'Token {defectdojo_token}'
    }
    
    ########### Crear el engagement #############
    engagement_response = requests.get(endpoint, headers=HEADERS, verify=False)
    engagements = json.loads(engagement_response.content)
    if engagements['count'] == 0:
        engagement_data = {
            'name': Vars.defectdojo_engagement_name,
            'description': Vars.defectdojo_engagement_desc,
            'product': product_id,
            'target_start': f"{Vars.defectdojo_engagement_start}",
            'target_end': f"{Vars.defectdojo_engagement_end}",
            'engagement_type': Vars.defectdojo_engagement_type
        }

        engagement_response = requests.post(endpoint, headers=HEADERS, json=engagement_data, verify=False)

        if engagement_response.status_code == 201:
            engagement = json.loads(engagement_response.content)
            return engagement['id']
        else:
            print('ERROR: could not create the engagement', engagement_response.content)
    else:
        return engagements['results'][0]['id']
    
def import_results(engagement_id, defectdojo_token, product_name):
    print("---------------- IMPORTING RESULTS TO DEFECTDOJO ----------------")
    
    endpoint = f'{Vars.defectdojo_url}/api/v2/import-scan/'

    scan_types = ["Trivy Scan", "Trufflehog Scan", "ZAP Scan", "Semgrep JSON Report", "SonarQube Scan"]

    HEADERS = {
        'Authorization': f'Token {defectdojo_token}'
    }

    for type in scan_types:
        if type == 'Trivy Scan' and os.path.isfile(f'{Vars.gitlab_reports_path}/cis-trivy.json') and os.path.isfile(f'{Vars.gitlab_reports_path}/iac-trivy.json'):
            with open(f'{Vars.gitlab_reports_path}/cis-trivy.json', 'rb') as f:
                file = f.read()
            files = {"file": ("cis-trivy.json", file, "application/json")}
            data = {
                'active': True,
                'verified': True,
                'scan_type': type,
                'engagement': engagement_id,
                'product_name': product_name
            }
            requests.post(endpoint, headers=HEADERS, data=data, files = files, verify=False)

            with open(f'{Vars.gitlab_reports_path}/iac-trivy.json', 'rb') as f:
                file = f.read()
            files = {"file": ("iac-trivy.json", file, "application/json")}
            data = {
                'active': True,
                'verified': True,
                'scan_type': type,
                'engagement': engagement_id,
                'product_name': product_name
            }
            requests.post(endpoint, headers=HEADERS, data=data, files = files, verify=False)

        elif type == 'Trufflehog Scan' and os.path.isfile(f'{Vars.gitlab_reports_path}/trufflehog.json'):
            with open(f'{Vars.gitlab_reports_path}/trufflehog.json', 'rb') as f:
                file = f.read()
            files = {"file": ("trufflehog.json", file, "application/json")}
            data = {
                'active': True,
                'verified': True,
                'scan_type': type,
                'engagement': engagement_id,
                'product_name': product_name
            }
            requests.post(endpoint, headers=HEADERS, data=data, files = files, verify=False)

        elif type == 'SonarQube Scan' and os.path.isfile(f'{Vars.gitlab_reports_path}/sonar-report.html'):
            with open(f'{Vars.gitlab_reports_path}/sonar-report.html', 'rb') as f:
                file = f.read()
            files = {"file": ("sonar-report.html", file, "text/html")}
            data = {
                'active': True,
                'verified': True,
                'scan_type': type,
                'engagement': engagement_id,
                'product_name': product_name
            }
            requests.post(endpoint, headers=HEADERS, data=data, files = files, verify=False)

        elif type == "Semgrep JSON Report" and os.path.isfile(f'{Vars.gitlab_reports_path}/semgrep.json'):
            with open(f'{Vars.gitlab_reports_path}/semgrep.json', 'rb') as f:
                file = f.read()
            files = {"file": ("semgrep.json", file, "application/json")}
            data = {
                'active': True,
                'verified': True,
                'scan_type': type,
                'engagement': engagement_id,
                'product_name': product_name
            }
            requests.post(endpoint, headers=HEADERS, data=data, files = files, verify=False)

        elif type == "ZAP Scan" and os.path.isfile(f'{Vars.gitlab_reports_path}/zap-results.xml'):
            with open(f'{Vars.gitlab_reports_path}/zap-results.xml', 'rb') as f:
                file = f.read()
            files = {"file": ("zap-results.xml", file, "application/xml")}
            data = {
                'active': True,
                'verified': True,
                'scan_type': type,
                'engagement': engagement_id,
                'product_name': product_name
            }
            requests.post(endpoint, headers=HEADERS, data=data, files = files, verify=False)