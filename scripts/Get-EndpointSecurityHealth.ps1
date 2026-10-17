# Check Windows Defender Antivirus and Windows Firewall profiles.
$defender = Get-MpComputerStatus
$service = Get-Service -Name WinDefend
$firewall = Get-NetFirewallProfile
$report = [PSCustomObject]@{
    ComputerName = $env:COMPUTERNAME
    AntivirusEnabled = $defender.AntivirusEnabled
    RealTimeProtection = $defender.RealTimeProtectionEnabled
    DefenderService = $service.Status
    SecurityIntelligenceVersion = $defender.AntivirusSignatureVersion
    DomainFirewall = ($firewall | Where-Object Name -eq 'Domain').Enabled
    PrivateFirewall = ($firewall | Where-Object Name -eq 'Private').Enabled
    PublicFirewall = ($firewall | Where-Object Name -eq 'Public').Enabled
    LastChecked = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
}
$report | Format-List
$report | Export-Csv -Path 'C:\IntuneLab\Scripts\EndpointSecurityHealth.csv' -NoTypeInformation
Write-Host 'Endpoint security health report saved successfully.'
