# CI script to check for duplicate route names in app_router.dart
# This prevents go_router "duplication fullpaths for name" errors

param(
    [switch]$Verbose
)

Write-Host "Checking for duplicate route names in app_router.dart..." -ForegroundColor Cyan

# Read the app_router.dart file
$routerFile = "lib/app/navigation/app_router.dart"
if (-not (Test-Path $routerFile)) {
    Write-Host "ERROR: app_router.dart not found at $routerFile" -ForegroundColor Red
    exit 1
}

$content = Get-Content $routerFile -Raw

# Find all route name declarations using regex
$routeNamePattern = "name:\s*'([^']+)'"
$matches = [regex]::Matches($content, $routeNamePattern)

# Extract route names
$routeNames = @()
foreach ($match in $matches) {
    $routeNames += $match.Groups[1].Value
}

if ($Verbose) {
    Write-Host "Found route names:" -ForegroundColor Gray
    foreach ($name in $routeNames) {
        Write-Host "  - $name" -ForegroundColor Gray
    }
}

# Check for duplicates
$duplicates = $routeNames | Group-Object | Where-Object { $_.Count -gt 1 }

if ($duplicates.Count -gt 0) {
    Write-Host "ERROR: Found duplicate route names:" -ForegroundColor Red
    foreach ($duplicate in $duplicates) {
        Write-Host "  - '$($duplicate.Name)' appears $($duplicate.Count) times" -ForegroundColor Red
        
        # Show the specific lines where duplicates occur
        $lineNumber = 1
        $lines = Get-Content $routerFile
        foreach ($line in $lines) {
            if ($line -match "name:\s*'$($duplicate.Name)'") {
                Write-Host "    Line $lineNumber`: $($line.Trim())" -ForegroundColor Yellow
            }
            $lineNumber++
        }
    }
    Write-Host ""
    Write-Host "TIP: Each route name must be unique. Use descriptive names like 'ownerPropertyEditorNew' and 'ownerPropertyEditorEdit'." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "SUCCESS: No duplicate route names found" -ForegroundColor Green
    Write-Host "Found $($routeNames.Count) unique route names" -ForegroundColor Gray
}
