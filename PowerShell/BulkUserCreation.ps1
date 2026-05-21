Import-Module ActiveDirectory

$users = Import-Csv "C:\users.csv"

foreach ($user in $users) {
    $username = $user.Username
    $exists = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue
    
    if ($exists) {
        Write-Host "SKIPPED - User already exists: $username" -ForegroundColor Yellow
    } else {
        New-ADUser `
            -Name $user.FullName `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -SamAccountName $username `
            -UserPrincipalName "$username@ruizmedical.local" `
            -Path "OU=$($user.Department),DC=ruizmedical,DC=local" `
            -AccountPassword (ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force) `
            -ChangePasswordAtLogon $true `
            -Enabled $true `
            -Department $user.Department

        Write-Host "CREATED: $username" -ForegroundColor Green
    }
}
