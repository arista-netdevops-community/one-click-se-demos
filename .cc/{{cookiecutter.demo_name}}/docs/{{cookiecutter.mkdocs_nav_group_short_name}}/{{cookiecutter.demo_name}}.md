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

[Start The EVPN AA Demo](https://codespaces.new/arista-netdevops-community/one-click-se-demos?quickstart=1&devcontainer_path=.devcontainer%2Favd_cvaas_evpn_aa%2Fdevcontainer.json){ .md-button .md-button--primary target=_blank}

[Slides](https://arista-netdevops-community.github.io/one-click-se-demos/slides/avd_cvaas.html){ target=_blank }  
[PDF Slides](https://arista-netdevops-community.github.io/one-click-se-demos/pdfs/avd_cvaas.pdf){ target=_blank }  

!!! Info "Last reviewed: 05.2024"

    Demos and labs review over 6 month age may be outdated.

## How To Run The Demo

???+ Tip "Wait until cEOS-lab image will be imported"

    You can confirm if image was imported correctly with `docker image ls`

```bash
# 1. start cLab
make start
```

???+ Tip "Wait until all devices will start streaming to CVaaS."

    This may take a while.

```bash
# 2. build configs with AVD
make build
# 3. create CVP change control (1)
make deploy_cvp
# 4. assign tags for CVP topology view (2)
make tags
# 5. validate the deployment with ANTA preview
make test
```

1. !!! Tip "Review and execute the change control on CVP when all tasks will be created."
2. !!! Bug "Currently there is a bug with disabling LLDP on Ma0, which prevents topology view from functioning correctly."
