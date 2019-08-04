<#
.SYNOPSIS
    Get a list of all outputs for a stream
.DESCRIPTION
    Get a list of all outputs for a stream
    

    For more information about this cmdlet - please search for /streams/{streamid}/outputs in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLStreamOutputsAll -Streamid <String>
.NOTES
    Auto generated
#>
function Get-GLStreamOutputsAll {
    [CmdletBinding()]
    param(
        # The id of the stream whose outputs we want.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,

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

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/streams/{streamid}/outputs'
        $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "No such stream on this node." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}

