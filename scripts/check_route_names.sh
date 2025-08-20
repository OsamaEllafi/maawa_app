#!/bin/bash

# Check for duplicate route names in app_router.dart
# This script scans for 'name:' occurrences and fails if duplicates are found

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ROUTER_FILE="$PROJECT_ROOT/lib/app/navigation/app_router.dart"

echo "Checking for duplicate route names in app_router.dart..."

# Extract route names from the file
# Look for 'name:' followed by a string literal
route_names=$(grep -n "name:" "$ROUTER_FILE" | grep -o "name: '[^']*'" | sed "s/name: '//g" | sed "s/'//g")

# Count occurrences of each name
declare -A name_counts
declare -A name_lines

while IFS= read -r name; do
    if [[ -n "$name" ]]; then
        if [[ -z "${name_counts[$name]}" ]]; then
            name_counts[$name]=1
            # Get line numbers for this name
            name_lines[$name]=$(grep -n "name: '$name'" "$ROUTER_FILE" | cut -d: -f1 | tr '\n' ',' | sed 's/,$//')
        else
            name_counts[$name]=$((${name_counts[$name]} + 1))
            # Append line numbers
            name_lines[$name]="${name_lines[$name]},$(grep -n "name: '$name'" "$ROUTER_FILE" | cut -d: -f1 | tr '\n' ',' | sed 's/,$//')"
        fi
    fi
done <<< "$route_names"

# Check for duplicates
duplicates_found=false
echo "Found route names:"
for name in "${!name_counts[@]}"; do
    count=${name_counts[$name]}
    lines=${name_lines[$name]}
    echo "  $name (lines: $lines)"
    
    if [[ $count -gt 1 ]]; then
        echo "    ERROR: Duplicate found! ($count occurrences)"
        duplicates_found=true
    fi
done

if [[ "$duplicates_found" == true ]]; then
    echo ""
    echo "ERROR: Duplicate route names found!"
    echo "Please ensure each route name is unique."
    exit 1
else
    echo ""
    echo "SUCCESS: No duplicate route names found"
    echo "Found ${#name_counts[@]} unique route names"
    exit 0
fi
