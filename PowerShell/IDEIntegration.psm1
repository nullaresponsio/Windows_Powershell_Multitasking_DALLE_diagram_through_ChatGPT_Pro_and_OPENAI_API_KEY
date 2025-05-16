# PowerShell/IDEIntegration.psm1
function Get-BracketSet {
    param(
        [Parameter(Mandatory)][string]$Path,
        [string]$Filter = '*.ps1'
    )
    Get-ChildItem -Path $Path -Filter $Filter -Recurse |
        ForEach-Object { . $_.FullName }
}

function Join-IDEBracketSet {
    param(
        [Parameter(Mandatory)][string]$IDE,
        [Parameter(Mandatory,ValueFromPipeline)][ScriptBlock[]]$BracketSet
    )
    process {
        foreach ($s in $BracketSet) { & $s }
    }
}

Set-Alias jibs Join-IDEBracketSet
Export-ModuleMember -Function Get-BracketSet,Join-IDEBracketSet -Alias jibs
