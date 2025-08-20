# Maawa App - Design Decisions

This document tracks key architectural and design decisions made during development.

## UI/UX Decisions

| ID | Date | Context | Decision | Status |
|-------------|------------|--------------------------|--------------------------------------------------------------------------|--------|
| D-UI-010 | 2025-08-20 | Typography pairing | Use Almarai (Arabic) + Inter (Latin). Arabic locales must render Almarai.| Final |
| D-UI-011 | 2025-08-20 | ARB naming | Use app_en.arb / app_ar.arb; l10n config matches these filenames. | Final |
| D-UI-012 | 2025-08-20 | Style guide access | Expose /style-guide route and link from Settings → Dev Tools. | Final |
| D-UI-013 | 2025-08-20 | Motion accessibility | Respect platform reduced motion; central toggle lives in tokens. | Proposed |
| D-UI-025 | 2025-08-20 | Property media assets | All gallery items use valid local assets (JPG/WEBP/PNG) and a real MP4 ≤10s; no echoes. | Final |
| D-UI-026 | 2025-08-20 | Arabic digits policy | Prices/capacity/rating digits in Arabic locale use <Arabic-Indic\|Latin> digits. | Proposed |
| D-A11Y-027 | 2025-08-20 | Carousel accessibility | Provide semantics for next/prev and announce position "Image X of N"; video labeled. | Final |
| D-A11Y-028 | 2025-08-20 | Reduced-motion skeletons | Replace shimmer with static placeholders when reduced motion is enabled. | Final |

## Navigation Decisions

| ID | Date | Context | Decision | Status |
|-------------|------------|------------------------|------------------------------------------------------------------------------------------|--------|
| D-NAV-015 | 2025-08-20 | Role simulator scope | Role simulator affects **visibility only** (preview). No route guards in UI-only phase. | Final |
| D-NAV-016 | 2025-08-20 | Shell/tab behavior | Use ShellRoute + IndexedStack to preserve per-tab navigation stacks and state. | Final |
| D-NAV-017 | 2025-08-20 | Unknown routes | Provide NotFound screen and graceful empty states for bad/missing path params. | Final |
| D-NAV-030 | 2025-08-20 | Back button behavior | Inner pages always show back button; fallback to Home on deep links; use pushNamed for inner nav. | Final |

## Authentication Decisions

| ID | Date | Context | Decision | Status |
|-------------|------------|------------------------|------------------------------------------------------------------------------------------------|--------|
| D-AUTH-018 | 2025-08-20 | Auth UI-only scope | All auth/onboarding/profile/KYC flows are visual only; no networking or persistence. | Final |
| D-AUTH-019 | 2025-08-20 | LTR fields in AR | Phone & IBAN inputs force LTR direction and proper keyboards in all locales. | Final |

## Accessibility Decisions

| ID | Date | Context | Decision | Status |
|-------------|------------|------------------------|------------------------------------------------------------------------------------------------|--------|
| D-A11Y-020 | 2025-08-20 | Reduced motion policy | All auth/onboarding animations respect platform reduce-motion; provide non-animated fallback. | Final |
| D-A11Y-021 | 2025-08-20 | NotFound & bad params | Invalid or missing :id routes render a localized NotFound/empty state. | Final |
| D-OWNER-UI-001 | 2025-08-20 | Owner screens text scale | Owner screens hardened for 130% text scale; single-scrollable rule enforced. | Final |
| D-OWNER-NAV-002 | 2025-08-20 | Owner inner navigation | Owner inner nav uses pushNamed; back fallback to Home when no history. | Final |
| D-ROUTING-OWNER-001 | 2025-08-20 | Owner Property Editor routes | Split into distinct create/edit routes: /owner/properties/new and /owner/properties/:id/edit. | Final |
| D-ROUTING-OWNER-002 | 2025-08-20 | Editor routing hardening | Legacy redirects, UI-only id guard, NotFound behavior, and CI route name checks. | Final |
| D-ROUTING-OWNER-003 | 2025-08-20 | Canonicalization & Typed Nav Helpers | Trailing-slash strip, robust ID decode/guard, typed helpers, CI bash script. | Final |

## Back Button System (D-NAV-030)

