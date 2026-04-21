# HPC ECOSYSTEMS PROJECT
## OpenStack Terraform files

*A matter of living in convenience!!!*

***

### *Clean module paths, nested project folders, no `../../`, no global config*

This repository uses a **project‑local Terraform module registry** to provide:

- Clean module paths (`source = "role/webserver"`)
- Unlimited nested project folders
- No `../../` relative‑path nonsense		# This is a new feature 😂
- Local module development without pushing to Git
- A repo that “just works” when cloned on Linux/WSL/CI

This pattern is the closest thing Terraform has to a **project‑local chroot**, and it is fully supported. I hope!

---

## 🧱 1. Repository Layout

```hcl
OPENSTACK/                     # ← Repo root
  modules/                     # ← Real module source code
    compute/                   # ← Module: compute resources
    floatingip/                # ← Module: floating IP logic
    network/                   # ← Module: networks, subnets, routers
    role/                      # ← Role modules (webserver, runner, etc.)
      webserver/
      runner/
    security/                  # ← Security groups, rules, etc.

  terraform.d/                 # ← Project-local Terraform config (NOT global)
    terraform.rc               # ← Tells Terraform to load modules from terraform.d/modules
    modules/                   # ← Local module registry (symlinked to real modules)
      compute/                 # ← Symlink → ../../modules/compute
      floatingip/              # ← Symlink → ../../modules/floatingip
      network/                 # ← Symlink → ../../modules/network
      role/                    # ← Symlink → ../../modules/role
      security/                # ← Symlink → ../../modules/security

  projects/                    # ← All deployments live here
    dev/                       # ← Environment: dev
      webserver/               # ← Service type
        alpha/                 # ← Project instance
        beta/
      runner/
        gitlab/
    prod/                      # ← Environment: prod
      webserver/
        customer1/
        customer2/

  templates/                   # ← Starter templates for new projects
    gitlab-runner/
    webserver/

  tf.sh                        # ← Wrapper script so Terraform uses project-local config
  .gitignore
  README.md

```

---

## 🧭 2. Why This Structure Exists

Terraform normally resolves module paths **relative to the project folder**, 
which breaks as soon as you introduce nested project folders:

```hcl
projects/proj1 → ../../modules
projects/dev/proj2 → ../../../modules
projects/dev/webserver/proj3 → ../../../../modules

```

This is unmaintainable.

### How it works
Terraform is instructed to load modules from `terraform.d/modules`
regardless of where the project lives.

This gives you:

- Clean module paths  
- Unlimited nested project folders  
- No path rewrites  
- No global config  
- No Git pushes required to test module changes  

---

## ⚙️ 3. Project‑Local Terraform Config (`terraform.d/terraform.rc`)

```hcl
# terraform.d/terraform.rc
# ------------------------------------------------------------
# This file tells Terraform:
# "When someone writes source = 'role/webserver', load it from
#  terraform.d/modules/role/webserver instead of using relative paths."
#
# This gives you clean module paths and allows nested project folders
# without ever rewriting ../../ paths.

module_installation {
  filesystem_mirror {
    path    = "terraform.d/modules"   # ← Local module registry
    include = ["*"]                   # ← Include all modules
  }

  direct {
    exclude = ["*"]                   # ← Prevent Terraform from fetching modules from the internet
  }
}

# Wrapper Script

```hcl
#!/bin/bash
# tf.sh
# ------------------------------------------------------------
# This wrapper ensures Terraform uses the project-local config
# instead of ~/.terraformrc or global settings.
#
# Developers run Terraform like:
#   ./tf.sh init
#   ./tf.sh apply
#
# CI/CD can run plain `terraform` without using this wrapper.

export TF_CLI_CONFIG_FILE="$(pwd)/terraform.d/terraform.rc"
terraform "$@"
```

### Symlinks: How Modules are Exposed to Terraform

`terraform.d/modules/` contains *symlinks* pointing to the real module folders.

```
terraform.d/modules/role → ../../modules/role
```

This means:
- Terraform sees modules under `terraform.d/modules`
- You edit modules under `modules/`
- Symlinks update automatically
- Git preserves symlinks when cloning (maybe not with Windows)
- No duplication of the module core (symlinks!)

### Example:

`projects/dev/webserver/alpha/main.tf`

```hcl
# main.tf
# ------------------------------------------------------------
# This project uses the webserver role module.
# Thanks to terraform.d/terraform.rc, we can use clean module paths.

module "webserver" {
  source = "role/webserver"   # ← Clean, stable, no ../../
  name   = var.name           # ← Pass project-specific name
}

```

*Edit modules locally*
Edit files under `modules/role/webserver/*`

Terraform sees changes instantly because 
`terraform.d/modules/role → ../../modules/role`

- `git status` shows real module changes
- `git push` works normally

### Cloning Repo on Another Machine

Works!

# Project Naming Convention
proj-<role>-<name>

Examples:
proj-web-abc
proj-gpu-protein
proj-mail-test
proj-generic-sandbox

### TO DO

- new-project.sh to auto-create folder infrastructure using this pattern


Repo Layout
openstack-terraform/
├── modules/
│   ├── network/
│   ├── security/
│   │   ├── base/
│   │   ├── public-ssh/
│   │   ├── webserver/
│   │   ├── mailserver/
│   │   └── database/
│   ├── compute/
│   ├── floatingip/
│   └── role/
│       ├── public-facing/
│       ├── generic/
│       ├── mailserver/
│       └── database/
├── environments/
│   ├── dev/
│   │   └── main.tf
│   ├── staging/
│   │   └── main.tf
│   └── prod/
│       └── main.tf
└── README.md

## Layer 1 explain
### Layer 1 — Primitive modules

These are low‑level building blocks:

- modules/network
- modules/security/base

modules/security/public-ssh

modules/security/webserver

modules/security/mailserver

modules/compute

modules/floatingip

*Each module does one thing only.*


## Layer 2 explain
### Layer 2 — Role modules

These combine primitives into a VM “role”:

- modules/role/public-facing
- modules/role/generic

modules/role/mailserver

modules/role/database

Each role module:

pulls in the right security bundles

creates the port

creates the instance

optionally attaches a floating IP

exposes outputs like instance_id, floating_ip, etc.

