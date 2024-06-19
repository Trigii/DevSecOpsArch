import os
import shutil
import gc
from time import sleep
import git
import variables_config as Vars
from git import Repo


def clone_gitlab_project(project):
    if not os.path.exists(Vars.gitlab_repo_path):
        print("---------------- CLONING GITLAB PROJECT ----------------")
        repo_url = project.attributes['http_url_to_repo']
        new_repo_url = repo_url.replace('https://', f'https://{Vars.gitlab_user}:{Vars.gitlab_token}@')
        repo = Repo.clone_from(new_repo_url, Vars.gitlab_repo_path, env={'GIT_SSL_NO_VERIFY': '1'})
        return repo
    else:
        repo = git.Repo(Vars.gitlab_repo_path)
        return repo

def onerror(func, path, exc_info):
    """
    Error handler for ``shutil.rmtree``.

    If the error is due to an access error (read only file)
    it attempts to add write permission and then retries.

    If the error is for another reason it re-raises the error.
    
    Usage : ``shutil.rmtree(path, onerror=onerror)``
    """
    import stat
    # Is the error an access error?
    if not os.access(path, os.W_OK):
        os.chmod(path, stat.S_IWUSR)
        func(path)
    else:
        raise

def clone_vuln_app(repo):
    if repo is not None:
        print("---------------- DOWNLOADING VULNERABLE APP ----------------")
        repo = Repo.clone_from(f"{Vars.vulnapp_url}", Vars.vulnapp_path, env={'GIT_SSL_NO_VERIFY': '1'})
        gc.collect()
        repo.git.clear_cache()
        sleep(3)
        shutil.rmtree(f'{Vars.vulnapp_path}/.git', ignore_errors=False, onerror=onerror)
        sleep(3)

        if os.path.exists(f'{Vars.gitlab_repo_path}/{Vars.vulnapp_path}'):
            shutil.rmtree(f'{Vars.gitlab_repo_path}/{Vars.vulnapp_path}', ignore_errors=False, onerror=onerror)
            sleep(3)
        
        shutil.copytree(Vars.vulnapp_path, f'{Vars.gitlab_repo_path}/{Vars.vulnapp_path}')
        gc.collect()
        repo.git.clear_cache()
        sleep(3)

        shutil.rmtree(Vars.vulnapp_path, ignore_errors=False, onerror=onerror)

def copy_pipeline(repo):
    if repo is not None:
        print("---------------- COPYING PIPELINE ----------------")
        source = 'ci/.gitlab-ci.yml'
        destination = f'{Vars.gitlab_repo_path}/.gitlab-ci.yml'
        if os.path.exists(destination):
            os.remove(destination)

        shutil.copy(source, destination)

def push_to_gitlab(repo):
    if repo is not None:
        print("---------------- UPDATING GITLAB REPO ----------------")
        
        repo = Repo(Vars.gitlab_repo_path)

        repo.git.add([Vars.vulnapp_path, '.gitlab-ci.yml'])
        repo.index.commit("Agregar la app vulnerable y el pipeline al proyecto de Gitlab")
        
        # Configurar variable de entorno GIT_SSL_NO_VERIFY
        os.environ['GIT_SSL_NO_VERIFY'] = 'true'

        origin = repo.remote(name='origin')
        origin.push()