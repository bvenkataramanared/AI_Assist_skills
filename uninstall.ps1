<#
.SYNOPSIS
    Removes the developer SDLC skills (shipped by this repo) from the current
    user's Claude Code skills directory ( $HOME\.claude\skills ).

.DESCRIPTION
    Only removes skill folders that exist in this repo's .\skills directory, so
    any unrelated skills the user has are left untouched. Backups created by the
    installer ( .backup\ ) are not removed.

.EXAMPLE
    .\uninstall.ps1
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param()

$ErrorActionPreference = 'Stop'

$SourceDir = Join-Path $PSScriptRoot 'skills'
$TargetDir = Join-Path $HOME '.claude\skills'

if (-not (Test-Path $TargetDir)) {
    Write-Host "Nothing to remove: $TargetDir does not exist."
    return
}

$skillNames = Get-ChildItem -Path $SourceDir -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
    Select-Object -ExpandProperty Name

$removed = 0
foreach ($name in $skillNames) {
    $dest = Join-Path $TargetDir $name
    if (Test-Path $dest) {
        if ($PSCmdlet.ShouldProcess($dest, 'Remove skill')) {
            Remove-Item -Path $dest -Recurse -Force
            Write-Host "  removed: $name" -ForegroundColor Yellow
            $removed++
        }
    }
}

Write-Host ""
Write-Host "Done. $removed skill(s) removed." -ForegroundColor Cyan
