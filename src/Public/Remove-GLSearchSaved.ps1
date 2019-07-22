﻿<#
.SYNOPSIS
    Delete a saved search
.DESCRIPTION
    Delete a saved search
    

    For more information about this cmdlet - please search for /search/saved/{searchId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSearchSaved -Searchid <String>
.NOTES
    Auto generated
#>
Function Remove-GLSearchSaved {
    [CmdletBinding()]
    Param(
        # Parameter searchId
        [Parameter(Mandatory=$True)]
        [String]$Searchid,

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
        if(![string]::IsNullOrEmpty($Searchid)){
        $Searchid = [system.web.httputility]::UrlEncode($Searchid)
        
        $QueryArray += "searchId=$Searchid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/saved/{searchId}'
        $APIPath = $APIPath -Replace "\{Searchid\}","$Searchid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}