Import-Module ActiveDirectory

$cutoff = (Get-Date).AddDays(-30)

$inactive = Get-ADUser -Filter {LastLogonDate -lt $cutoff -and Enabled -eq $true} `
    -Properties LastLogonDate, Department |
    Select-Object Name, SamAccountName, Department, LastLogonDate

$inactive | Format-Table -AutoSize
$inactive | Export-Csv "C:\InactiveUsers.csv" -NoTypeInformation

Write-Host "Report saved to C:\InactiveUsers.csv" -ForegroundColor Green
