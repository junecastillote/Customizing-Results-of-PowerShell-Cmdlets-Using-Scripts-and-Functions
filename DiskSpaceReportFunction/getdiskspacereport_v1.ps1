Function Get-DiskSpaceReport {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $ComputerName
    )

    $params = @{}

    if ($ComputerName) {
        $params.Add('ComputerName', $ComputerName)
    }

    $disk_data = Get-CimInstance -ClassName Win32_LogicalDisk @params

    $disk_data | Select-Object DeviceID, Size, FreeSpace, DriveType, SystemName

}