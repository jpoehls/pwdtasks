# Import-Module https://github.com/jpoehls/pwdtasks to have
# this tasks.psm1 module automatically loaded whenever you
# `cd` into your project's directory tree.

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
