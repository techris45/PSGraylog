<#
.SYNOPSIS
    Validates collector parameters
.DESCRIPTION
    Validates collector parameters


    For more information about this cmdlet - please search for /sidecar/collectors/validate in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Test-GLSidecarCollectorsValidateCollector -Body <String>
.NOTES
    Auto generated
#>
function Test-GLSidecarCollectorsValidateCollector {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # collector
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Body,

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
        if ($PSCmdlet.ShouldProcess($Body,"Validates collector parameters")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Body)) {
                $Body = [system.web.httputility]::UrlEncode($Body)

                $QueryArray += "JSON Body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/sidecar/collectors/validate'
            $APIPath = $APIPath -replace "\{\}","$"
            try {
                Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
