---
marp: true
theme: default
class: invert
author: Petr Ankudinov
# size 16:9 1280px 720px
size: 16:9
paginate: true
style: |
    :root {
      background: linear-gradient(to bottom, #000000, #434343);
    }
    img[alt~="custom"] {
      float: right;
    }
    .columns {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 1rem;
    }
    footer {
      font-size: 14px;
    }
    section::after {
      font-size: 14px;
    }
---

# Building Containerlab with cEOS

## Workshop

<!-- Do not add page number on this slide -->
<!--
_paginate: false
-->

```text
How to build a lab environment
with Containerlab and cEOS-lab

Petr Ankudinov, 2024
```

![bg right fit](img/clab-build-containerlab-with-ceos/containerlab_export_white_ink.svg)

---

# Agenda

<style scoped>section {font-size: 20px;}</style>

![bg right opacity:80%](img/pexels-suzy-hazelwood-1226398.jpg)

- Setup Docker on the host
- Install Containerlab and import cEOS-lab image
- Deploy the lab
- Inspect and destroy the lab
- Deploy the lab with a custom startup config
- Make a packet capture
- cLab in a Container
- Possible caveats

> This workshop is a step-by-step guide explaining how to build a lab environment with [Containerlab](https://containerlab.srlinux.dev/) and Arista cEOS-lab. It is  focusing on essential and cEOS-lab specific features. Please check [Containerlab documentation](https://containerlab.srlinux.dev/) for more details.

---

# How To Run The Workshop

<style scoped>section {font-size: 24px;}</style>

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

---

# CPU Architechture

- Only x86 CPU architecture is supported!
- It is technically possible to [run Container lab on ARM](https://containerlab.dev/install/#containerlab-on-arm-based-macs), but there are no network device images available for ARM as of May 2024.

---

# Setup Docker on the Host

<style scoped>section {font-size: 22px;}</style>

<div class="columns">
<div>

> Check if Docker is already installed. In this case you can skip the steps below.

1. Install Docker on the host. The detailed instructions are available [here](https://docs.docker.com/engine/install/ubuntu/). You can used one-liner script for that.
2. Add your user to the `docker` group.
3. Logout and login again to apply the changes.
4. Check the Docker version and run `hello-world` container to test functionality.
5. You must be able to run `docker` commands without `sudo` if it was installed correctly.

</div>
<div>

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

</div>
</div>

---

# Setup Git (Optional)

<style scoped>section {font-size: 26px;}</style>

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

---

# Download cEOS-lab Image

<style scoped>section {font-size: 20px;}</style>

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

![bg right h:720](img/clab-build-containerlab-with-ceos/ceos-download.png)

---

# Import cEOS-lab Image

<style scoped>section {font-size: 22px;}</style>

1. Go to the directory with the uploaded image and import the image:

    ```bash
    docker import cEOS-lab-4.30.2F.tar.xz ceos-lab:4.30.2F
    ```

    > NOTE: you can also import the image with the tag latest to allow quick "upgrade" of those lab where specific version is not required: `docker tag ceos-lab:4.30.2F ceos-lab:latest`

2. Confirm that the image was imported successfully:

    ```console
    $ docker image ls
    REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
    ceos-lab      4.30.2F   21b540a4a343   45 minutes ago   1.95GB
    ceos-lab      latest    21b540a4a343   45 minutes ago   1.95GB
    hello-world   latest    b038788ddb22   3 months ago     9.14kB
    ```

---

# Install Containerlab

<style scoped>section {font-size: 22px;}</style>

- It's just a one-liner:
  
  ```bash
  bash -c "$(curl -sL https://get.containerlab.dev)"
  ```

- Refer to the [Containerlab quick start documentation](https://containerlab.dev/quickstart/) for the details.

---

to-be-defined

---

<style scoped>section {font-size: 45px;}</style>

![bg left opacity:80%](img/pexels-ann-h-7186206.jpg)

# Q&A

- [Containerlab](https://containerlab.srlinux.dev/)
- [This repository](https://github.com/{{gh.repository}})
