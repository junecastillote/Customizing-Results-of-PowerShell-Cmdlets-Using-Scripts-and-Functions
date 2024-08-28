Function Get-MBQuotaWithSize {
    [CmdletBinding()]
    param (
        [Parameter()]
        $ResultSize = '10'
    )

    Function ConvertSizeToGB {
        param (
            $SizeString
        )
        [math]::round(($SizeString.Replace(',', '').Replace(' bytes', '').Replace(')', '').Split('(')[-1] / 1GB), 2)
    }

    $mailbox_list = Get-Mailbox -ResultSize $ResultSize

    foreach ( $mailbox in $mailbox_list) {
        $mailbox_stat = Get-MailboxStatistics -Identity $mailbox
        [PSCustomObject]@{
            Name                            = $mailbox.Name
            'IssueWarningQuota (GB)'        = (ConvertSizeToGB -SizeString $mailbox.IssueWarningQuota.ToString())
            'ProhibitSendQuota (GB)'        = (ConvertSizeToGB -SizeString $mailbox.ProhibitSendQuota.ToString())
            'ProhibitSendReceiveQuota (GB)' = (ConvertSizeToGB -SizeString $mailbox.ProhibitSendReceiveQuota.ToString())
            'TotalItemSize (GB)'            = (ConvertSizeToGB -SizeString $mailbox_stat.TotalItemSize.ToString())
        }
    }

    # String manipulation to remove
    # 1. Remove all comma characters.
    # 2. Remove the word " bytes".
    # 3. Remove everything before "(" using split() method.
    # 4. Remove "(" and ")"
    # 5. Include TotalItemSize (GB) to the output.

    <#
    asdasdasd
    asdasda
    asdasd
    #>
}