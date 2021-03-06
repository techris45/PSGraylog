<#
.SYNOPSIS
    Get a single stream rules
.DESCRIPTION
    Get a single stream rules


    For more information about this cmdlet - please search for /streams/{streamid}/rules/{streamRuleId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLStreamRules -Streamid <String> -Streamruleid <String>
.NOTES
    Auto generated
#>
function Get-GLStreamRules {
    [CmdletBinding()]
    param(
        # The id of the stream whose stream rule we want.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # The stream rule id we are getting
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamruleid,

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
        if (![string]::IsNullOrEmpty($Streamid)) {
            $Streamid = [system.web.httputility]::UrlEncode($Streamid)

            $QueryArray += "streamid=$Streamid"
        }

        if (![string]::IsNullOrEmpty($Streamruleid)) {
            $Streamruleid = [system.web.httputility]::UrlEncode($Streamruleid)

            $QueryArray += "streamRuleId=$Streamruleid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/streams/{streamid}/rules/{streamRuleId}'
        $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
        $APIPath = $APIPath -replace "\{Streamruleid\}","$Streamruleid"
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
