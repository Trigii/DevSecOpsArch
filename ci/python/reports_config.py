import os
import subprocess
import time
import zipfile
import requests
import variables_config as Vars

def get_job_artifacts(project_id):
    print("---------------- DOWNLOADING JOB ARTIFACTS ----------------")

    # Headers para la autenticación con el token
    headers = {
        'PRIVATE-TOKEN': Vars.gitlab_token
    }

    project_branch = 'main'
    jobs_name = ['iac-trivy-scan', 'container-image-trivy-scan', 'sca-semgrep-scan', 'secret-scanning-trufflehog-scan']    
    pipelines_url = f"{Vars.gitlab_api_url}/projects/{project_id}/pipelines"

    # bucle de espera del pipeline
    while True:
        time.sleep(6) # espera 6 segundos antes de volver a comprobar el estado
        
        response = requests.get(pipelines_url, headers=headers, verify=False)
        latest_pipeline_status = response.json()[0]["status"]

        if latest_pipeline_status == "success" or latest_pipeline_status == "failed":
            break

    for job in jobs_name:
        # Endpoint para crear un nuevo proyecto
        endpoint = f'{Vars.gitlab_api_url}/projects/{project_id}/jobs/artifacts/{project_branch}/download'
        params = {'job': job}

        # Realizamos la petición HTTP POST para crear el proyecto
        response = requests.get(endpoint, headers=headers, params=params, verify=False)
        
        # Comprobamos si la petición ha sido exitosa
        if response.status_code == 200:
            with open(f'{Vars.gitlab_reports_path}/artifact.zip', 'wb') as f:
                f.write(response.content)
            with zipfile.ZipFile(f'{Vars.gitlab_reports_path}/artifact.zip', 'r') as zip_ref:
                zip_ref.extractall(Vars.gitlab_reports_path)
            os.remove(f'{Vars.gitlab_reports_path}/artifact.zip')
        else:
            print(f"ERROR: could not download artifact: {response.content}")

def get_sonar_report():
    print("---------------- DOWNLOADING SONAR REPORT ----------------")

    command = f"/bin/bash -c \"source ~/.nvm/nvm.sh && nvm use 17.9.1 && sonar-report --sonarurl={Vars.sonar_url} --sonarusername={Vars.sonar_username} --sonarpassword={Vars.sonar_password} --project={Vars.sonar_project_name} --sonarcomponent={Vars.sonar_project_token} --branch=\"main\" --output=\"{Vars.gitlab_reports_path}/sonar-report.html\" --allbugs --coverage\""
    try:
        subprocess.run(command, shell=True, check=True)
    except:
        print("ERROR: Sonar-report not found. Check if its downloaded on your OS")

def get_zap_report():
    print("---------------- DOWNLOADING OWASP ZAP REPORT ----------------")

    scan_name_query = "kubectl get jobs -n zap -l securecodebox.io/job-type=scanner -o=jsonpath='{.items[0].metadata.name}'"
    scan_name = subprocess.run(scan_name_query, shell=True, check=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip().replace("'", "")
    wait_scan_query = f"kubectl wait --for=condition=complete job/{scan_name} -n zap"
    subprocess.run(wait_scan_query, shell=True, check=True)
    
    parser_name_query = "kubectl get jobs -n zap -l securecodebox.io/job-type=parser -o=jsonpath='{.items[0].metadata.name}'"
    parser_name = subprocess.run(parser_name_query, shell=True, check=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip().replace("'", "")
    wait_parser_query = f"kubectl wait --for=condition=complete job/{parser_name} -n zap"
    subprocess.run(wait_parser_query, shell=True, check=True)

    # minio_query = "kubectl get pods -n securecodebox-system -l app.kubernetes.io/name=minio -o=jsonpath='{.items[0].metadata.name}'" # esto se puso en la demo ya que no funcionaba lo de abajo
    minio_query = "kubectl get pods -n securecodebox-system -l app=minio -o=jsonpath='{.items[0].metadata.name}'"
    minio_pod_name = subprocess.run(minio_query, shell=True, check=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip().replace("'", "")

    # findings_path_query = f"kubectl exec -it {minio_pod_name} -n securecodebox-system -- bash -c 'find /data/securecodebox/*/zap-results.xml -name xl.meta'" # esto se puso en la demo ya que lo de abajo no funcionaba
    findings_path_query = f"kubectl exec -it {minio_pod_name} -n securecodebox-system -- find /export/securecodebox/ -name zap-results.xml"
    findings_paths = subprocess.run(findings_path_query, shell=True, check=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip()
    lines = findings_paths.splitlines()
    findings_path = lines[-1]

    get_findings_query = f"kubectl exec -it {minio_pod_name} -n securecodebox-system -- cat {findings_path} > {Vars.gitlab_reports_path}/zap-results.xml"
    subprocess.run(get_findings_query, shell=True, check=True)