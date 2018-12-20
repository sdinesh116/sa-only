# Configure Microsoft Azure Provider
provider "azurerm" {
	subscription_id = "${var.subscription_id}"
	client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${var.resource_group}"
    }

    byte_length = 8
}

# Create Storage Account
resource "azurerm_storage_account" "testsa" {
	name 				= "${var.sa_name}${random_id.randomId.hex}"
	location			= "${var.location}"
	resource_group_name		= "${var.resource_group}"
	account_tier			= "Standard"
	account_replication_type 	= "LRS"
}

