Import-Module ActiveDirectory

$csvPath = "C:\Users\Administrator\Documents\New Employees.csv"
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    $first = $user.First.Trim()
    $last = $user.Last.Trim()
    $employeeID = $user.'Employee number'

    if ([string]::IsNullOrWhiteSpace($first) -or [string]::IsNullOrWhiteSpace($last)) {
        Write-Host "Skipping blank or invalid row..."
        continue
    }

    $samAccountName = "$($first.Substring(0,1))$last"
    $password = ConvertTo-SecureString "Monday123!" -AsPlainText -Force

    New-ADUser -Name "$first $last" -GivenName $first -Surname $last -SamAccountName $samAccountName -EmployeeID $employeeID -Path "OU=Employee,DC=corp115,DC=local" -AccountPassword $password -ChangePasswordAtLogon $true -Enabled $true

    Write-Host "Created user: $samAccountName"
}