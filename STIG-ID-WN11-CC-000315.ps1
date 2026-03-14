<#
.SYNOPSIS
    This PowerShell script ensures that the Windows Installer "Always install with elevated privileges"
    policy is disabled to prevent unauthorized privilege escalation.

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 14 Mar 2026
    Last Modified   : 14 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    This script remediates the STIG finding by ensuring the registry value:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
    is set to 0.

    Example syntax:
    PS C:\> .\remediation_WN11-CC-000315.ps1
#>

# --------------------------------------------------------
# STIG ID: WN11-CC-000315
# Title: Disable Windows Installer Elevated Privileges
# --------------------------------------------------------

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$ValueName = "AlwaysInstallElevated"
$ExpectedValue = 0

Write-Host "Checking compliance for WN11-CC-000315..."

# Ensure registry path exists
if (!(Test-Path $RegistryPath)) {
    Write-Host "Registry path missing. Creating..."
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Get current value
$currentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

# Remediation if needed
if ($null -eq $currentValue -or $currentValue -ne $ExpectedValue) {

    Write-Host "System non-compliant. Applying remediation..."

    New-ItemProperty `
        -Path $RegistryPath `
        -Name $ValueName `
        -Value $ExpectedValue `
        -PropertyType DWORD `
        -Force | Out-Null

    Write-Host "Remediation complete."
}
else {
    Write-Host "System already compliant."
}

# Verification
$finalValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName
Write-Host "Configured value: $finalValue"
