# Author: GitHub/n4kull
# PowerShell script to update all installed applications using winget

Write-Host "Updating all installed applications using winget..." -ForegroundColor Green

# Run the winget command to update all applications with acceptance flags
try {
    winget upgrade --all --accept-source-agreements --accept-package-agreements
    Write-Host "Update process completed." -ForegroundColor Green
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}

# Wait for user input before closing
Read-Host -Prompt "Press Enter to exit"
