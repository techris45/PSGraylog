<#
.SYNOPSIS
    Update an existing role
.DESCRIPTION
    Update an existing role


    For more information about this cmdlet - please search for /roles/{rolename} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLRoles -Rolename <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Update-GLRoles {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter rolename
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Rolename,
        # The new representation of the role
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
        if ($PSCmdlet.ShouldProcess($Rolename,"Update an existing role")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Rolename)) {
                $Rolename = [system.web.httputility]::UrlEncode($Rolename)

                $QueryArray += "rolename=$Rolename"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON Body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/roles/{rolename}'
            $APIPath = $APIPath -replace "\{Rolename\}","$Rolename"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
