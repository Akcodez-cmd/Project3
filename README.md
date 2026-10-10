# Project 3: AWS Infrastructure Automation with Terraform and GitHub Actions

## Overview

This project automates the setup of a small web server on AWS using Terraform and GitHub Actions. Instead of creating the resources manually in the AWS Console, the infrastructure is defined as code and deployed through a workflow.

## What I Built

- An AWS VPC with two public subnets across two Availability Zones.
- An Internet Gateway and route table to provide internet routing.
- A security group that allows HTTP traffic on port 80.
- An EC2 `t3.micro` instance running Nginx.
- An Elastic IP associated with the EC2 instance.
- An S3 bucket for storing Terraform remote state, with versioning and encryption enabled.
- A GitHub Actions workflow to format-check, initialize, validate, generate a Terraform plan, upload the plan artifact, and apply the approved plan.
- AWS authentication for GitHub Actions using OpenID Connect (OIDC), rather than storing AWS access keys in GitHub secrets.

## Tools Used

- AWS (VPC, EC2, IAM, S3, Elastic IP, Security Groups)
- Terraform
- GitHub Actions
- AWS IAM OIDC
- Nginx
- Git and GitHub

## Deployment Check

The GitHub Actions workflow completed successfully for both **Validate and Plan** and **Apply Approved Plan**. I also tested the deployed website from my computer using `curl`; it returned `HTTP/1.1 200 OK` and served the Project 3 HTML page.

Website: http://13.207.241.86/

> The public IP may stop working if the AWS resources are destroyed or the Elastic IP is released.

## Run Locally

From the project root, initialize and review the infrastructure:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform validate
terraform -chdir=terraform plan
```

To create the infrastructure after reviewing the plan:

```bash
terraform -chdir=terraform apply
```

To remove the Terraform-managed infrastructure when finished:

```bash
terraform -chdir=terraform destroy
```

Review the plan carefully before applying or destroying resources. AWS charges may apply while resources are running. The S3 state bucket is configured as a remote backend and should be handled separately if you decide to remove it.

## Repository Structure

```text
Folder PATH listing
Volume serial number is 6867-8B64
C:.
│   .gitignore
│
├───.github
│   └───workflows
│           terraform.yml
│
└───terraform
    │   .terraform.lock.hcl
    │   main.tf
    │   outputs.tf
    │   providers.tf
    │   variables.tf
    │   versions.tf
    │
    ├───.terraform
    │   │   terraform.tfstate
    │   │
    │   ├───modules
    │   │       modules.json
    │   │
    │   └───providers
    │       └───registry.terraform.io
    │           └───hashicorp
    │               └───aws
    │                   └───6.68.0
    │                       └───windows_amd64
    │                               LICENSE.txt
    │                               terraform-provider-aws_v6.68.0_x5.exe
    │
    └───modules
        ├───compute
        │       main.tf
        │       outputs.tf
        │       variables.tf
        │
        └───network
                main.tf
                outputs.tf
                variables.tf
```