# Detect and restore a stopped Print Spooler service in a lab VM.
# Run in an elevated PowerShell session.
$serviceName = 'Spooler'
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
if ($null -eq $service) { Write-Host 'ERROR: Service not found.'; exit 1 }
$before = $service.Status.ToString()
$action = 'No action needed'
if ($service.Status -ne 'Running') {
    Write-Host 'Service is not running. Attempting repair...'
    try {
        Start-Service -Name $serviceName -ErrorAction Stop
        $action = 'Attempted to start service'
    } catch {
        $action = 'Failed to start service'
        Write-Host "ERROR: $($_.Exception.Message)"
    }
} else { Write-Host 'Service is already running.' }
$after = (Get-Service -Name $serviceName).Status.ToString()
$report = [PSCustomObject]@{
    ComputerName = $env:COMPUTERNAME
    ServiceName = $serviceName
    StatusBefore = $before
    ActionTaken = $action
    StatusAfter = $after
    LastChecked = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
}
$report | Format-List
$report | Export-Csv -Path 'C:\IntuneLab\Scripts\ServiceRemediation.csv' -NoTypeInformation
Write-Host 'Service troubleshooting report saved.'
if ($after -ne 'Running') { exit 1 }
