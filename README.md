# aws-vpc

A layered Terraform layout for AWS: a reusable VPC component, per-environment
compositions (dev, stage, prod), service modules on top, and remote state in S3
with DynamoDB locking. Written in 2023 as a structure exercise for repeatable
environments.

## Layout

```
base/
├── global/state/            # S3 bucket + DynamoDB table for remote state and locking
├── global-backend.tf/.hcl   # partial S3 backend config, filled in at `terraform init`
├── modules/
│   ├── components/vpc/      # VPC, public/private subnets, IGW, NAT, routing, bastion, SGs
│   └── services/
│       ├── djangopoc/       # ECS cluster + ASG + ALB + CloudWatch logs for a Django container
│       └── webserver-cluster/
├── dev/ stage/ prod/        # environment compositions that call the modules with their own CIDRs
├── examples/                # standalone webserver-cluster example
└── main.tf                  # wires the environment VPCs together
```

## How it's used

1. Create the state backend once: `terraform -chdir=base/global/state init && terraform -chdir=base/global/state apply`
2. Initialise the root with the backend settings: `terraform -chdir=base init -backend-config=global-backend.hcl`
3. Plan and apply per environment from `base/`.

Every environment passes its own `vpc_cidr` and subnet lists, so dev, stage and
prod get non-overlapping address space from the same VPC module.

## Status

- The VPC component, the remote-state setup, and the `djangopoc` ECS service are complete.
- `dev/services/liferay` references a `modules/services/liferay` module that was never
  committed, so that composition is a stub.
- `base/tmp/` holds scratch copies of the global files.
- Container images in `djangopoc` default to an `<AWS_ACCOUNT_ID>` placeholder.
