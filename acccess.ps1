$msiName="myid3"
$msiObjectId = "$(Get-AzureADServicePrincipal -Filter "DisplayName eq '$msiName'").ObjectId"
# Windows Azure Active Directory
$GraphAppId = "00000002-0000-0000-c000-000000000000" 
$GraphServicePrincipal = Get-AzureADServicePrincipal `
        -Filter "appId eq '$GraphAppId'"

$PermissionName = "Application.ReadWrite.OwnedBy"
$AppRole = $GraphServicePrincipal.AppRoles  `
       | Where-Object {$_.Value -eq $PermissionName `
       -and $_.AllowedMemberTypes -contains "Application"}
       
New-AzureAdServiceAppRoleAssignment `
    -ObjectId $msiObjectId `
    -PrincipalId $msiObjectId  `
    -ResourceId $GraphServicePrincipal.ObjectId `
    -Id $AppRole.Id
