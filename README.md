# awx-deploy-terraform
# AWS EKS with AWX Control Plane Deployment

This Terraform configuration allows you to deploy an AWX control plane on AWS EKS. AWX is an open-source platform for managing and automating infrastructure and applications through Ansible.

## Prerequisites

Before you begin, ensure that you have the following prerequisites:

- AWS CLI installed and configured with valid credentials.
- Terraform CLI installed (version 1.0.0 or later).
- AWS IAM permissions to create resources such as EKS cluster, EC2 instances, etc.
- Basic knowledge of Terraform and AWS services.

## Deployment Steps

Follow the steps below to deploy the AWX control plane on AWS EKS:

1. Clone the repository or download the Terraform configuration files.

2. Modify the variables in the `variables.tf` file according to your requirements. Some variables you might want to update include AWS region, cluster name, instance types, etc.

3. Initialize the Terraform project by running the following command:

   ```shell
   terraform init
   ```

4. Review the execution plan to ensure everything is configured correctly:

   ```shell
   terraform plan
   ```

5. If the plan looks good, apply the changes to create the infrastructure:

   ```shell
   terraform apply
   ```

6. Confirm the deployment by typing `yes` when prompted.

7. Terraform will provision the AWS EKS cluster, node group, namespaces, and other required resources. The deployment may take several minutes.

8. Once the deployment is complete, the AWX control plane will be up and running on your AWS EKS cluster.

## Accessing AWX

To access the AWX web interface, perform the following steps:

1. Obtain the AWS EKS cluster details:

   ```shell
   aws eks update-kubeconfig --region <region> --name <cluster_name>
   ```

   Replace `<region>` with the AWS region where you deployed the cluster and `<cluster_name>` with the name of your AWS EKS cluster.

2. Install `kubectl` to interact with the cluster.

3. Verify that you can connect to the cluster:

   ```shell
   kubectl get nodes
   ```

4. Retrieve the AWX control plane service URL:

   ```shell
   kubectl get svc -n awx
   ```

   Locate the external IP address or DNS name of the AWX service.

5. Access the AWX web interface by opening a web browser and entering the AWX service URL.

6. Log in to AWX using the default credentials (admin/admin). It is recommended to change the password after the initial login.

## Clean Up

To clean up and destroy the resources created by the Terraform configuration, run the following command:

```shell
terraform destroy
```

Enter `yes` when prompted to confirm the destruction of resources. Please note that this action is irreversible and will delete all resources associated with the deployment.

## Conclusion

Congratulations! You have successfully deployed the AWX control plane on AWS EKS using Terraform. You can now utilize AWX to manage and automate your infrastructure and applications through Ansible.

If you encounter any issues or have further questions, please consult the Terraform documentation or reach out to the maintainers of this Terraform configuration.

Happy automation with AWX and Terraform!