<#
.SYNOPSIS
    Connect processing pipelines to a stream
.DESCRIPTION
    Connect processing pipelines to a stream


    For more information about this cmdlet - please search for /system/pipelines/connections/to_stream in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Connect-GLPipelinesConnectionsPipelines -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Connect-GLPipelinesConnectionsPipelines {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter Json body
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [pscustomobject]$Body,

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
        if ($PSCmdlet.ShouldProcess($Body,"Connect processing pipelines to a stream")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "Json body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/pipelines/connections/to_stream'
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
