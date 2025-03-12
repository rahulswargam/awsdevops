#!/bin/bash

# Prompt user for number of EC2 instances to create
echo "How many EC2 Instances do you want to create?"
read instance_count

if ! [[ "$instance_count" =~ ^[0-9]+$ ]] || [ "$instance_count" -le 0 ]; then
    echo "Please enter a valid number greater than 0."
    exit 1
fi

instance_names=()
user_data_files=()

# Loop through each instance to get its name and determine user_data file
for ((i=1; i<=instance_count; i++))
do
    echo "Enter Name for Instance $i:"
    read instance_name
    instance_names+=("$instance_name")

    # Convert instance name to lowercase for case-insensitive matching
    instance_name_lower=$(echo "$instance_name" | tr '[:upper:]' '[:lower:]')

    # Assign user_data based on instance name
    if [[ "$instance_name_lower" == *"-master"* ]]; then
        user_data_files+=("master_userdata.sh")
    elif [[ "$instance_name_lower" == *"-slave"* || "$instance_name_lower" == *"-agent"* ]]; then
        user_data_files+=("slave_userdata.sh")
    else
        user_data_files+=("master_userdata.sh") # Default to master_userdata.sh
    fi
done

# Convert arrays to Terraform list format with commas
instance_names_list=$(printf '"%s", ' "${instance_names[@]}" | sed 's/, $//')
user_data_list=$(printf '"%s", ' "${user_data_files[@]}" | sed 's/, $//')

# Save variables to Terraform tfvars file
cat <<EOF > terraform.tfvars
instance_count = $instance_count
instance_names = [$instance_names_list]
user_data = [$user_data_list]
EOF

echo "Terraform Variables File Created: terraform.tfvars"

# Initialize Terraform
terraform init

# Apply Terraform configuration
terraform apply -auto-approve

echo "EC2 Instances Created Successfully!"