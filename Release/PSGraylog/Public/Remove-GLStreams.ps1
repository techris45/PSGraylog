﻿<#
.SYNOPSIS
    Delete a stream
.DESCRIPTION
    Delete a stream
    

    For more information about this cmdlet - please search for /streams/{streamId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStreams -Streamid <String>
.NOTES
    Auto generated
#>
Function Remove-GLStreams {
    [CmdletBinding()]
    Param(
        # Parameter streamId
        [Parameter(Mandatory=$True)]
        [String]$Streamid,

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
        if(![string]::IsNullOrEmpty($Streamid)){
        $Streamid = [system.web.httputility]::UrlEncode($Streamid)
        
        $QueryArray += "streamId=$Streamid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamId}'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}