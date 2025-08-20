# CI script to guard against context.go() usage in inner flows
# This prevents navigation stack flattening that breaks back button functionality

param(
    [switch]$Verbose
)

Write-Host "Checking for context.go() usage in inner flows..." -ForegroundColor Cyan

# Files that are allowed to use context.go() (tab switching, role switching, etc.)
$ALLOWED_FILES = @(
    "lib/ui/layouts/bottom_nav.dart"
    "lib/ui/layouts/main_scaffold.dart"
    "lib/app/navigation/app_router.dart"
    "lib/ui/widgets/common/app_top_bar.dart"
    "lib/ui/widgets/common/app_sliver_top_bar.dart"
    "lib/app/navigation/tab_roots.dart"
    "lib/ui/screens/auth/forgot_password_screen.dart"
    "lib/ui/screens/auth/login_screen.dart"
    "lib/ui/screens/auth/onboarding_screen.dart"
    "lib/ui/screens/auth/register_screen.dart"
    "lib/ui/screens/auth/reset_password_screen.dart"
    "lib/ui/screens/auth/splash_screen.dart"
    "lib/ui/screens/settings/dev_tools_screen.dart"
    "lib/ui/screens/not_found_screen.dart"
    "lib/ui/screens/profile/profile_screen.dart"
    "lib/ui/screens/properties/property_detail_screen.dart"
)

# Find all Dart files
$DART_FILES = Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | ForEach-Object { $_.FullName }

# Check each Dart file for context.go() usage
$VIOLATIONS = @()

foreach ($file in $DART_FILES) {
    # Convert to relative path for comparison
    $relativePath = $file.Replace((Get-Location).Path + "\", "").Replace("\", "/")
    
    # Skip allowed files
    $SKIP = $false
    foreach ($allowed in $ALLOWED_FILES) {
        if ($relativePath -eq $allowed) {
            $SKIP = $true
            break
        }
    }
    
    if ($SKIP) {
        if ($Verbose) {
            Write-Host "   Skipping allowed file: $relativePath" -ForegroundColor Gray
        }
        continue
    }
    
    # Check for context.go() usage
    $content = Get-Content $file -Raw
    if ($content -match "context\.go\(") {
        $VIOLATIONS += $relativePath
    }
}

# Report violations
if ($VIOLATIONS.Count -gt 0) {
    Write-Host "ERROR: Found context.go() usage in inner flows:" -ForegroundColor Red
    foreach ($violation in $VIOLATIONS) {
        Write-Host "   - $violation" -ForegroundColor Red
        # Show the specific lines
        $lines = Get-Content $violation
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match "context\.go\(") {
                Write-Host "     Line $($i + 1): $($lines[$i].Trim())" -ForegroundColor Yellow
            }
        }
    }
    Write-Host ""
    Write-Host "TIP: Use context.pushNamed() for inner navigation to preserve back button functionality." -ForegroundColor Yellow
    Write-Host "   Only use context.go() for tab switching, role switching, or navigation to root routes." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "SUCCESS: No context.go() violations found in inner flows" -ForegroundColor Green
}
