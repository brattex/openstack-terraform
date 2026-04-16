# HPC ECOSYSTEMS PROJECT
## OpenStack Terraform files

*A matter of living in convenience*

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

