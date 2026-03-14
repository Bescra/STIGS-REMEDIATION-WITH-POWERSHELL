<#
.SYNOPSIS
    This PowerShell script ensures that the Windows 11 account lockout duration is configured to 15 minutes (900 seconds) or greater.

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 14 Mar 2026
    Last Modified   : 14 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  :
    PowerShell Ver. : 

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-AC-000005).ps1 
#>

# WN11-AC-000005 STIG Remediation Script
# Ensures Windows 11 account lockout duration is 15 minutes or greater

$ExpectedDuration = 15

Write-Host "Checking STIG WN11-AC-000005 compliance..."

# Step 1: Get current lockout duration
$CurrentDuration = (net accounts | Select-String "Lockout duration").ToString().Split(":")[1].Trim()

if ([int]$CurrentDuration -lt $ExpectedDuration) {

    Write-Host "Current lockout duration is $CurrentDuration minutes. Updating to $ExpectedDuration minutes..."

    # Step 2: Apply fix
    net accounts /lockoutduration:$ExpectedDuration | Out-Null

    Write-Host "Account lockout duration updated."

}
else {

    Write-Host "System already compliant."

}

# Step 3: Verification
$FinalDuration = (net accounts | Select-String "Lockout duration").ToString().Split(":")[1].Trim()

Write-Host "Final configured lockout duration: $FinalDuration minutes"
