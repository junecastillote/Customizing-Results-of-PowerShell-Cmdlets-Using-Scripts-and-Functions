# ExportServices.ps1
# This script fetches installed services and exports their names and statuses to a CSV file.

# Fetch services
$services = Get-Service

# Select relevant properties
$customServices = $services | Select-Object Name, Status

# Export to CSV
$customServices | Export-Csv -Path .\ServicesList.csv -NoTypeInformation
