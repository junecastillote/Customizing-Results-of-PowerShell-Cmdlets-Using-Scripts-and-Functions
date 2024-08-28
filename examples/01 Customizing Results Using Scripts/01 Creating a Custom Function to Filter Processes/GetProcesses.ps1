# GetProcesses.ps1
# This script fetches running processes and displays their names and memory usage.

# Fetch processes
$processes = Get-Process

# Filter and format the output
$customProcesses = $processes | Select-Object Name, @{Name = "Memory (MB)"; Expression = { ($_.WorkingSet / 1MB).ToString("N2") } }

# Display the results
# $customProcesses | Format-Table -AutoSize

# Display the results sorted by memory usage
$customProcesses | Sort-Object 'Memory (MB)' -Descending | Format-Table -AutoSize
