Param(
    [Parameter(Mandatory = $true)]
    [string]$OpenAIKey
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path '.\env\Scripts\Activate.ps1')) {
    python -m venv env
}

$activate = '.\env\Scripts\Activate.ps1'

if (-not (Select-String -Path $activate -Pattern 'OPENAI_API_KEY' -Quiet)) {
    Add-Content -Path $activate -Value '$env:OPENAI_API_KEY = "' + $OpenAIKey + '"'
}

. $activate
