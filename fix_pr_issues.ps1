# Fix all issues in the OSINT Security Extension OGIT PR
# Run from: C:\Users\chris\Dropbox\Claude Workspace\OGIT
# Usage: powershell -ExecutionPolicy Bypass -File fix_pr_issues.ps1

$base = "C:\Users\chris\Dropbox\Claude Workspace\OGIT"
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$fixCount = 0
$bomCount = 0

Write-Host "=== Fix 1: Creator field in all new verb TTLs ===" -ForegroundColor Cyan

# Find all TTL files with wrong creator
$ttlFiles = Get-ChildItem -Path $base -Recurse -Filter "*.ttl" | Where-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $content -match 'OSINT Security Extension team'
}

foreach ($f in $ttlFiles) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $newContent = $content -replace 'OSINT Security Extension team', 'chris.boos@almato.com'
    [System.IO.File]::WriteAllText($f.FullName, $newContent, $utf8NoBom)
    $fixCount++
    Write-Host "  Fixed creator: $($f.FullName.Replace($base + '\', ''))"
}
Write-Host "  $fixCount files fixed." -ForegroundColor Green

Write-Host ""
Write-Host "=== Fix 2: Namespace mismatch in Position.ttl ===" -ForegroundColor Cyan

$posFile = "$base\NTO\Politics\entities\Position.ttl"
if (Test-Path $posFile) {
    $content = [System.IO.File]::ReadAllText($posFile, [System.Text.Encoding]::UTF8)
    if ($content -match '\[ ogit:establishedAt ') {
        $newContent = $content -replace '\[ ogit:establishedAt ', '[ ogit.Politics:establishedAt '
        [System.IO.File]::WriteAllText($posFile, $newContent, $utf8NoBom)
        Write-Host "  Fixed: ogit:establishedAt -> ogit.Politics:establishedAt in Position.ttl" -ForegroundColor Green
    } else {
        Write-Host "  Already correct or not found." -ForegroundColor Yellow
    }
} else {
    Write-Host "  Position.ttl not found!" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Fix 3: Remove BOM from all new/modified TTL files ===" -ForegroundColor Cyan

# Check all TTL files in our NTOs plus SGO verbs for BOM
$allTtl = Get-ChildItem -Path $base -Recurse -Filter "*.ttl" | Where-Object {
    ($_.FullName -match "NTO\\Transport") -or
    ($_.FullName -match "NTO\\Compliance") -or
    ($_.FullName -match "NTO\\Politics") -or
    ($_.FullName -match "NTO\\Location") -or
    ($_.FullName -match "NTO\\FinancialMarket") -or
    ($_.FullName -match "SGO\\sgo\\verbs\\(actsOnBehalfOf|administrator|affiliate|audit|beneficial|beneficiary|board|born|chair|compliance|contracts|controlled|custodian|director|executor|has|heir|investment|liquidator|lobbyist|merged|nominee|officer|partner|protector|provides|receiver|resides|settlor|signatory|subsidiary|trustee|was|wholly)") -or
    ($_.FullName -match "SGO\\sgo\\entities\\(Person|Organization)\.ttl")
}

foreach ($f in $allTtl) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        # Strip BOM by rewriting without it
        $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
        [System.IO.File]::WriteAllText($f.FullName, $content, $utf8NoBom)
        $bomCount++
        Write-Host "  BOM removed: $($f.FullName.Replace($base + '\', ''))" -ForegroundColor Yellow
    }
}
if ($bomCount -eq 0) {
    Write-Host "  No BOM found in any file." -ForegroundColor Green
} else {
    Write-Host "  $bomCount files had BOM removed." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "=== Verification ===" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Verify: no wrong creator anywhere
Write-Host ""
Write-Host "--- Creator Check ---"
$wrongCreator = Get-ChildItem -Path $base -Recurse -Filter "*.ttl" | Where-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $content -match 'OSINT Security Extension team'
}
if ($wrongCreator) {
    foreach ($f in $wrongCreator) {
        Write-Host "  STILL WRONG: $($f.FullName.Replace($base + '\', ''))" -ForegroundColor Red
    }
} else {
    Write-Host "  No 'OSINT Security Extension team' found anywhere." -ForegroundColor Green
}

# Verify: Position.ttl namespace
Write-Host ""
Write-Host "--- Position.ttl Namespace Check ---"
$posContent = [System.IO.File]::ReadAllText($posFile, [System.Text.Encoding]::UTF8)
if ($posContent -match 'ogit\.Politics:establishedAt') {
    Write-Host "  Position.ttl uses ogit.Politics:establishedAt correctly." -ForegroundColor Green
} else {
    Write-Host "  Position.ttl still has wrong namespace!" -ForegroundColor Red
}

# Verify: no BOM in any of our files
Write-Host ""
Write-Host "--- BOM Check (all TTLs in repo) ---"
$bomFiles = @()
Get-ChildItem -Path $base -Recurse -Filter "*.ttl" | ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $bomFiles += $_.FullName.Replace($base + '\', '')
    }
}
if ($bomFiles.Count -eq 0) {
    Write-Host "  No BOM in any TTL file in the entire repo." -ForegroundColor Green
} else {
    Write-Host "  BOM still found in:" -ForegroundColor Red
    $bomFiles | ForEach-Object { Write-Host "    $_" -ForegroundColor Red }
}

# Verify: all new verbs are used in at least one entity
Write-Host ""
Write-Host "--- New Verb Usage Check ---"
$newVerbFiles = @()
$newVerbFiles += Get-ChildItem -Path "$base\SGO\sgo\verbs" -Filter "*.ttl" | Where-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $content -match 'start=2026-05'
}
$newVerbFiles += Get-ChildItem -Path "$base\NTO\Politics\verbs" -Filter "*.ttl" -ErrorAction SilentlyContinue | Where-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $content -match 'start=2026-05'
}
$newVerbFiles += Get-ChildItem -Path "$base\NTO\Compliance\verbs" -Filter "*.ttl" -ErrorAction SilentlyContinue | Where-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $content -match 'start=2026-05'
}

$unusedVerbs = @()
foreach ($vf in $newVerbFiles) {
    $verbName = $vf.BaseName
    $found = Get-ChildItem -Path $base -Recurse -Filter "*.ttl" | Where-Object {
        $_.FullName -match "entities"
    } | Select-String -Pattern $verbName -SimpleMatch
    if (-not $found) {
        $unusedVerbs += $verbName
        Write-Host "  UNUSED: $verbName" -ForegroundColor Red
    }
}
if ($unusedVerbs.Count -eq 0) {
    Write-Host "  All new verbs are referenced in entity files." -ForegroundColor Green
} else {
    Write-Host "  $($unusedVerbs.Count) unused verbs found!" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Done. If all green, run: ===" -ForegroundColor Cyan
Write-Host '  git add -A' -ForegroundColor White
Write-Host '  git commit --amend --no-edit' -ForegroundColor White
Write-Host '  git push myfork feature/security-osint-relationships --force' -ForegroundColor White
