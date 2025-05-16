# PowerShell/CodeIntegrityCopilot.psm1
function Invoke-CodeIntegrityCopilot {
    param(
        [Parameter(Mandatory)][ScriptBlock]$Script
    )
    $t = [IO.Path]::GetTempFileName()
    $Script.ToString() | Set-Content $t -Encoding UTF8
    $issues = Invoke-ScriptAnalyzer -Path $t
    if ($issues) {
        Invoke-ScriptAnalyzer -Path $t -Fix
        . $t
    }
    else {
        & $Script
    }
    Remove-Item $t -Force
}

Export-ModuleMember -Function Invoke-CodeIntegrityCopilot
