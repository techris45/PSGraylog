﻿<#
.SYNOPSIS
    Delete output of a stream
.DESCRIPTION
    Delete output of a stream
    

    For more information about this cmdlet - please search for /streams/{streamid}/outputs/{outputId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStreamOutputs -Streamid <String> -Outputid <String>
.NOTES
    Auto generated
#>
function Remove-GLStreamOutputs {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The id of the stream whose outputs we want.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # The id of the output that should be deleted
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Outputid,

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
        if ($PSCmdlet.ShouldProcess($Streamid,"Delete output of a stream")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Streamid)) {
                $Streamid = [system.web.httputility]::UrlEncode($Streamid)

                $QueryArray += "streamid=$Streamid"
            }

            if (![string]::IsNullOrEmpty($Outputid)) {
                $Outputid = [system.web.httputility]::UrlEncode($Outputid)

                $QueryArray += "outputId=$Outputid"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/streams/{streamid}/outputs/{outputId}'
            $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
            $APIPath = $APIPath -replace "\{Outputid\}","$Outputid"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "No such stream/output on this node." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
