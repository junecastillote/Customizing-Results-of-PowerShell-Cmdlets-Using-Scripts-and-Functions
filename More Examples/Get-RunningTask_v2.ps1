[CmdletBinding()]
param (
    [parameter(Mandatory)]
    [string[]]$Name
)
Get-Process -Name $Name | Sort-Object WorkingSet -Descending | Select-Object Name,
@{Name = 'Memory (KB)'; Expression = {
    ($PSItem.WorkingSet / 1KB).ToString("N2")
    }
}