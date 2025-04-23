# JumpHost VM Deployment

This folder contains Bicep templates for deploying a debugging Virtual Machine (VM) to any specified spoke in your CAF Compliant Azure environment. The JumpHost VM is intended for debugging and troubleshooting purposes.

## Features

- Creates a resource group for the JumpHost VM.
- Deploys a Windows-based VM with the following configurations:
  - Pre-configured network security group (NSG) rules to allow RDP (port 3389).
  - Public IP address for remote access.
  - Virtual network and subnet for the VM.

## Prerequisites

Before deploying the JumpHost VM, ensure the following:

1. The tenant must be CAF compliant.
2. The user must have Devdeer.Caf pwsh module installed.
