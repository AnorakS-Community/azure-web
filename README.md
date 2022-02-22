# Web Application Terraform Template

This repository serves as a template which holds Terraform scripts that spins up an infrastruture of a web application using Azure services.

The Terraform scripts are organized into modules which provision individual services in the architecture.

## Services in the architecture

- Azure Kubernetes Service (AKS): this module provisions the creation of four clusters and links them to an Ingress controller.
The module creates a Kubernetes cluster and manages the ingress connectiuon with Helm.
    - Get the IP of new load balancer
    ```bash
    kubectl describe service ingress-nginx-ingress-controller
    ```

    - Send a curl request to the IP (this should give a 404 page )
    ```bash
    curl <ip of the load balancer>
    ```
**Setting the identity to ```SystemAssigned```, means that Azure will automatically create the required roles and permissions, and there is no need to manage any credentials.**

- Azure CDN: this module provisions the following - 
    - CDN Profile: Manages a Custom Domain for a CDN Endpoint.
    - DNS Zone: Enables you to manage DNS CNAME Records within Azure DNS.
    - DNS Cname Record
    - CDN Endpoint Custom Domain
    - CDN Endpoint
    - Storage Account and Container

- Azure Load Balancer: this module provisions the following -
    - Load Balancer
    - Public IP for load balancer
    - Load Balancer NAT rule

- Azure Database for PostgreSQL: This module manages a PostgreSQL Database within a PostgreSQL Server.
A PostgreSQL firewall was set up.

- Azure Cache for Redis: provides an in-memory data store based on the Redis software. Redis improves the performance and scalability of an application that uses backend data stores heavily. A firewall, enterprise cluster and enterprise databse were added.

- SSL Certificate: this module provisions the following - 
    - User Assigned Identity
    - Key Vault
    - key Vault Certificate
    - Virtual Network
    - Subnet (for frontend and backend services)
    - Public IP
    - Application Gateway
    - DDOS Protection


## Preliminary Steps
- To authenticate to the Azure provider, create an Active Directory service principal account by running the following commands:

```bash
terraform login tfe.cloudeng.cbre.com
```

## Spinning up the infrastructure

Run the following commands:
```bash
terraform init
terraform plan
terraform apply
```

## Uploading static website files to AZ storage
**To upload subsequent files to the created container via the Azure CLI, run the following command:**

```bash
az storage blob upload --account-name <storage-account-name> --container-name <container-name> --file <file-name> --content-type 'text/html; charset=utf-8 --auth-mode login'
```

**To upload a directory to the created container via the Azure CLI, run the following command:**

```bash
az storage blob upload-batch -s <folder-name> -d $(terraform output -raw container-name) --account-name ${terraform output -raw storage_account_name) --content-type 'text/html; charset=utf-8 --auth-mode login'
```

*Note: A destroy does not disable the website. You must first set enabled to false and apply. Then you can remove the resource*


## Configure Kubectl
After provisioning the cluster (running ```terraform apply```), retrieve the access credentials for the cluster and configure kubectl by running the following commands:

```bash
az aks get-credentials --name $(terraform output -raw cluster_name) --resource-group $(terraform output -raw resource_group) 

az aks browse --name $(terraform output -raw cluster_name) --resource-group $(terraform output -raw resource_group) 
```

