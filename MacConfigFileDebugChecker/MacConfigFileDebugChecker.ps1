#requires -version 4
<#
.SYNOPSIS
  Maconomy server.ini checker for server.debug.enabled logging level
.DESCRIPTION
  None
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        0.01
  Author:         Fritz Reyes
  Creation Date:  1 Sep 2022
  Purpose/Change: Initial script development
#>

#------------------------------------------------[Declarations]------------------------------------------------
$rootDrive = "C:\"
$rootMacDir = "maconomy\"
$serverIniDir = "CouplingService\configuration\server.ini"

$macDir = $rootDrive + $rootMacDir


#-------------------------------------------------[Functions]--------------------------------------------------

function checkServerIniServerDebugEnabled {

$appInstances = @(Get-ChildItem -Path $macDir | Where-Object {$_.Name -like "w_*"} | Select Name | sort Name -Descending)

    foreach ($appInstance in $appInstances) {
    
    $serverInis = @($macDir + $appInstance.Name + "\" + $serverIniDir)
    
        foreach ($serverIni in $serverInis) {
        
        Write-Host "`nChecking -- "$appInstance.Name "-" $serverIni -ForegroundColor Green
        
        (Get-Content $serverIni | Select-String "server.debug.enabled") -Replace "`r",", "
        
        }
    }
}


#-------------------------------------------------[Execution]--------------------------------------------------

checkServerIniServerDebugEnabled