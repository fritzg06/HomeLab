#requires -version 2
<#
.SYNOPSIS
  People Planner web.config checker for switchValue logging level
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

$ppRootDir = "C:\inetpub\People Planner Web Apps 4.2.0 CU01-566"
#$ppDirs = Get-ChildItem -Path $ppRootDir | Where-Object {$_.Name -like "*API*" -or $_.Name -like "*MyPlan*" -or $_.Name -like "*Web*"}
$ppDirs = Get-ChildItem -Path $ppRootDir

#-------------------------------------------------[Functions]--------------------------------------------------

function goToPPDir {
    cd $ppRootDir
}

function checkSwitchValueLineWebConfig {

    foreach ($ppDir in $ppDirs) {
        $configFiles = @(Get-ChildItem -Path $ppDir | Where-Object {$_.Name -like "web.config"} | Select Fullname)
    
        foreach ($configFile in $configFiles) {
        Write-Host "`n"
        Write-Host ([string]($configFile.FullName)) -ForegroundColor Green
        (Get-Content ([string]($configFile.FullName)) | Select-String -Pattern "switchValue") -Replace "`r",", "
        }
    }
}

#-------------------------------------------------[Execution]--------------------------------------------------

goToPPDir
checkSwitchValueLineWebConfig