Get-Process | Sort-Object WorkingSet -Descending | Select-Object Name,
@{Name = 'Memory (KB)'; Expression = {
    ($PSItem.WorkingSet / 1KB).ToString("N2")
    }
}