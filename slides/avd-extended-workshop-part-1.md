---
marp: true
theme: default
class: invert
author: Petr Ankudinov
# size 16:9 1280px 720px
size: 16:9
paginate: true
math: mathjax
style: |
    :root {
      background: linear-gradient(to bottom, #1e3744, #301B29);
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
    img {
      background-color: transparent;
    }
    pre {
        background: linear-gradient(to top, #1e3744, #301B29);
        background-color: transparent;
    }
---

# AVD Extended Workshop, Part 1

<!-- Do not add page number on this slide -->
<!--
_paginate: false
-->

```text
Intro into Ansible, Ansible AVD, Git
and VSCode for new and existing AVD users

Petr Ankudinov
                                    31/03/2024
```

![bg left fit](img/avd-logo.webp)

---

# What is this Workshop about?

<style scoped>section {font-size: 18px;}</style>

![bg right opacity:75%](img/pexels-suzy-hazelwood-1226398.jpg)

- This workshop is 3 sections:
  - Part 1, Intro:
    - Introducing the tools
    - Get the lab environment up and running
    - How to setup Ansible AVD environment
    - Run AVD playbooks
    - Make some changes in AVD repository
  - Part 2, Ansible and Git 101
  - Part 3, Common provisioning cases
- Each section requires around 2 hours to complete. The entire workshop can be complete in a single day or split into 3 seperate sessions.
- Make a break when you see a slide with a coffee cup ☕️
- Ask questions at any time!

---

# Test Dark

check topology on dark

![bg right fit](img/atd-dual-dc-left.png)

---

# Test Light

<style scoped>
section {background: linear-gradient(to bottom, #FFFFFF, #FFFFFF); color: black; }
h1 {color: black;}
</style>

check topology on light

![bg right fit](img/atd-dual-dc-left.png)

---

<style scoped>section {font-size: 45px;}</style>

![bg left opacity:75%](img/pexels-ann-h-7186206.jpg)

# Q&A

- [Ansible AVD](https://avd.arista.com/)
- [This repository](https://github.com/{{gh.repository}})
