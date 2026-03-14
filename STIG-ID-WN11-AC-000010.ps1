<#
.SYNOPSIS
    This PowerShell script ensures that the account lockout threshold is configured
    to three invalid logon attempts or fewer to comply with Windows 11 STIG WN11-AC-000010.

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 14 Mar 2026
    Last Modified   : 14 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    This script ensures the system locks accounts after three failed logon attempts.

    Example syntax:
    PS C:\> .\remediation_WN11-AC-000010.ps1
#>

$ExpectedThreshold = 3

Write-Host "Checking compliance for WN11-AC-000010..."

$current = net accounts

if ($current -match "Lockout threshold:\s+$ExpectedThreshold") {

    Write-Host "System already compliant."

} else {

    Write-Host "System non-compliant. Applying remediation..."

    net accounts /lockoutthreshold:$ExpectedThreshold

    Write-Host "Remediation applied."
}

Write-Host ""
Write-Host "Current account policy configuration:"
net accounts
