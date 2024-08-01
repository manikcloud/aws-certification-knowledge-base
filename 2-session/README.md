This directory contains two scenarios for setting up VPCs using Terraform.

### 1-failed-scenario-same-cidr

This scenario demonstrates a failed attempt to create VPCs with the same CIDR block. The `main.tf` file in this directory contains the Terraform configuration for creating the VPCs. However, due to the overlapping CIDR blocks, the creation process will fail.

### 2-passed-scenario-diff-cidr

This scenario showcases a successful setup of VPCs with different CIDR blocks. The `main.tf` file in this directory contains the Terraform configuration for creating the VPCs. The CIDR blocks used in this scenario do not overlap, allowing the VPCs to be created without any issues.

Feel free to explore each scenario and the associated Terraform configurations to understand the differences and learn from the failed and successful scenarios.

## Prerequisites

- **Terraform**: Ensure Terraform is installed and configured on your local machine. This setup assumes Terraform 1.5 or later.

## Usage

1. Navigate to the desired scenario directory (`1-failed-scenario-same-cidr` or `2-passed-scenario-diff-cidr`).
2. Review the `main.tf` file to understand the Terraform configuration.
3. Run `terraform init` to initialize the Terraform configuration.
4. Use `terraform plan` to review the planned changes and ensure the configuration meets your expectations.
5. Apply the configuration using `terraform apply`. Terraform will prompt for confirmation before making any changes.
6. After applying the configuration, log in to the AWS Management Console to verify the created VPCs and associated resources.

## Cleanup

To remove the created resources, navigate to the scenario directory and run `terraform destroy`. Terraform will prompt for confirmation before deleting the resources.

