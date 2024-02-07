# SDE-Storage

Site Design Engineering AutoCAD Cloud Storage Solution

## Project Structure

### File Structure
- `.gitignore`: Specifies intentionally untracked files to ignore.
- `Setup`: Folder containing setup scripts and configuration files.
- `main.tf`: Terraform file to manage infrastructure.
- `providers.tf`: Terraform providers configuration file.

### Resources
#### `azurerm_storage_account "sitedesign-storage-account"`
This resource is used to create a new storage account in Azure. The parameters are:

- `name`: The name of the storage account.
- `resource_group_name`: The name of the resource group in which to create the storage account.
- `location`: The location/region in which to create the storage account.
- `account_tier`: The performance tier of the storage account. In this case, it is "Standard".
- `account_replication_type`: The type of replication used for this storage account. In this case, it is "LRS" (Locally redundant storage).

`azurerm_storage_share "sitedesign-share"`
This resource is used to create a new storage share within the Azure Storage Account. The parameters are:

- `name`: The name of the storage share.
- `storage_account_name`: The name of the storage account in which to create the storage share.
- `quota`: The maximum size of the storage share in GB.

`azurerm_virtual_network "sitedesign_vnet"`
This resource is used to create a new virtual network in Azure. The parameters are:

- `name`: The name of the virtual network.

`azurerm_subnet "sitedesign_subnet"`
This resource is used to create a new subnet within a specific virtual network. The parameters are:

- `name`: The name of the subnet.
- `resource_group_name`: The name of the resource group in which to create the subnet.
- `virtual_network_name`: The name of the virtual network in which to create the subnet.
- `address_prefix`: The address prefix to use for the subnet.

`azurerm_virtual_network_gateway "sitedesign_vpn_gateway"`
This resource is used to create a new virtual network gateway in Azure. The parameters are:

- `name`: The name of the virtual network gateway.
- `location`: The location/region in which to create the virtual network gateway. This is derived from the location of the resource group.
- `resource_group_name`: The name of the resource group in which to create the virtual network gateway. This is derived from the name of the resource group.
- `type`: The type of the gateway. In this case, it is "Vpn".
- `vpn_type`: The type of VPN. In this case, it is "RouteBased".
- `active_active`: Whether or not the gateway should be active-active. In this case, it is set to false.
- `enable_bgp`: Whether or not BGP (Border Gateway Protocol) should be enabled. In this case, it is set to false.
- `sku`: The SKU of the gateway. In this case, it is "VpnGw1".
- `ip_configuration`: The IP configuration for the gateway. This is a block of parameters that includes the name of the configuration, which in this case is "vnetGatewayConfig".

## Getting Started

### Prerequisites

- Terraform
- PowerShell
- Azure CLI

### Setup

1. Clone the repository.
2. Navigate to the `Setup` folder.
3. Run the setup scripts and follow the instructions.

### Usage

#### Terraform

- `terraform init`: Initializes your Terraform workspace by creating initial files, loading any remote state, downloading modules, etc.
- `terraform plan`: Creates an execution plan, showing what actions Terraform will take to achieve the desired state defined in the configuration files.
- `terraform apply`: Applies the changes required to reach the desired state of the configuration.
- `terraform destroy`: Destroys the Terraform-managed infrastructure.

