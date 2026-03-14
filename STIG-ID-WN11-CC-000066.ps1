<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 includes command line data in process creation events.

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 14 Mar 2026
    Last Modified   : 14 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000066

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000066).ps1 
#>

# WN11-CC-000066 STIG Remediation Script
# Ensures command line data is included in process creation events

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"
$ValueName = "ProcessCreationIncludeCmdLine_Enabled"
$ExpectedValue = 1

Write-Host "Checking STIG WN11-CC-000066 compliance..."

# Step 1: Ensure registry path exists
if (!(Test-Path $RegistryPath)) {
    Write-Host "Registry path missing. Creating..."
    New-Item -Path $RegistryPath -Force | Out-Null
    Write-Host "Registry path created."
}

# Step 2: Check existing value
$currentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

if ($null -eq $currentValue) {
    Write-Host "Registry value missing. Creating value..."
    New-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ExpectedValue -PropertyType DWORD -Force | Out-Null
    Write-Host "Value created and set to $ExpectedValue."
}
elseif ($currentValue -ne $ExpectedValue) {
    Write-Host "Incorrect value detected ($currentValue). Updating..."
    Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ExpectedValue
    Write-Host "Value updated to $ExpectedValue."
}
else {
    Write-Host "System already compliant."
}

# Step 3: Verification
$finalValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName
Write-Host "Final configured value: $finalValue"
