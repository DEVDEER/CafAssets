# Management Resources

The terraform templates in this folder are used to deploy the management resources that are required in every single management group. These resources include:

- s subscription named `iam-management`
  - a resource group called `rg-management`
    - a key vault called (i.e. for storing service principal credentials) `akv-[companyShort]-[projectName]`