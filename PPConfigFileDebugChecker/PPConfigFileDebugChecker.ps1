$ppRootDir = "C:\inetpub\People Planner Web Apps 4.2.0 CU01-566"
#$ppDirs = Get-ChildItem -Path $ppRootDir | Where-Object {$_.Name -like "*API*" -or $_.Name -like "*MyPlan*" -or $_.Name -like "*Web*"}
$ppDirs = Get-ChildItem -Path $ppRootDir

cd $ppRootDir

foreach ($ppDir in $ppDirs) {
    $configFiles = @(Get-ChildItem -Path $ppDir | Where-Object {$_.Name -like "web.config"} | Select Fullname)
    
    foreach ($configFile in $configFiles) {
    Write-Host ([string]($configFile.FullName)) -ForegroundColor Green
    Get-Content ([string]($configFile.FullName)) | Select-String -Pattern "switchValue" 
    Write-Host "`n"
    }
}



