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

ansible-playbook my-playbook.yaml -i inventory