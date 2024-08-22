# Management Resources

The terraform templates in this folder are used to deploy the management resources that are required in every single subscription. These resources include:

- a resource group called `rg-management`
  - a storage account (i.e. for storing debugging logs) called `sto[companyShort][projectName]`
  - a key vault called (i.e. for storing service principal credentials) `akv-[companyShort]-[projectName]`
  - a network watcher called `nw-[companyShort]-[projectName]`