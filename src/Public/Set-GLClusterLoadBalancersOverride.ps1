<#
.SYNOPSIS
    Override load balancer status of this graylog-server node. Next lifecycle change will override it again to its default. Set to ALIVE, DEAD, or THROTTLED.
.DESCRIPTION
    Override load balancer status of this graylog-server node. Next lifecycle change will override it again to its default. Set to ALIVE, DEAD, or THROTTLED.


    For more information about this cmdlet - please search for /cluster/{nodeId}/lbstatus/override/{status} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLClusterLoadBalancersOverride -Nodeid <String> -Status <String>
.NOTES
    Auto generated
#>
function Set-GLClusterLoadBalancersOverride {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The id of the node whose LB status will be changed
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Nodeid,
        # Parameter status
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Status,

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
        if ($PSCmdlet.ShouldProcess($Nodeid,"Override load balancer status of this graylog-server node. Next lifecycle change will override it again to its default. Set to ALIVE, DEAD, or THROTTLED.")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference }

        }
    }
    end {}
}
