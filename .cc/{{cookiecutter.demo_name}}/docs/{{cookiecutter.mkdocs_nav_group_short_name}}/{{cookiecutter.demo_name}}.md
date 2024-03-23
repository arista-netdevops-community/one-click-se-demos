# {{ cookiecutter.mkdocs_nav_demo_full_name }}

## Demo Details

{%- if cookiecutter.container_size.cpus in ["2", "4"] %}
!!! Success "Container Requirements"

    CPUs: {{ cookiecutter.container_size.cpus }}  
    Memory: {{ cookiecutter.container_size.memory }}  
    Storage: {{ cookiecutter.container_size.storage }}  

    :material-checkbox-marked-outline: Works with default Codespaces sizing!
{%- else %}
!!! Warning "Container Requirements"

    CPUs: {{ cookiecutter.container_size.cpus }}  
    Memory: {{ cookiecutter.container_size.memory }}  
    Storage: {{ cookiecutter.container_size.storage }}  

    :material-alert-circle-outline:{ .heartbeat } Please request high spec Codespace machines from [Github support](https://support.github.com/) first!
{%- endif %}

[Start The EVPN AA Demo](https://codespaces.new/{{ cookiecutter.gh_org_name }}/{{ cookiecutter.gh_repo_name }}?quickstart=1&devcontainer_path=.devcontainer%2Favd_cvaas_evpn_aa%2Fdevcontainer.json){ .md-button .md-button--primary target=_blank}

[Slides](https://{{ cookiecutter.gh_org_name }}.github.io/{{ cookiecutter.gh_repo_name }}/slides/avd_cvaas.html){ target=_blank }  
[PDF Slides](https://{{ cookiecutter.gh_org_name }}.github.io/{{ cookiecutter.gh_repo_name }}/pdfs/avd_cvaas.pdf){ target=_blank }  

!!! Info "Last reviewed: {% now 'local', '%d/%m/%Y' %}"

    Demos and labs review over 6 month age may be outdated.

## How To Run The Demo

???+ Tip "Wait until cEOS-lab image will be imported"

    You can confirm if image was imported correctly with `docker image ls`

!!! Warning "Lab Documents Not Finished"

    This document is created from a Cookiecutter template.
    If you see this message - the lab is not finished and likely published for testing purposes.
    Don't use it unless you are the author.
