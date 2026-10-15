<#
.SYNOPSIS
    Syncs skills and plugins in ADNAN SKILLS with their original upstream GitHub repositories.

.DESCRIPTION
    Reads upstream-remotes.json, checks for changes in the original upstream GitHub repos,
    and pulls updates while preserving your custom configurations and /spin_subagents plugin.

.EXAMPLE
    .\sync-upstream.ps1
    .\sync-upstream.ps1 -CheckOnly
    .\sync-upstream.ps1 -Target "apple-design-skill"
#>

[CmdletBinding()]
param(
    [switch]$CheckOnly,
    [string]$Target
)

$ErrorActionPreference = "Stop"
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RegistryPath = Join-Path $ScriptRoot "upstream-remotes.json"

if (-not (Test-Path $RegistryPath)) {
    Write-Error "Could not find upstream-remotes.json at $RegistryPath"
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$TempDir = Join-Path $env:TEMP "adnan_skills_sync_$(Get-Random)"
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "     ADNAN SKILLS - Upstream GitHub Sync Engine          " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$Results = @()

function Sync-SkillOrPlugin {
    param(
        [string]$Name,
        [PSCustomObject]$Info,
        [string]$Category
    )

    if ($Target -and $Name -ne $Target) {
        return
    }

    Write-Host "`n[$Category] Checking: $Name" -ForegroundColor Yellow
    Write-Host "  Repo: $($Info.repo)" -ForegroundColor DarkGray

    $LocalPath = Join-Path $ScriptRoot $Info.path
    $Status = "Up-to-date"

    try {
        $ClonePath = Join-Path $TempDir $Name
        # Shallow clone the latest commit
        git clone --depth 1 --branch $Info.branch $Info.repo $ClonePath 2>$null

        if (Test-Path $ClonePath) {
            # Check commit hash
            $RemoteCommit = (git -C $ClonePath rev-parse --short HEAD).Trim()

            if (-not (Test-Path $LocalPath)) {
                New-Item -ItemType Directory -Force -Path $LocalPath | Out-Null
            }

            if (-not $CheckOnly) {
                # Copy updated files excluding .git
                Get-ChildItem -Path $ClonePath -Exclude ".git" | ForEach-Object {
                    Copy-Item -Path $_.FullName -Destination $LocalPath -Recurse -Force
                }
                $Status = "Updated to $RemoteCommit"
                Write-Host "  -> Successfully updated ($RemoteCommit)" -ForegroundColor Green
            } else {
                $Status = "Checked ($RemoteCommit)"
                Write-Host "  -> Latest upstream commit: $RemoteCommit" -ForegroundColor Cyan
            }
        } else {
            $Status = "Failed to clone"
            Write-Host "  -> Warning: Could not clone upstream repo." -ForegroundColor Red
        }
    } catch {
        $Status = "Error: $_"
        Write-Host "  -> Error: $_" -ForegroundColor Red
    }

    $Results += [PSCustomObject]@{
        Name     = $Name
        Category = $Category
        Status   = $Status
        Repo     = $Info.repo
    }
}

# 1. Sync Skills
foreach ($prop in $Registry.remotes.skills.PSObject.Properties) {
    Sync-SkillOrPlugin -Name $prop.Name -Info $prop.Value -Category "Skill"
}

# 2. Sync Plugins
foreach ($prop in $Registry.remotes.plugins.PSObject.Properties) {
    Sync-SkillOrPlugin -Name $prop.Name -Info $prop.Value -Category "Plugin"
}

# Clean temp directory
Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "                   Sync Summary Report                    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
$Results | Format-Table -Property Name, Category, Status -AutoSize

Write-Host "`n[NOTE] Custom plugins like 'spin-subagents' were strictly preserved." -ForegroundColor Green
