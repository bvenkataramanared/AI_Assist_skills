<#
.SYNOPSIS
    Installs the developer SDLC skills into the current user's Claude Code
    skills directory ( $HOME\.claude\skills ).

.DESCRIPTION
    Copies each skill folder from this repo's .\skills directory into the
    per-user Claude skills directory so they are available to Claude Code in
    every project for that user.

    By default, any existing skill folder with the same name is backed up to
    $HOME\.claude\skills\.backup\<timestamp>\ before being replaced.

.PARAMETER Force
    Overwrite existing skills without creating a backup.

.PARAMETER WhatIf
    Show what would be installed without making changes.

.EXAMPLE
    .\install.ps1
    Installs all skills, backing up any that already exist.

.EXAMPLE
    .\install.ps1 -Force
    Installs all skills, overwriting existing ones without backup.
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Source: the skills/ folder next to this script.
$SourceDir = Join-Path $PSScriptRoot 'skills'
if (-not (Test-Path $SourceDir)) {
    throw "Source skills directory not found: $SourceDir"
}

# Target: per-user Claude skills directory.
$TargetDir = Join-Path $HOME '.claude\skills'

Write-Host "Installing skills" -ForegroundColor Cyan
Write-Host "  from : $SourceDir"
Write-Host "  to   : $TargetDir"
Write-Host ""

if (-not (Test-Path $TargetDir)) {
    if ($PSCmdlet.ShouldProcess($TargetDir, 'Create directory')) {
        New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    }
}

# Only install skill folders (directories that contain a SKILL.md). Loose files
# in skills/ (like README.md) are repo documentation and are not installed.
$skillDirs = Get-ChildItem -Path $SourceDir -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

if (-not $skillDirs) {
    Write-Warning "No skill folders (containing SKILL.md) found under $SourceDir"
    return
}

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$installed = 0
$backedUp  = 0

foreach ($skill in $skillDirs) {
    $dest = Join-Path $TargetDir $skill.Name

    if (Test-Path $dest) {
        if ($Force) {
            if ($PSCmdlet.ShouldProcess($dest, 'Remove existing skill (Force)')) {
                Remove-Item -Path $dest -Recurse -Force
            }
        }
        else {
            $backupRoot = Join-Path $TargetDir ".backup\$timestamp"
            if (-not (Test-Path $backupRoot)) {
                if ($PSCmdlet.ShouldProcess($backupRoot, 'Create backup directory')) {
                    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
                }
            }
            if ($PSCmdlet.ShouldProcess($dest, "Back up existing skill to $backupRoot")) {
                Move-Item -Path $dest -Destination (Join-Path $backupRoot $skill.Name)
                $backedUp++
            }
        }
    }

    if ($PSCmdlet.ShouldProcess($dest, 'Install skill')) {
        Copy-Item -Path $skill.FullName -Destination $dest -Recurse -Force
        Write-Host "  installed: $($skill.Name)" -ForegroundColor Green
        $installed++
    }
}

Write-Host ""
Write-Host "Done. $installed skill(s) installed$( if ($backedUp) { ", $backedUp backed up" } )." -ForegroundColor Cyan
if ($backedUp) {
    Write-Host "Backups: $(Join-Path $TargetDir ".backup\$timestamp")"
}
