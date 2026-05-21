Import-Module ActiveDirectory

$locked = Search-ADAccount -LockedOut

if ($locked) {
    foreach ($user in $locked) {
        Unlock-ADAccount -Identity $user.SamAccountName
        Write-Host "UNLOCKED: $($user.SamAccountName)" -ForegroundColor Green
    }
} else {
    Write-Host "No locked accounts found." -ForegroundColor Cyan
}
