# Windows Event Logs - Coupling Service
Get-EventLog -LogName System | Where-Object {$_.Message -like "*Coupling Service*"} | Select TimeGenerated, EventID, Index, Message -First 10 | ft -auto

# Windows Event Logs - People Planner Service
Get-EventLog -LogName System | Where-Object {$_.Message -like "*People Planner*"} | Select TimeGenerated, EventID, Index, Message -First 10 | ft -auto