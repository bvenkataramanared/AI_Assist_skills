<#
.SYNOPSIS
    Remove legacy *personal* copies of these skills from $HOME\.claude\skills.

.DESCRIPTION
    Earlier versions of this package installed each skill as a personal skill
    under ~/.claude/skills (invoked as /<skill-name>). The package is now a
    Claude Code *plugin*, so skills are invoked namespaced as
    /ai_assist_skill:<skill-name>.

    If you previously installed the personal copies, they will show up as
    duplicates (un-namespaced) alongside the plugin skills. Run this once to
    remove them. It only deletes folders whose names match skills shipped by
    this package (current + known-removed); any unrelated skills you have are
    left untouched. Installer backups (.backup) are not touched.

.EXAMPLE
    .\cleanup-legacy-skills.ps1
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param()

$ErrorActionPreference = 'Stop'

$SkillsDir = Join-Path $PSScriptRoot 'skills'
$TargetDir = Join-Path $HOME '.claude\skills'

# Skills currently shipped by this package.
$current = @()
if (Test-Path $SkillsDir) {
    $current = Get-ChildItem -Path $SkillsDir -Directory |
        Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
        Select-Object -ExpandProperty Name
}

# Skills shipped by older versions and since removed.
$legacy = @('explain-code', 'write-tests', 'documentation', 'debug-triage', 'dependency-upgrade')

$names = ($current + $legacy) | Sort-Object -Unique

if (-not (Test-Path $TargetDir)) {
    Write-Host "Nothing to clean: $TargetDir does not exist."
    return
}

$removed = 0
foreach ($name in $names) {
    $p = Join-Path $TargetDir $name
    if (Test-Path $p) {
        if ($PSCmdlet.ShouldProcess($p, 'Remove legacy personal skill')) {
            Remove-Item -Path $p -Recurse -Force
            Write-Host "  removed: $name" -ForegroundColor Yellow
            $removed++
        }
    }
}

Write-Host ""
Write-Host "Done. $removed legacy personal skill(s) removed." -ForegroundColor Cyan
Write-Host "Now install the plugin (see README): /plugin marketplace add <repo> ; /plugin install ai_assist_skill@ai-assist-marketplace"
