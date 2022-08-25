#requires -version 4
<#
.SYNOPSIS
  Script to delete files in the specified directory and age in days
.DESCRIPTION
  To combine this script with a Scheduled Task, it should call the powershell.exe with -f argument,
  sample below:  
  powershell.exe -f "C:\DB-Scripts\BackupCleanUp.ps1"
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        0.01
  Author:         Fritz Reyes
  Creation Date:  25 Jul 2022
  Purpose/Change: Initial script development
#>

#------------------------------------------------[Declarations]------------------------------------------------

# Folder Location Path, add more separated by comma, put a single quote as delimiter
$backupFolders = @('D:\Mac_Ent_Backup\')

# Age of files in Days that will be deleted
[int]$days = -14

# Script Task Log File Location
$logFile = "D:\Mac_Ent_Backup\log\scriptLogBackupCleanUp_" + $((Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')) + ".log"

#-------------------------------------------------[Functions]--------------------------------------------------

function logFileStart {
Start-Transcript -Path $logFile
}

function logFileStop {
Stop-Transcript
}

function deleteOldBackupFiles {

Foreach ($folder in $backupFolders) {
    Write-Host "`r`nCurrent System Time is " 
    Get-Date
    Write-Host "`r`nChecking --- $folder"
    Write-Host "`r`nBelow files will be deleted permanently."
    # Display the files to be deleted so it will be logged with Start-Transcript
    Get-ChildItem -Path $folder | Where-Object {$_.Name -like "*.bak" -and $_.LastWriteTime -lt (Get-Date).AddDays($days)} | Select Name, Length, CreationTime, LastWriteTime | Sort-Object -Property Creationtime | ft -auto
    # Select the files that meet the criteria and force delete
    Get-ChildItem -Path $folder | Where-Object {$_.Name -like "*.bak" -and $_.LastWriteTime -lt (Get-Date).AddDays($days)} | Remove-Item -Force
    }
}

#-------------------------------------------------[Execution]--------------------------------------------------

logFileStart
deleteOldBackupFiles
logFileStop