﻿<#
.SYNOPSIS
    Updates the index templates for all index sets in Elasticsearch
.DESCRIPTION
    Updates the index templates for all index sets in Elasticsearch
    

    For more information about this cmdlet - please search for /system/indexer/indices/templates/update in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLIndexerIndicesTemplatesSyncAll 
.NOTES
    Auto generated
#>
Function Set-GLIndexerIndicesTemplatesSyncAll {
    [CmdletBinding()]
    Param(

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
                $BodyHash = @{}
$QueryArray | Foreach { 
                    $val = $_ -split '='
                    $BodyHash[$val[0]] = $val[1]
                }
                $Body = $BodyHash | ConvertTo-Json
                Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body
    }
    End {}
}