# Seaside-terraform-lab

terraform init 
terraform plan
terraform apply --auto-approve

User Data :

#!/bin/bash\n
sudo yum install -y git
git clone https://github.com/Zero0x00/seasides-cloud-ec2-lab.git
cd seasides-cloud-ec2-lab/
python3 -m venv lab-venv 
source lab-venv/bin/activate
pip3 install -r requirment.txt
nohup python3 -m flask run --host=0.0.0.0 --port=8001 &
echo $?
