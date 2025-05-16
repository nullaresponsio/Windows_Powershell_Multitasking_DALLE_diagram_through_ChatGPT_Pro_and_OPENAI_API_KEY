# PowerShell/PDFSageAutoCoding.psm1
function Invoke-PDFSage {
    param(
        [Parameter(Mandatory)][string]$Prompt,
        [string]$Language = 'python'
    )
    $key = $env:PDFSAGE_API_KEY
    if (-not $key) { throw 'PDFSAGE_API_KEY missing' }
    $body = @{ prompt = $Prompt; language = $Language } | ConvertTo-Json -Depth 3
    $r = Invoke-RestMethod -Uri 'https://api.pdfsage.ai/v1/code' `
        -Method Post `
        -Headers @{ Authorization = "Bearer $key" } `
        -Body $body `
        -ContentType 'application/json'
    return $r.code
}

function Invoke-PDFSageAutoCoding {
    param(
        [Parameter(Mandatory)][string]$Prompt
    )
    [ScriptBlock]::Create((Invoke-PDFSage -Prompt $Prompt)).Invoke()
}

Export-ModuleMember -Function Invoke-PDFSage,Invoke-PDFSageAutoCoding
