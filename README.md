# Seaside-terraform-lab
```bash
terraform init

terraform plan

terraform apply --auto-approve

### EC2 Instance Initialization Script

This script is designed to be used as part of the user data for an Amazon EC2 instance. It automates the setup of a Python environment and runs a Flask application.

```bash
#!/bin/bash

# Install Git
sudo yum install -y git

# Clone the GitHub repository
git clone https://github.com/Zero0x00/seasides-cloud-ec2-lab.git

# Navigate to the repository directory
cd seasides-cloud-ec2-lab/

# Create a Python virtual environment
python3 -m venv lab-venv
source lab-venv/bin/activate

# Install required Python packages
pip3 install -r requirements.txt

# Start the Flask application
nohup python3 -m flask run --host=0.0.0.0 --port=8001 &

# Display the exit code
echo $?

