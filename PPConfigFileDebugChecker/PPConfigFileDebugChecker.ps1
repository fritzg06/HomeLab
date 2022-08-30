#requires -version 4
<#
.SYNOPSIS
  People Planner web.config checker for switchValue logging level, PeoplePlannerService.exe.config, PeoplePlanner.exe.config
.DESCRIPTION
  None
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        0.01
  Author:         Fritz Reyes
  Creation Date:  30 Aug 2022
  Purpose/Change: Initial script development
#>

#------------------------------------------------[Declarations]------------------------------------------------

# Web Service Directory
#$ppDirs = Get-ChildItem -Path $ppRootDir | Where-Object {$_.Name -like "*API*" -or $_.Name -like "*MyPlan*" -or $_.Name -like "*Web*"}
$ppRootDir = "C:\inetpub\People Planner Web Apps 4.2.0 CU01-566"

# PP Service Directory
$ppRootDirService = "C:\Program Files (x86)\Deltek\People Planner Service 4.2.0 CU01-566"

# PP Client Directory
$ppRootDirClient = "C:\Program Files (x86)\Deltek\People Planner 4.2.0 CU01-566"

#-------------------------------------------------[Functions]--------------------------------------------------

function checkWebServiceSwitchValueLineWebConfig {
    
    if (Test-Path -Path $ppRootDir) {

        cd $ppRootDir

        $ppDirs = Get-ChildItem -Path $ppRootDir

        foreach ($ppDir in $ppDirs) {
            $configFiles = @(Get-ChildItem -Path $ppDir | Where-Object {$_.Name -eq "web.config"} | Select Fullname)
    
            foreach ($configFile in $configFiles) {
            Write-Host "`n"
            Write-Host ([string]($configFile.FullName)) -ForegroundColor Green
            (Get-Content ([string]($configFile.FullName)) | Select-String -Pattern "switchValue") -Replace "`r",", "
            }
        }
    }
}

function checkPPServiceExeConfig {

    if (Test-Path -Path $ppRootDirService) {

    cd $ppRootDirService

    $configFile = @(Get-ChildItem -Path $ppRootDirService | Where-Object {$_.Name -eq "PeoplePlannerService.exe.config"} | Select Fullname)
    Write-Host "`n"
    Write-Host ([string]($configFile.FullName)) -ForegroundColor Green
    (Get-Content ([string]($configFile.FullName)) | Select-String -Pattern "switchValue") -Replace "`r",", "
    }
}


function checkPPClientExeConfig {

    if (Test-Path -Path $ppRootDirClient) {

    cd $ppRootDirClient

    $configFile = @(Get-ChildItem -Path $ppRootDirClient | Where-Object {$_.Name -eq "PeoplePlanner.exe.config"} | Select Fullname)
    
    Write-Host "`n"
    Write-Host ([string]($configFile.FullName)) -ForegroundColor Green
    (Get-Content ([string]($configFile.FullName)) | Select-String -Pattern "switchValue") -Replace "`r",", "
    }
}

#-------------------------------------------------[Execution]--------------------------------------------------

checkWebServiceSwitchValueLineWebConfig
checkPPServiceExeConfig
checkPPClientExeConfig