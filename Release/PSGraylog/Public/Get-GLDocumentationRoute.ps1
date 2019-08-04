﻿<#
.SYNOPSIS
    Get detailed API documentation of a single resource
.DESCRIPTION
    Get detailed API documentation of a single resource
    

    For more information about this cmdlet - please search for /api-docs/{route: .+} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLDocumentationRoute -Route <String>
.NOTES
    Auto generated
#>
function Get-GLDocumentationRoute {
    [CmdletBinding()]
    param(
        # Route to fetch. For example /system
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Route,

        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [pscredential]$Credential = $Global:GLCredential

    )

    begin {
        if ([string]::IsNullOrEmpty($APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if ($Null -eq $Credential) {
            Write-Error -ErrorAction Stop -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    process {

        $QueryArray = @()
        if (![string]::IsNullOrEmpty($Route)) {
            $Route = [system.web.httputility]::UrlEncode($Route)

            $QueryArray += "route=$Route"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/api-docs/{route: .+}'
        $APIPath = $APIPath -replace "\{\}","$"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

        }


    }
    end {}
}
