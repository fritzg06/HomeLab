# Windows Event Logs - Coupling Service
Get-EventLog -LogName System | Where-Object {$_.Message -like "*Coupling Service*"} | Select TimeGenerated, EventID, Message -First 10 | ft -auto

# Windows Event Logs - People Planner Service
Get-EventLog -LogName System | Where-Object {$_.Message -like "*People Planner*"} | Select TimeGenerated, EventID, Message -First 10 | ft -auto