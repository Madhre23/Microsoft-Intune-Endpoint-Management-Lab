# Collect basic Windows endpoint inventory and export to CSV.
$os = Get-CimInstance Win32_OperatingSystem
$computer = Get-CimInstance Win32_ComputerSystem
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$inventory = [PSCustomObject]@{
    ComputerName = $env:COMPUTERNAME
    WindowsEdition = $os.Caption
    WindowsVersion = $os.Version
    TotalRAM_GB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
    FreeDiskSpace_GB = [math]::Round($disk.FreeSpace / 1GB, 2)
    LastChecked = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
}
$inventory | Format-List
$inventory | Export-Csv -Path 'C:\IntuneLab\Scripts\SystemInventory.csv' -NoTypeInformation
Write-Host 'System inventory report saved successfully.'
