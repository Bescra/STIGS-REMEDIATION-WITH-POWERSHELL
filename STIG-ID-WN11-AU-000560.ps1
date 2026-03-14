<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 audits successful
    "Other Logon/Logoff Events" to comply with STIG requirement WN11-AU-000560.

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 14 Mar 2026
    Last Modified   : 14 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000560

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    This script ensures the Advanced Audit Policy:
    "Other Logon/Logoff Events" audits successful events.

    Example syntax:
    PS C:\> .\remediation_WN11-AU-000560.ps1
#>

$Subcategory = "Other Logon/Logoff Events"

Write-Host "Checking compliance for WN11-AU-000560..."

$currentSetting = auditpol /get /subcategory:"$Subcategory"

if ($currentSetting -match "Success") {
    Write-Host "System already compliant."
}
else {
    Write-Host "System non-compliant. Applying remediation..."

    auditpol /set /subcategory:"$Subcategory" /success:enable

    Write-Host "Remediation complete."
}

Write-Host "Current audit configuration:"
auditpol /get /subcategory:"$Subcategory"
