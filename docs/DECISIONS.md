# Design Decisions Log

This document tracks important architectural and design decisions for the Maawa app.

## Decision Table

| ID          | Date       | Context                  | Decision                                                                 | Status |
|-------------|------------|--------------------------|--------------------------------------------------------------------------|--------|
| D-UI-010    | 2025-08-20 | Typography pairing       | Use Almarai (Arabic) + Inter (Latin). Arabic locales must render Almarai.| Final  |
| D-UI-011    | 2025-08-20 | ARB naming               | Use app_en.arb / app_ar.arb; l10n config matches these filenames.        | Final  |
| D-UI-012    | 2025-08-20 | Style guide access       | Expose /style-guide route and link from Settings → Dev Tools.            | Final  |
| D-UI-013    | 2025-08-20 | Motion accessibility     | Respect platform reduced motion; central toggle lives in tokens.         | Proposed |
| D-NAV-015   | 2025-08-20 | Role simulator scope   | Role simulator affects **visibility only** (preview). No route guards in UI-only phase.  | Final  |
| D-NAV-016   | 2025-08-20 | Shell/tab behavior     | Use ShellRoute + IndexedStack to preserve per-tab navigation stacks and state.           | Final  |
| D-NAV-017   | 2025-08-20 | Unknown routes         | Provide NotFound screen and graceful empty states for bad/missing path params.           | Final  |
| D-NAV-018   | 2025-08-20 | Route titles & semantics | Every route must set localized title (AppBar) and semantics. Titles stored in ARB files. | Final  |
| D-NAV-019   | 2025-08-20 | Route constants         | Centralize route names in app_router.dart with documentation for path patterns/params.   | Final  |
| D-AUTH-018  | 2025-08-20 | Form accessibility      | Wrap all forms in FocusTraversalGroup for logical Tab/Shift+Tab movement.                | Final  |
| D-AUTH-019  | 2025-08-20 | Password visibility     | Add Semantics(label:) to password toggles; obscureText changes announce to screen readers. | Final  |
| D-A11Y-020  | 2025-08-20 | Reduced motion support  | Check MediaQuery.accessibleNavigation; disable animations when true.                     | Final  |
| D-NAV-021   | 2025-08-20 | Text direction hygiene  | Force TextDirection.ltr for phone numbers and IBAN in Arabic locale.                     | Final  |
| D-NAV-022   | 2025-08-20 | Role simulator behavior  | Visibility-only preview; no route guards in UI phase; deep-links allowed. | Final  |
| D-NAV-023   | 2025-08-20 | Invalid param handling   | Central NotFound/Invalid-ID screen for all :id routes (localized).        | Final  |
| D-A11Y-024  | 2025-08-20 | Non-color feedback       | Errors/success never rely on color alone; include icons/text cues.         | Final  |
| D-UI-025    | 2025-08-20 | Property media assets       | All gallery items use valid local assets (JPG/WEBP/PNG) and a real MP4 ≤10s; no echoes. | Final  |
| D-UI-026    | 2025-08-20 | Arabic digits policy        | Prices/capacity/rating digits in Arabic locale use <Arabic-Indic|Latin> digits.         | Proposed |
| D-A11Y-027  | 2025-08-20 | Carousel accessibility      | Provide semantics for next/prev and announce position "Image X of N"; video labeled.     | Final  |
| D-A11Y-028  | 2025-08-20 | Reduced-motion skeletons    | Replace shimmer with static placeholders when reduced motion is enabled.                 | Final  |
| D-FLW-030   | 2025-08-20 | Inherited reads             | Never read MediaQuery/Theme/l10n/Router in initState/constructors. Use build/didChangeDependencies. | Final  |

## Decision Details

### D-UI-010: Typography Pairing
**Context**: Need to support both English and Arabic languages with appropriate fonts.
**Decision**: Use Almarai for Arabic locales and Inter for Latin locales. Implement locale-aware font application in the app shell.
**Rationale**: Almarai provides excellent Arabic glyph support, while Inter is highly legible for Latin scripts.
**Implementation**: Locale-aware theme building in `AppShell._buildLocaleAwareTheme()`.

### D-UI-011: ARB Naming Convention
**Context**: Flutter localization requires consistent ARB file naming.
**Decision**: Use `app_en.arb` and `app_ar.arb` as the standard naming convention.
**Rationale**: Matches Flutter's default expectations and avoids confusion with other naming patterns.
**Implementation**: Files located in `lib/l10n/` with `generate: true` in pubspec.yaml.

### D-UI-012: Style Guide Access
**Context**: Need quick access to design system components for QA and development.
**Decision**: Expose `/style-guide` route and add link from Settings → Dev Tools.
**Rationale**: Provides easy access to component playground for testing and reference.
**Implementation**: Route already exists in `AppShell`, link to be added in Step 2.

### D-UI-013: Motion Accessibility
**Context**: Need to respect user preferences for reduced motion.
**Decision**: Implement central motion control that respects platform settings.
**Rationale**: Improves accessibility and user experience for motion-sensitive users.
**Implementation**: Documented in motion tokens, to be implemented in Step 12.
