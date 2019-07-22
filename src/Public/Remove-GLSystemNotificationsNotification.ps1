﻿<#
.SYNOPSIS
    Delete a notification
.DESCRIPTION
    Delete a notification
    

    For more information about this cmdlet - please search for /system/notifications/{notificationType} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemNotificationsNotification -Notificationtype <String>
.NOTES
    Auto generated
#>
Function Remove-GLSystemNotificationsNotification {
    [CmdletBinding()]
    Param(
        # Parameter notificationType
        [Parameter(Mandatory=$False)]
        [String]$Notificationtype,

        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [PSCredential]$Credential = $Global:GLCredential
    
    )

    Begin{
        if([string]::IsNullOrEmpty($APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if($Null -eq $Credential){
            Write-Error -ErrorAction -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    Process {
                
        $QueryArray = @()
        if(![string]::IsNullOrEmpty($Notificationtype)){
        $Notificationtype = [system.web.httputility]::UrlEncode($Notificationtype)
        
        $QueryArray += "notificationType=$Notificationtype"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/notifications/{notificationType}'
        $APIPath = $APIPath -Replace "\{Notificationtype\}","$Notificationtype" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}