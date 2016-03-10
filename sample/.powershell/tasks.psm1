# Import-Module https://github.com/jpoehls/pwdtasks to have
# this tasks.psm1 module automatically loaded whenever you
# `cd` into your project's directory tree.

Set-StrictMode -Version Latest

# Grab the path to your project's root directory.
$rootDir = Split-Path (Split-Path $PSCommandPath)

# Add whatever helper functions, "tasks", you would like here.
# Whenever your $pwd is inside the "sample" directory
# or any of its sub-directories these functions will be available.

function hello {
    Write-Output "Hi there! I'm a handy dandy helper function."
}

Export-ModuleMember -Function hello
