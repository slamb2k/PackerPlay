# j0vgbZQJcQ3r
# zfS8W7tU7lQ7

$env:PACKER_LOG=1
$env:PACKER_LOG_PATH="packerlog.txt"

$rgName = "PackerResourceGroup"
$location = "Australia East"
New-AzureRmResourceGroup -Name $rgName -Location $location

$spUser = "AzureTestPacker"
$spPass = "P@ssw0rd!"

$sp = New-AzureRmADServicePrincipal -DisplayName $spUser -Password (ConvertTo-SecureString $spPass -AsPlainText -Force)
Start-Sleep 20

$clientId = $sp.ApplicationId.Guid
$objectId = $sp.Id.Guid

New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $sp.ApplicationId

$sub = Get-AzureRmSubscription

$tenantId = $sub.TenantId[0]
$subscriptionId = $sub.SubscriptionId[0]

"Client Id: $clientId" 
"Client Secret: $spPass"
"Tenant Id: $tenantId"
"Subscription Id: $subscriptionId"
"Object Id: $objectId"

Start-Process -FilePath 'packer.exe' -ArgumentList "build -var `"client_id=$clientId`" -var `"client_secret=$spPass`" -var `"tenant_id=$tenantId`" -var `"subscription_id=$subscriptionId`" -var `"object_id=$objectId`" .\windows.json" -Wait -NoNewWindow


