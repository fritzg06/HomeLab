#requires -version 4
<#
.SYNOPSIS
  This is a script to start the service for People Planner. It uses a while loop to wait until the service is started.
.DESCRIPTION
  This is a script to start the service for People Planner. It uses a while loop to wait until the service is started.
  It has a time delay between attempts of service restart. Can try to use multiple People Planner service in an array 
  variable, and it uses foreach loop to iterate per defined service.
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        0.01
  Author:         Fritz Reyes
  Creation Date:  15 Nov 2022
  Purpose/Change: Initial script development
#>

#------------------------------------------------[Declarations]------------------------------------------------

# Define People Planner Service Names in an array, separate by a comma if 
# multiple services are to be defined, enclosed in double quotes, each 
# People Planner Service defined here will be attempted for service start.
$ppServiceNames = @("People Planner Service 4.2.0 CU01-566")

# Time delay in seconds between re-try in starting the service
[int]$delay = 180

# Timestamp command expression
$timestampCommand = 'Get-Date -Format "MM/dd/yyyy HH:mm K"'

#-------------------------------------------------[Functions]--------------------------------------------------

function logFileStart {
$logFile = "D:\Scripts\SRE\PPServiceStartUp_" + $((Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')) + ".log"
Start-Transcript -Path $logFile
}

function logFileStop {
Stop-Transcript
}

function checkPPserviceAndStart {

Foreach ($ppServiceName in $ppServiceNames) {

    Write-Host "`n"
    Invoke-Expression $timestampCommand
    Write-Host "`nChecking PP Service -" $ppServiceName
    Get-Service -Name $ppServiceName | ft -auto
    Write-Host "Service is:" (Get-Service -Name $ppServiceName).Status

        While ((Get-Service -Name $ppServiceName).Status -ne "Running") {
        Write-Host "`n"
        Invoke-Expression $timestampCommand
        Write-Host "`n"
        Write-Host "Service is:" (Get-Service -Name $ppServiceName).Status
        Write-Host $ppServiceName "is not running, trying to start this service..."
        Get-Service -Name $ppServiceName | Start-Service
        Write-Host "If service did not start, will re-try after" $delay "seconds..."
        Start-Sleep $delay
        }
        
        Write-Host "`n"
        Invoke-Expression $timestampCommand
        Write-Host "`nPP Service has started: " $ppServiceName

    }
}

#-------------------------------------------------[Execution]--------------------------------------------------

logFileStart
checkPPserviceAndStart
logFileStop