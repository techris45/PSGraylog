﻿<#
.SYNOPSIS
    Set the loglevel of a whole subsystem
.DESCRIPTION
    Set the loglevel of a whole subsystem
    Provided level is falling back to DEBUG if it does not exist

    For more information about this cmdlet - please search for /system/loggers/subsystems/{subsystem}/level/{level} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLSystemLoggersSubsystemLoggerLevel -Subsystem <String> -Level <String>
.NOTES
    Auto generated
#>
Function Set-GLSystemLoggersSubsystemLoggerLevel {
    [CmdletBinding()]
    Param(
        # Parameter subsystem
        [Parameter(Mandatory=$True)]
        [String]$Subsystem,
         # Parameter level
        [Parameter(Mandatory=$True)]
        [String]$Level,
 
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
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body
    }
    End {}
}