Function Get-MBQuota {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $Limit
    )

    Function ConvertSizeToGB {
        param (
            $SizeString
        )
        [math]::round(($SizeString.Replace(',', '').Replace(' bytes', '').Replace(')', '').Split('(')[-1] / 1GB), 2)
    }

    $mailbox_list = Get-Mailbox -ResultSize $Limit
    $mailbox_list | Select-Object Name,
    @{Name = 'IssueWarningQuota (GB)'; Expression = { (ConvertSizeToGB -SizeString $_.IssueWarningQuota) } },
    @{Name = 'ProhibitSendQuota (GB)'; Expression = { (ConvertSizeToGB -SizeString $_.ProhibitSendQuota) } },
    @{Name = 'ProhibitSendReceiveQuota (GB)'; Expression = { (ConvertSizeToGB -SizeString $_.ProhibitSendReceiveQuota) } }

    # String manipulation to remove
    # 1. Remove all comma characters.
    # 2. Remove the word "bytes".
    # 3. Remove everything before "(".
    # 4. Remove "(" and ")"
}