**Context**: Need consistent back button behavior across the app, especially for deep-linked inner screens.

**Decision**: Implement a robust back button system with fallback navigation:

### Back Button Visibility Rules
- **Tab Roots**: No back button (Home, My Bookings, Wallet, Profile)
- **Auth Screens**: No back button (Splash, Onboarding, Login, Register, Forgot/Reset)
- **Inner Screens**: Always show back button (Property Details, Booking Request, Settings, etc.)

### Back Button Behavior
1. **Custom onBack**: If provided, use custom callback
2. **Normal Navigation**: If `context.canPop()` is true, use `context.pop()`
3. **Deep Link Fallback**: If no navigation history, navigate to Home tab

### Implementation Details
- **Centralized Logic**: `isTabRootPath()` function in `tab_roots.dart`
- **Location Detection**: Prefer `matchedLocation` over `uri.toString()` for reliability
- **Helper Function**: `buildBackLeading()` for screens that can't use AppTopBar
- **Navigation Pattern**: Use `context.pushNamed()` for inner flows, `context.go()` only for tab/role switching

### Technical Components
- `AppTopBar` / `AppSliverTopBar`: Automatic back button logic
- `buildBackLeading()`: Centralized helper for manual AppBars
- `tab_roots.dart`: Single source of truth for tab root detection
- CI Guard: Script prevents `context.go()` usage in inner flows

**Status**: Final - Implemented and tested with comprehensive integration tests.

## Owner Property Editor Routing (D-ROUTING-OWNER-001)

**Context**: The go_router was throwing "duplication fullpaths for name propertyEditor" because multiple routes shared the same name.

**Decision**: Split the property editor into distinct create and edit routes with normalized paths:

### Route Structure
- **Create New Property**: `/owner/properties/new` (name: `ownerPropertyEditorNew`)
- **Edit Existing Property**: `/owner/properties/:id/edit` (name: `ownerPropertyEditorEdit`)
- **Backward Compatibility**: Redirect `/owner/property/editor` → `/owner/properties/new`

### Path Normalization
- **Before**: `/owner/property/editor` and `/owner/property/:id/editor`
- **After**: `/owner/properties/new` and `/owner/properties/:id/edit`
- **Rationale**: Consistent pluralization (`properties`) and clearer intent (`new` vs `edit`)

### Navigation Updates
- **FAB/Create Button**: `context.pushNamed('ownerPropertyEditorNew')`
- **Edit Action**: `context.pushNamed('ownerPropertyEditorEdit', pathParameters: {'id': property.id})`
- **Media Manager**: Any "Edit details" links use `ownerPropertyEditorEdit` with correct ID

### Implementation Details
- **Route Constants**: Added `ownerPropertyEditorNew` and `ownerPropertyEditorEdit` constants
- **Backward Compatibility**: Redirect route preserves old deep links
- **Shell Route**: Both routes remain under owner ShellRoute for consistent navigation
- **Parameter Handling**: Edit route requires `id` parameter, create route has no parameters

**Status**: Final - Implemented with all navigation calls updated and tests passing.

## Owner Editor Routing Hardening (D-ROUTING-OWNER-002)

**Context**: Need to harden the owner editor routes with proper error handling, legacy redirects, and CI guards to prevent future routing issues.

**Decision**: Implement comprehensive routing hardening with UI-only guards and CI checks:

### Legacy Redirects
- **Create**: `/owner/property/editor` → `/owner/properties/new`
- **Edit**: `/owner/property/:id/editor` → `/owner/properties/:id/edit`
- **Parameter Preservation**: ID parameters are correctly passed through redirects

### UI-only ID Guard
- **Validation**: Check if property ID exists in `DemoData.properties`
- **Fallback**: Invalid IDs show `NotFoundScreen` instead of throwing errors
- **Graceful Degradation**: No crashes, just user-friendly error state

### NotFound Screen
- **Localized**: English and Arabic support with proper RTL handling
- **Consistent UI**: Uses `AppTopBar` for consistent back button behavior
- **Clear CTA**: "Go Home" button navigates to tenant home
- **Accessible**: Proper semantics and screen reader support

