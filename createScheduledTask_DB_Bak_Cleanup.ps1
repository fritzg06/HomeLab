#requires -version 4
<#
.SYNOPSIS
  Script to create a Scheduled Task for the clean up of DB backup files
.DESCRIPTION
  WARNING: 
  Please review the script before execution and check the following:
  -Service Account
  -Descriptive Task Name / Prefix
  -Schedule
  -Start Time
  -Script Location, e.g. Drive Letter, Folder Location
  -Run Level
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        0.01
  Author:         Fritz Reyes
  Creation Date:  25 Aug 2022
  Purpose/Change: Initial script development
#>

#------------------------------------------------[Declarations]------------------------------------------------
$svcAccount = "lab\svc_admin"
$taskName = "DB Backup Cleanup Task"
$taskSchedule = "DAILY"
$startTime = "00:00"
$runLevel = 'HIGHEST'
$scriptLocation = "D:\DB-Scripts\backupCleanUp.ps1"
$scriptCommand = "powershell.exe -f "
$taskRun = $scriptCommand + $scriptLocation

#-------------------------------------------------[Functions]--------------------------------------------------

function createScheduledTask {
schtasks.exe /Create /TN $taskName /SC $taskSchedule /ST $startTime /RU $svcAccount /RP * /TR $taskRun /RL $runLevel
}

#-------------------------------------------------[Execution]--------------------------------------------------

createScheduledTask
