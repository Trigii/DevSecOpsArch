import urllib3
import variables_config as Vars
import sonar_config as Sonar
import gitlab_config as Gitlab
import defectdojo_config as Defectdojo
import repo_config as Repo
import reports_config as Reports


def main():
    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning) # disable SSL warnings
    
    Vars.get_values()

    Sonar.init_sonar()

    project = Gitlab.create_gitlab_project()
    Gitlab.create_gitlab_k8_secrets(project.attributes['id'])
    Gitlab.set_gitlab_project_variables(project.attributes['id'])

    repo = Repo.clone_gitlab_project(project)
    Repo.clone_vuln_app(repo)
    Repo.copy_pipeline(repo)
    Repo.push_to_gitlab(repo)

    Reports.get_job_artifacts(project.attributes['id'])
    Reports.get_sonar_report()
    Reports.get_zap_report()
    
    defectdojo_token = Defectdojo.generate_defectdojo_token()
    product_type_id = Defectdojo.create_defectdojo_prod_type(defectdojo_token)
    product = Defectdojo.create_defectdojo_product(defectdojo_token, product_type_id)
    engagement_id = Defectdojo.create_defectdojo_engagement(defectdojo_token, product[0])
    Defectdojo.import_results(engagement_id=engagement_id, defectdojo_token=defectdojo_token, product_name=product[1])


if __name__ == "__main__":
    main()