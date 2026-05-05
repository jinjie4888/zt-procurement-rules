<#
.SYNOPSIS
  Safely sync non-sensitive ZT procurement-side rules/documents from G drive facts into this local Git repo.

.DESCRIPTION
  This script only copies an explicit allowlist of control/rule/template files.
  It does not copy raw business materials, SECURE, price/amount/payment/account files,
  original PDFs/images/Excel business details, databases, main tables or formal procurement results.

.USAGE
  Run from local repo root:
    powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync_gdrive_rules_to_repo.ps1
#>

$ErrorActionPreference = 'Stop'

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$GRoot = 'G:\20260420_订单成果实用化工作区_当前有效\00_当前状态与总索引\00_持续同步记忆层'
$ControlCenter = Join-Path $GRoot '00_项目运行总控中心'

$ForbiddenNamePatterns = @(
  'SECURE',
  '02_AI运行区业务明细',
  '价格',
  '金额',
  '付款',
  '账号',
  '收款',
  '银行',
  '开户行',
  'soft_unit_price_source',
  '原始PDF',
  '原始图片',
  '原始Excel',
  '业务明细',
  '主表',
  '总表',
  '正式采购结论',
  '真实供应商'
)

function Test-ForbiddenPath {
  param([Parameter(Mandatory=$true)][string]$Path)
  foreach ($pattern in $ForbiddenNamePatterns) {
    if ($Path -like "*$pattern*") { return $true }
  }
  return $false
}

function Copy-SafeFile {
  param(
    [Parameter(Mandatory=$true)][string]$Source,
    [Parameter(Mandatory=$true)][string]$Destination
  )

  if (!(Test-Path -LiteralPath $Source)) {
    Write-Warning "Missing source: $Source"
    return
  }

  if (Test-ForbiddenPath -Path $Source) {
    throw "Blocked forbidden source path: $Source"
  }

  $ext = [System.IO.Path]::GetExtension($Source).ToLowerInvariant()
  if ($ext -notin @('.md', '.csv', '.json', '.txt')) {
    throw "Blocked unsupported file extension: $Source"
  }

  $destDir = Split-Path -Parent $Destination
  New-Item -ItemType Directory -Force -Path $destDir | Out-Null
  Copy-Item -LiteralPath $Source -Destination $Destination -Force
  Write-Host "Copied: $Source -> $Destination"
}

# Core state/rule files. Adjust these source paths only after confirming they remain non-sensitive control-layer files.
$CopyMap = @(
  @{
    Source = Join-Path $ControlCenter '01_CURRENT_STATE.md'
    Dest = Join-Path $RepoRoot '00_current_state\CURRENT_STATE.from_gdrive.md'
  },
  @{
    Source = Join-Path $ControlCenter '02_NEXT_ACTION.md'
    Dest = Join-Path $RepoRoot '02_next_action\NEXT_ACTION.from_gdrive.md'
  },
  @{
    Source = Join-Path $ControlCenter '00_LATEST_POINTERS.json'
    Dest = Join-Path $RepoRoot '00_current_state\LATEST_POINTERS.from_gdrive.json'
  },
  @{
    Source = Join-Path $GRoot 'rule_asset_consolidation_001\CURRENT_EFFECTIVE规则总集.md'
    Dest = Join-Path $RepoRoot '01_effective_rules\CURRENT_EFFECTIVE_RULES.from_gdrive.md'
  },
  @{
    Source = Join-Path $ControlCenter 'ZT采购端4项真实采购执行前缺口_CURRENT_RESERVED_LIST.csv'
    Dest = Join-Path $RepoRoot '04_gap_management\4项真实采购执行前缺口_CURRENT_RESERVED_LIST.from_gdrive.csv'
  }
)

foreach ($item in $CopyMap) {
  Copy-SafeFile -Source $item.Source -Destination $item.Dest
}

Write-Host ''
Write-Host 'Safe sync finished. Review git diff before committing:'
Write-Host '  git status'
Write-Host '  git diff --stat'
Write-Host ''
Write-Host 'Do not commit if any sensitive/raw/business-detail file appears.'
