param (
    [Parameter(Position=0, Mandatory=$false)]
    [string]$targetFolder,
    
    [Parameter(Position=1, Mandatory=$false)]
    [string]$orgName,
    
    [Parameter(Position=2, Mandatory=$false)]
    [string]$projectName,
    
    [Parameter(Position=3, Mandatory=$false)]
    [string]$repoName,
    
    [Parameter(Mandatory=$false)]
    [Alias('h')]
    [switch]$help
)

# Check for help request - need to check the raw command line to catch "/?"
if ($help -or $MyInvocation.Line -match '\s\/\?' -or $MyInvocation.Line -match '\s\-h(?:elp)?\b') {
    Write-Host "Usage: Ado-Repo-Transfer.ps1 [targetFolder] [orgName] [projectName] [repoName]"
    Write-Host "This script updates the remote 'origin' of a Git repository located in a specified folder."
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  targetFolder    - Target repository folder path"
    Write-Host "  orgName         - Azure DevOps Organization Name"
    Write-Host "  projectName     - Azure DevOps Project Name"
    Write-Host "  repoName        - Remote Repo Name"
    Write-Host ""
    Write-Host "If parameters are not provided, you will be prompted for them."
    Write-Host ""
    Write-Host "Sample usage:"
    Write-Host "  .\Ado-Repo-Transfer.ps1 -h"
    Write-Host "  .\Ado-Repo-Transfer.ps1 /?"
    Write-Host "  .\Ado-Repo-Transfer.ps1"
    Write-Host "  .\Ado-Repo-Transfer.ps1 C:\MyRepo MyOrg MyProject MyRepo"
    Write-Host "  .\Ado-Repo-Transfer.ps1 -targetFolder C:\MyRepo -orgName MyOrg -projectName MyProject -repoName MyRepo"
    exit 0
}

# Ask for target folder path if not provided as parameter
if (-not $targetFolder) {
    $targetFolder = Read-Host -Prompt "Enter the target repository folder path"
}
if (-not (Test-Path $targetFolder)) {
    Write-Host "Target folder does not exist. Exiting."
    exit 1
}
Push-Location $targetFolder

# Ask for input details if not provided as parameters
if (-not $orgName) {
    $orgName = Read-Host -Prompt "Enter your Azure DevOps Organization Name"
}
if (-not $projectName) {
    $projectName = Read-Host -Prompt "Enter your Azure DevOps Project Name"
}
if (-not $repoName) {
    $repoName = Read-Host -Prompt "Enter your Remote Repo name"
}

# Remove the current remote 'origin' if it exists
try {
    git remote remove origin
    Write-Host "Removed existing remote 'origin'."
} catch {
    Write-Host "No existing remote 'origin' found. Skipping removal."
}

# Construct the new remote URL
$remoteUrl = "https://$orgName@dev.azure.com/$orgName/$projectName/_git/$repoName"
Write-Host "New remote URL will be: $remoteUrl"

# Add the new remote 'origin'
git remote add origin $remoteUrl
Write-Host "Added new remote 'origin'."

# Push all branches to the new remote
git push -u origin --all
Write-Host "Pushed all branches to remote 'origin'."

Pop-Location