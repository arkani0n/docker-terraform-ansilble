cd terrafrom
terraform init
terraform apply -auto-approve
public_ip=$(terraform output ec2-public-ip | jq "." -r)

cd ../ansible
cat > ./inventory <<EOF
[my-hosts]
$public_ip

[my-hosts:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=../my-ssh-key.pem
EOF

# Instance startup takes some time, and executing ansible right after creation of EC2 may result in error "Failed to connect to the host via ssh"
sleep 20
ansible-playbook my-playbook.yaml -i inventory