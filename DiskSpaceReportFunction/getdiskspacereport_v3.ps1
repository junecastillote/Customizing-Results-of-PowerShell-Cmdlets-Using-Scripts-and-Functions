Function Get-DiskSpaceReport {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $ComputerName
    )

    $driveTypeTable = @{
        0 = 'Unknown'
        1 = 'No Root Directory'
        2 = 'Removable Disk'
        3 = 'Local Disk'
        4 = 'Network Drive'
        5 = 'Compact Disc'
        6 = 'RAM Disk'
    }

    $params = @{}

    if ($ComputerName) {
        $params.Add('ComputerName', $ComputerName)
    }

    $disk_data = Get-CimInstance -ClassName Win32_LogicalDisk @params

    $disk_data | Select-Object `
    @{n = 'Letter'; e = { $_.DeviceID } },
    @{n = 'Drive Type'; e = { ($driveTypeTable[[int]$_.DriveType]) } },
    @{n = 'Size (GB)'; e = { [math]::round($_.Size / 1GB, 2) } },
    @{n = 'Used Space (GB)'; e = { [math]::round(($_.Size - $_.FreeSpace) / 1GB, 2) } },
    @{n = 'Free Space (GB)'; e = { [math]::round($_.FreeSpace / 1GB, 2) } },
    @{n = 'Free Space (%)'; e = {
            [math]::round(($_.FreeSpace / $_.Size) * 100, 2)
        }
    },
    @{n = 'Computer Name'; e = { $_.SystemName } }
}