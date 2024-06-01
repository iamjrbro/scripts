
# Define the McAfee product codes (example, adjust based on actual product codes)
$mcAfeeProductCodes = @(
    "{ProductCode1}",
    "{ProductCode2}",
    "{ProductCode3}"
)

foreach ($productCode in $mcAfeeProductCodes) {
    $uninstallString = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" |
                        Where-Object { $_.PSChildName -eq $productCode }).UninstallString
    if ($uninstallString) {
        Start-Process "msiexec.exe" -ArgumentList "/x $productCode /qn" -Wait
        Write-Output "Uninstalled McAfee product with code: $productCode"
    } else {
        Write-Output "Product code $productCode not found."
    }
}

# Additional cleanup (if necessary)
# Remove McAfee specific directories, services, etc.
Remove-Item "C:\Program Files\McAfee" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files (x86)\McAfee" -Recurse -Force -ErrorAction SilentlyContinue

# Stop and remove McAfee services
$mcAfeeServices = @("McAfeeService1", "McAfeeService2")
foreach ($service in $mcAfeeServices) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}








// {ProductCode1}, {ProductCode2}, e {ProductCode3} pelos códigos de produto do McAfee 
------Registro do Windows:  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
