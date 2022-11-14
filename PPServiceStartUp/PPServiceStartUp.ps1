#requires -version 4
<#
.SYNOPSIS
  None
.DESCRIPTION
  None
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

# Number of attempts to try start People Planner Service
[int]$numberOfAttempts = 10

#-------------------------------------------------[Functions]--------------------------------------------------

function checkPPserviceAndStart {

Foreach ($ppServiceName in $ppServiceNames) {

    Write-Host "`nChecking PP Service - " $ppServiceName
    Get-Service -Name $ppServiceName | ft -auto
    Write-Host "Service is: " (Get-Service -Name $ppServiceName).Status

        While ((Get-Service -Name $ppServiceName).Status -ne "Running") {
        Write-Host $ppServiceName "is not running, trying to start this service..."
        Get-Service -Name $ppServiceName | Start-Service
        Start-Sleep 180
        }
        Write-Host "PP Service has started: " $ppServiceName
    
    }

}

#-------------------------------------------------[Execution]--------------------------------------------------

checkPPserviceAndStart