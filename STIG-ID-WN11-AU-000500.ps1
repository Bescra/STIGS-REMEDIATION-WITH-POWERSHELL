<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 13 Mar 2026
    Last Modified   : 13 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# WN10-AU-000500 STIG Remediation Script
# Ensures Application Event Log maximum size is set to 32768 KB

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$ExpectedValue = 32768

Write-Host "Checking STIG WN10-AU-000500 compliance..."

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
