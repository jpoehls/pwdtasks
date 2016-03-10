Set-StrictMode -Version Latest

function Get-TasksModulePath {
    <#
    .SYNOPSIS
    
    Walks up from the current directory and returns the path of
    the first '.powershell/tasks.psm1' file.
    #>
    param (
        [string]$Path = (Get-Location).Path
    )
    
    $TASKS_FILE = ".powershell/tasks.psm1"

    $found = $false
    $p = (Resolve-Path $Path).Path

    :FOUND while (!$found)
    {
        if (Test-Path (Join-Path $p $TASKS_FILE) -PathType Item) {
            $found = $true
            break FOUND
        } 
  
        # Walk up from the current directory until we find what we are looking for.
  
        while ($p -ne $null) {
            $pathToTest = Split-Path $p -Parent
            if ($pathToTest) {
                if (Test-Path (Join-Path $pathToTest $TASKS_FILE) -PathType Item) {
                    $p = $pathToTest
                    $found = $true
                    break FOUND
                } else {
                    $p = Split-Path $p -Parent
                }
            }
            else {
                break
            }
        }

        break
    }

    if ($found) {
        return Join-Path $p $TASKS_FILE
    }
}

function Remove-CurrentModule {
    <#
    .SYNOPSIS
    
    Unloads any currently loaded tasks module.
    #>
    
    if (!$script:currentTasksModule) {
        return
    }
    
    Write-Debug "Unloading current tasks module: $script:currentTasksPath"
    Remove-Module -ModuleInfo $script:currentTasksModule -Force -ErrorAction SilentlyContinue -ErrorVariable moderr
    if ($moderr) {
        Write-Debug "Error unloading old tasks module: $script:currentTasksPath`n$moderr"
    }
    $script:currentTasksModule = $null
    $script:currentTasksPath = $null
}

# When the $PWD changes we will load the relevant module from the .powershell folder.
$script:breakpoint = Set-PSBreakpoint -Variable pwd -Mode Write -Action {

    if ($pwd.Provider.Name -ne "FileSystem") {
        return
    }

    $tasksPath = Get-TasksModulePath
    if ($tasksPath -eq $script:currentTasksPath) {
        if ($tasksPath) {
            Write-Debug "Tasks module unchanged: $tasksPath"
        }
    }
    else {
        Remove-CurrentModule

        if ($tasksPath) {
            Write-Debug "Tasks module found: $tasksPath"

            Write-Debug "Importing tasks module: $tasksPath"
            $script:currentTasksModule = Import-Module $tasksPath -Global -PassThru -NoClobber -ErrorAction SilentlyContinue -ErrorVariable moderr
            if ($moderr) {
                Write-Debug "Error importing new tasks module: $tasksPath`n$moderr"
            }
            $script:currentTasksPath = $tasksPath
        } else {
            Write-Debug "Tasks module not found."
        }
    }

}

# Clean up after ourselves when we are unloaded.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = { 
    Remove-PSBreakpoint -Breakpoint $script:breakpoint
    
    Remove-CurrentModule
}

# Don't export anything.
# We're just wiring up some silent functionality.
Export-ModuleMember -Function @()