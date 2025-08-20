#!/bin/bash

# CI script to guard against context.go() usage in inner flows
# This prevents navigation stack flattening that breaks back button functionality

set -e

echo "🔍 Checking for context.go() usage in inner flows..."

# Files that are allowed to use context.go() (tab switching, role switching, etc.)
ALLOWED_FILES=(
    "lib/ui/layouts/bottom_nav.dart"
    "lib/ui/layouts/main_scaffold.dart"
    "lib/app/navigation/app_router.dart"
    "lib/ui/widgets/common/app_top_bar.dart"
    "lib/ui/widgets/common/app_sliver_top_bar.dart"
    "lib/app/navigation/tab_roots.dart"
)

# Find all Dart files
DART_FILES=$(find lib -name "*.dart" -type f)

# Check each Dart file for context.go() usage
VIOLATIONS=()

for file in $DART_FILES; do
    # Skip allowed files
    SKIP=false
    for allowed in "${ALLOWED_FILES[@]}"; do
        if [[ "$file" == "$allowed" ]]; then
            SKIP=true
            break
        fi
    done
    
    if [ "$SKIP" = true ]; then
        continue
    fi
    
    # Check for context.go() usage
    if grep -q "context\.go(" "$file"; then
        VIOLATIONS+=("$file")
    fi
done

# Report violations
if [ ${#VIOLATIONS[@]} -gt 0 ]; then
    echo "❌ Found context.go() usage in inner flows:"
    for violation in "${VIOLATIONS[@]}"; do
        echo "   - $violation"
        # Show the specific lines
        grep -n "context\.go(" "$violation" | sed 's/^/     /'
    done
    echo ""
    echo "💡 Use context.pushNamed() for inner navigation to preserve back button functionality."
    echo "   Only use context.go() for tab switching, role switching, or navigation to root routes."
    exit 1
else
    echo "✅ No context.go() violations found in inner flows"
fi
