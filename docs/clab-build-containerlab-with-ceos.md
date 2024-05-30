# Build Containerlab with cEOS

!!! Info "What is this workshop about"

    This workshop is a step-by-step guide explaining how to build a lab environment with [Containerlab](https://containerlab.srlinux.dev/) and Arista cEOS-lab. It is  focusing on essential and cEOS-lab specific features. Please check [Containerlab documentation](https://containerlab.srlinux.dev/) for more details.

!!! Warning "Lab Documents Not Finished"

    DO NOT ENTER! :skull_and_crossbones:{ .heartbeat }

    ![stay back](assets/img/pexels-danne-555709.jpg)

    This document is created from a Cookiecutter template.
    If you see this message - the lab is not finished and likely published for testing purposes.
    Don't use it unless you are the author.

## Demo Details

!!! Success "Container Requirements"

    CPUs: 4  
    Memory: 16 GB  
    Storage: 32 GB  

    :material-checkbox-marked-outline: Works with default Codespaces sizing!

[Start "Build Containerlab with cEOS" in Codespace](https://codespaces.new/{{gh.repository}}?quickstart=1&devcontainer_path=.devcontainer%2Fclab-build-containerlab-with-ceos%2Fdevcontainer.json){ .md-button .md-button--primary target=_blank}

[Slides](https://{{gh.org_name}}.github.io/{{gh.repo_name}}/slides/clab-build-containerlab-with-ceos.html){ target=_blank }  
[PDF Slides](https://{{gh.org_name}}.github.io/{{gh.repo_name}}/pdfs/clab-build-containerlab-with-ceos.pdf){ target=_blank }  

!!! Info "Last reviewed: 30/05/2024"

    Demos and labs reviewed over 6 month age may be outdated.

## Lab Topology

![lab topology](assets/img/clab-build-containerlab-with-ceos/min-l3ls-mlag.png)

## How To Run The Lab on Your Machine

It is possible to run the lab on your local machine (or any server) instead of using Github Codespaces.  
You can [download all required lab files here](https://arista-netdevops-community.github.io/one-click-se-demos/lab_archives/clab-build-containerlab-with-ceos.tar.gz).  
However you must take care of you VSCode setup and setting up environment variables. Also keep in mind that auto-downloaded image will not work on ARM-based MacBooks.

## How To Run The Workshop

???+ Tip "Wait until cEOS-lab image will be imported"

    You can confirm if image was imported correctly with `docker image ls`.  
    In some rare cases the cEOS-lab image may fail to be downloaded.
    For example due to incorrecte token or other API failure on arista.com.  
    In that case you can upload the image manually by right-clicking the Explorer tab of the VSCode interface.

To run the labs in this workshop, you can use one of the following options:

- Build you own Ubuntu VM from scratch. (Recommended!)
  - This option will allow you to experience the entire cLab enviroment build process from the very start, without any pre-installed dependancies
  - Requirements
    - Ubuntu LTS 22.04 or later
    - 8 GB RAM and 4 vCPUs
- Start the [Github Codespace](https://codespaces.new/{{gh.repository}}?quickstart=1&devcontainer_path=.devcontainer%2Fclab-build-containerlab-with-ceos%2Fdevcontainer.json) from this repository. (Fastest!)
- Open the lab dev container locally on your laptop with Docker Desktop or sever with Docker CE:
  - you can [download required files here](https://arista-netdevops-community.github.io/one-click-se-demos/lab_archives/clab-build-containerlab-with-ceos.tar.gz) and open them in VSCode
  - when running the lab locally, you must set all required environment variables on your machine

## CPU Architechture

- Only x86 CPU architecture is supported!
- It is technically possible to [run Container lab on ARM](https://containerlab.dev/install/#containerlab-on-arm-based-macs), but there are no network device images available for ARM as of May 2024.

## Setup Docker on the Host

> Check if Docker is already installed. In this case you can skip the steps below.

1. Install Docker on the host. The detailed instructions are available [here](https://docs.docker.com/engine/install/ubuntu/). You can used one-liner script for that.
2. Add your user to the `docker` group.
3. Logout and login again to apply the changes.
4. Check the Docker version and run `hello-world` container to test functionality.
5. You must be able to run `docker` commands without `sudo` if it was installed correctly.

```bash
# install Docker
sudo curl -fsSL https://get.docker.com | sh
# add user to the docker group
sudo usermod -aG docker ${USER}
# test docker
docker --version
docker run hello-world
```

> **NOTE**: If you are running this workshop in Codespace or provided dev container, Docker is pre-installed. As the workshop magic happens inside a container in this case, we rely on Docker-in-Docker concept to provide required functionality.

## Setup Git (Optional)

- Git must be pre-installed on a Linux system. Otherwise you are in a wrong place. Escape! 👾 🚀
- Setup your name and email address:

  ```bash
  git config --global user.name "<first-and-2nd-name>"
  git config --global user.email "<your-email>"
  ```

- Check the current configuration:

  ```bash
  git config --list
  ```

> **NOTE**: On Codespace Git is pre-installed and pre-configured.

## Download cEOS-lab Image

1. Login to [Arista Software Download](https://www.arista.com/en/support/software-download) portal. You need to have an account to download the image.
2. Select `EOS > Active Releases > 4.30 > EOS-4.30.6M > cEOS-lab`.
3. Download `cEOS-lab-4.30.6M.tar.xz` image.
4. Upload the image to your lab VM. For example, you can use SFTP to transfer the image:

  ```bash
  sftp ${REMOTE_USER}@${UBUNTU_VM_IP}:/home/${REMOTE_USER}/${IMAGE_DIR} <<< $'put cEOS-lab-4.30.6M.tar*'
  # for example:
  # sftp user@10.10.10.11:/home/user/images <<< $'put cEOS-lab-4.30.6M.tar*'
  ```

> If Github Codespace or provided Dev Container is used and the Arista token is set, the image will be pulled from arista.com automatically.

![bg right 80%](assets/img/clab-build-containerlab-with-ceos/ceos-download.png)

## Import cEOS-lab Image

1. Go to the directory with the uploaded image and import the image:

    ```bash
    docker import cEOS-lab-4.30.6M.tar.xz arista/ceos:4.30.6M
    ```

    > NOTE: you can also import the image with the tag latest to allow quick "upgrade" of those lab where specific version is not required: `docker tag arista/ceos:4.30.6M arista/ceos:latest`

2. Confirm that the image was imported successfully:

    ```console
    $ docker image ls
    REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
    arista/ceos      4.30.6M   21b540a4a343   45 minutes ago   1.95GB
    arista/ceos      latest    21b540a4a343   45 minutes ago   1.95GB
    hello-world   latest    b038788ddb22   3 months ago     9.14kB
    ```

## Install Containerlab

It's just a one-liner:

```bash
bash -c "$(curl -sL https://get.containerlab.dev)"
```

Refer to the [Containerlab quick start documentation](https://containerlab.dev/quickstart/) for the details.

> Containerlab is pre-installed if you are using Codespaces.
