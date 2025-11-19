This repo contains:
- docker and docker-compose files for nginx with custom configuration
- terraform files to create vpc with ec2 in aws
- ansible playbook to install docker and run nginx with custom config on the ec2 instance

Requirements:
- Terraform v1.11.4
- Python 3.12
- Ansible 2.19.4
- Docker 26.1.3 (only if you'd like to build and run container locally)

How to make it work:
1. add you aws access key and secret key to `./terraform/variables.tf`
2. If you'd like to have terraform backend as S3 bucket, you'll need to create it and update bucket name in `./terraform/backend.tf`
3. Generate ssh key:
    - paste public key to `./terraform/variables.tf` variable `ec2-public-key`
    - paste privater key in `./my-ssh-key.pem`
4. run `./script.sh` -- it will run terraform init and apply, create inventory file for ansible, and using it will make nginx container run on created instance