### CI Route Name Guard
- **Script**: `scripts/check_route_names.ps1` scans for duplicate route names
- **Prevention**: Fails CI if any two routes share the same name
- **Helpful Output**: Shows specific lines where duplicates occur
- **Integration**: Can be added to pre-commit hooks or CI pipelines

### Comprehensive Testing
- **Valid Routes**: Test both create and edit routes with valid data
- **Invalid Routes**: Test edit route with invalid IDs shows NotFound
- **Legacy Redirects**: Test both legacy paths redirect correctly
- **Navigation Flow**: Test NotFound screen CTA goes to Home
- **Deep Links**: Test direct navigation to all route variations

### Implementation Details
- **Router Guards**: UI-only validation in route builders
- **Error Boundaries**: Graceful handling of invalid parameters
- **Localization**: All error messages and UI text localized
- **Back Button**: Consistent behavior across all error states
- **CI Integration**: Automated checks prevent future regressions

**Status**: Final - Implemented with comprehensive testing and CI guards.

## Route Canonicalization & Typed Navigation Helpers (D-ROUTING-OWNER-003)

**Context**: Need to add small, UI-only defenses and ergonomics to existing routing system to remove ambiguity, prevent regressions, and make navigation calls refactor-safe.

**Decision**: Implement comprehensive route canonicalization and typed navigation helpers:

### Route Canonicalization
- **Global Redirect**: Strip single trailing slash from all app paths while preserving query/fragment
- **Legacy Support**: Maintain existing redirects for `/owner/property/editor` → `/owner/properties/new`
- **ShellRoute Safety**: Ensure redirects run before page builders and don't break bottom nav

### Robust ID Handling
- **Percent Decoding**: Safely decode `:id` parameters using `Uri.decodeComponent()`
- **Empty/Invalid Guards**: Handle null, empty, and whitespace-only IDs → show NotFound UI
- **DemoData Validation**: Check if decoded ID exists in `DemoData.properties` → NotFound if false
- **UI-Only Scope**: Keep all validation purely client-side, no backend calls

### Typed Navigation Helpers
- **Helper Class**: `NavHelpers` with static methods for common UI flows
- **pushNamed Wrapper**: All helpers use `context.pushNamed()` to preserve back stack
- **Type Safety**: Eliminate stringly-typed navigation calls for inner flows
- **Common Patterns**: Property editor, booking flows, wallet sub-screens, profile/settings

### Cross-Platform CI Guards
- **Bash Script**: `scripts/check_route_names.sh` mirrors PowerShell functionality
- **Route Name Check**: Scan for duplicate `name:` occurrences in `app_router.dart`
- **Helpful Output**: Show specific lines where duplicates occur
- **Local Usage**: `./scripts/check_route_names.sh` for manual verification

### Comprehensive Testing
- **Trailing Slash**: Test `/owner/properties/new/` → redirects to canonical path
- **Legacy Paths**: Test `/owner/property/{id}/editor` → redirects to new format
- **Percent Encoding**: Test encoded IDs resolve correctly to valid properties
- **Invalid IDs**: Test empty, whitespace, and invalid IDs show NotFound
- **Query/Fragment**: Test preservation during redirects
- **RTL Support**: Test Arabic locale with invalid paths shows localized NotFound

### Implementation Details
- **Global Redirect**: Added to `GoRouter` configuration with URI manipulation
- **ID Validation**: Enhanced edit route builder with robust parameter handling
- **Helper Methods**: Created `NavHelpers` class with common navigation patterns
- **CI Script**: Bash version with associative arrays for duplicate detection
- **Test Coverage**: Comprehensive widget tests with GoRouter harness

### Benefits
- **Safer Deep Links**: Canonical paths prevent ambiguity and improve SEO
- **Refactor Safety**: Typed helpers make navigation calls less brittle
- **Better UX**: Graceful handling of malformed URLs and edge cases
- **Code Quality**: Automated CI checks prevent routing regressions
- **Cross-Platform**: Both PowerShell and Bash CI guards available

### Local Development
```bash
# Run route name check locally
./scripts/check_route_names.sh

# Run comprehensive routing tests
flutter test test/routing/owner_editor_routing_extra_test.dart
```

**Status**: Final - Implemented with comprehensive testing and CI guards.
