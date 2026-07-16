<#
.SYNOPSIS
    Completely uninstalls Claude Desktop and reinstalls it machine-wide via the
    MSIX package so the Cowork virtualization service registers correctly.

.DESCRIPTION
    Fixes the "Use Claude's modern installer to access Cowork" issue, which occurs
    when Claude is installed per-user (Add-AppxPackage) or via a legacy installer,
    leaving the Cowork virtualization service unregistered.

    The script runs in two phases separated by a reboot:
      Phase 1 (this run):  full uninstall + enable required Windows features + reboot
      Phase 2 (after reboot): download MSIX + machine-wide reinstall + verify

    Re-run the script after the reboot to complete Phase 2. It auto-detects which
    phase to run based on whether Claude is still present.

.NOTES
    Must be run in an ELEVATED PowerShell session (Run as administrator).
    Architecture default: x64. Use -Arch arm64 for ARM Cloud PCs.

.EXAMPLE
    .\Reinstall-ClaudeDesktop.ps1
    .\Reinstall-ClaudeDesktop.ps1 -Arch arm64
#>

[CmdletBinding()]
param(
    [ValidateSet('x64', 'arm64')]
    [string]$Arch = 'x64'
)

$ErrorActionPreference = 'Stop'

# ── Ensure elevated ────────────────────────────────────────────────
$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Error "This script must be run in an elevated PowerShell session (Run as administrator)."
    exit 1
}

function Write-Step { param([string]$Msg) Write-Host "`n=== $Msg ===" -ForegroundColor Cyan }

# ── Detect phase ───────────────────────────────────────────────────
$claudeInstalled = @(Get-AppxPackage -AllUsers -Name *Claude*).Count -gt 0
$provisioned     = @(Get-AppxProvisionedPackage -Online |
                     Where-Object { $_.DisplayName -like "*Claude*" }).Count -gt 0

if ($claudeInstalled -or $provisioned) {

    # ═══════════════════════════════════════════════════════════════
    # PHASE 1 — UNINSTALL + ENABLE FEATURES + REBOOT
    # ═══════════════════════════════════════════════════════════════

    Write-Step "PHASE 1: Uninstalling Claude Desktop"

    Write-Host "Removing per-user package (current user)..."
    Get-AppxPackage -Name *Claude* | Remove-AppxPackage -ErrorAction SilentlyContinue

    Write-Host "Removing package for all users..."
    Get-AppxPackage -AllUsers -Name *Claude* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

    Write-Host "Removing provisioned (machine-wide staged) package..."
    Get-AppxProvisionedPackage -Online |
        Where-Object { $_.DisplayName -like "*Claude*" } |
        Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

    Write-Host "Clearing residual app data..."
    Remove-Item "$env:LOCALAPPDATA\Packages\Claude_pzs8sxrjxfjjc" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:LOCALAPPDATA\AnthropicClaude"               -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:APPDATA\Claude"                              -Recurse -Force -ErrorAction SilentlyContinue

    Write-Step "Verifying removal"
    $remain  = @(Get-AppxPackage -AllUsers -Name *Claude*)
    $remainP = @(Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "*Claude*")
    if ($remain.Count -eq 0 -and $remainP.Count -eq 0) {
        Write-Host "Claude fully removed." -ForegroundColor Green
    } else {
        Write-Warning "Some Claude components may remain. Review before continuing."
    }

    Write-Step "Enabling Cowork prerequisites (Virtual Machine Platform + Hyper-V)"
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart | Out-Null
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V      -All -NoRestart | Out-Null
    Write-Host "Features staged. A reboot is required to apply them." -ForegroundColor Green

    Write-Step "Rebooting"
    Write-Host "The machine will reboot in 15 seconds. Re-run this script after reboot to reinstall." -ForegroundColor Yellow
    Start-Sleep -Seconds 15
    Restart-Computer -Force

} else {

    # ═══════════════════════════════════════════════════════════════
    # PHASE 2 — DOWNLOAD + MACHINE-WIDE REINSTALL + VERIFY
    # ═══════════════════════════════════════════════════════════════

    Write-Step "PHASE 2: Downloading Claude MSIX ($Arch)"
    $msixUrl  = "https://claude.ai/api/desktop/win32/$Arch/msix/latest/redirect"
    $msixPath = Join-Path $env:TEMP "Claude.msix"
    Invoke-WebRequest -Uri $msixUrl -OutFile $msixPath
    Write-Host "Downloaded to $msixPath" -ForegroundColor Green

    Write-Step "Reinstalling machine-wide (registers Cowork service)"
    Add-AppxProvisionedPackage -Online -PackagePath $msixPath -SkipLicense -Regions "all" | Out-Null

    Write-Step "Verifying install"
    $pkg = Get-AppxPackage -AllUsers -Name *Claude* |
           Select-Object Name, Version, PackageFamilyName
    if ($pkg) {
        $pkg | Format-Table -AutoSize
        Write-Host "Claude reinstalled machine-wide." -ForegroundColor Green
    } else {
        Write-Warning "Claude not detected after install. Review the output above."
    }

    Write-Step "Confirming feature state"
    Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform, Microsoft-Hyper-V |
        Select-Object FeatureName, State | Format-Table -AutoSize

    Write-Host "`nDone. Sign out and back in (or relaunch Claude) to activate Cowork." -ForegroundColor Green
    Write-Host "If Cowork still won't start, the Windows 365 SKU may not support nested virtualization." -ForegroundColor Yellow
}
