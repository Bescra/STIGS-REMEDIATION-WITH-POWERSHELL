<#
.SYNOPSIS
    This PowerShell script ensures the built-in Guest account is renamed
    to comply with Windows 11 STIG requirement WN11-SO-000025.

.NOTES
    Author          : Rubem Tavares
    LinkedIn        : linkedin.com/in/rubem-tavares-77900a258
    GitHub          : github.com/Bescra
    Date Created    : 14 Mar 2026
    Last Modified   : 14 Mar 2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000025

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    This script renames the built-in Guest account to "guest_disabled".

    Example syntax:
    PS C:\> .\remediation_WN11-SO-000025.ps1
#>

$NewGuestName = "guest_disabled"

Write-Host "Checking compliance for WN11-SO-000025..."

# Get the built-in guest account via SID
$GuestAccount = Get-LocalUser | Where-Object {$_.SID -like "*-501"}

if ($GuestAccount.Name -ne $NewGuestName) {

    Write-Host "Guest account name is '$($GuestAccount.Name)'. Renaming..."

    Rename-LocalUser -Name $GuestAccount.Name -NewName $NewGuestName

    Write-Host "Guest account successfully renamed to '$NewGuestName'."

}
else {

    Write-Host "System already compliant."

}

Write-Host ""
Write-Host "Current Guest account configuration:"
Get-LocalUser | Where-Object {$_.SID -like "*-501"}
