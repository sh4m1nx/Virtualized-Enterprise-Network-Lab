Get-ADUser -Filter * -SearchBase "OU=Employee,DC=corp115,DC=local" | 
Select-Object Name, SamAccountName | Out-File -FilePath "C:\Users\Administrator\Documents\EmployeeList.txt" -Encoding utf8 

Write-Host "Export completed successfully to C:\Users\Administrator\Documents\EmployeeList.txt