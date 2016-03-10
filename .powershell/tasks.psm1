Set-StrictMode -Version Latest

$rootDir = Split-Path (Split-Path $PSCommandPath)

function publish {
    <#
    .SYNOPSIS
    
    Publishes the module to the PowerShell Gallery.
    #>
    param(
        [string]$NuGetApiKey
    )
    
    Publish-Module `
        -Name (Join-Path $rootDir pwdtasks.psd1) `
        -NuGetApiKey $NuGetApiKey
}

Export-ModuleMember -Function publish