# ADO Repo Transfer

A PowerShell script to easily migrate Git repositories to Azure DevOps by updating the remote origin.

## Description

This script helps you transfer a local Git repository to a new Azure DevOps repository by:
1. Removing the current remote 'origin' (if it exists)
2. Adding a new 'origin' pointing to the specified Azure DevOps repository
3. Pushing all branches to the new remote

## Requirements

- PowerShell
- Git command-line tools
- A local Git repository
- An Azure DevOps organization and project with a repository already created

## Usage

### Interactive Mode

Run the script without parameters to enter interactive mode:

```text
Usage: Ado-Repo-Transfer.ps1 [targetFolder] [orgName] [projectName] [repoName]
This script updates the remote 'origin' of a Git repository located in a specified folder.

Parameters:
  targetFolder    - Target repository folder path
  orgName         - Azure DevOps Organization Name
  projectName     - Azure DevOps Project Name
  repoName        - Remote Repo Name

If parameters are not provided, you will be prompted for them.

Sample usage:
  .\Ado-Repo-Transfer.ps1 -h
  .\Ado-Repo-Transfer.ps1 /?
  .\Ado-Repo-Transfer.ps1
  .\Ado-Repo-Transfer.ps1 C:\MyRepo MyOrg MyProject MyRepo
  .\Ado-Repo-Transfer.ps1 -targetFolder C:\MyRepo -orgName MyOrg -projectName MyProject -repoName MyRepo  
```
