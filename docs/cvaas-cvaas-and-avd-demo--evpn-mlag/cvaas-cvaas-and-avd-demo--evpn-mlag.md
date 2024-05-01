# CVaaS and AVD Demo, EVPN MLAG

## Demo Details

!!! Success "Container Requirements"

    CPUs: 4  
    Memory: 16 GB  
    Storage: 32 GB  

    :material-checkbox-marked-outline: Works with default Codespaces sizing!

[Start "CVaaS and AVD Demo, EVPN MLAG" in Codespace](https://codespaces.new/arista-netdevops-community/one-click-se-demos?quickstart=1&devcontainer_path=.devcontainer%2Fcvaas-cvaas-and-avd-demo--evpn-mlag%2Fdevcontainer.json){ .md-button .md-button--primary target=_blank}

[Slides](https://arista-netdevops-community.github.io/one-click-se-demos/slides/cvaas-cvaas-and-avd-demo--evpn-mlag.html){ target=_blank }  
[PDF Slides](https://arista-netdevops-community.github.io/one-click-se-demos/pdfs/cvaas-cvaas-and-avd-demo--evpn-mlag.pdf){ target=_blank }  

!!! Info "Last reviewed: 01/05/2024"

    Demos and labs reviewed over 6 month age may be outdated.

## Lab Topology

![lab topology](img/small-l3ls-mlag.png)

## How To Run The Demo

???+ Tip "Wait until cEOS-lab image will be imported"

    You can confirm if image was imported correctly with `docker image ls`.  
    In some rare cases the cEOS-lab image may fail to be downloaded.
    For example due to incorrecte token or other API failure on arista.com.  
    In that case you can upload the image manually by right-clicking the Explorer tab of the VSCode interface.

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

Connect to a host (h01 or h02) and execute `test` alias to confirm connectivity.  
Execute following commands to verify EVPN control plane:

- `show ip bgp summary`
- `show bgp evpn summary`
- `show bgp evpn route-type ip-prefix ipv4`
- `show bgp evpn route-type mac-ip`

1. !!! Tip "Review and execute the change control on CVP when all tasks will be created."
2. !!! Bug "Currently there is a bug with disabling LLDP on Ma0, which prevents topology view from functioning correctly."

!!! Warning "Lab Documents Not Finished"

    This document is created from a Cookiecutter template.
    If you see this message - the lab is not finished and likely published for testing purposes.
    Don't use it unless you are the author.
