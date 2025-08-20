# Open Questions

This document tracks unresolved design and implementation questions that need decisions.

## Open Questions

### UI/UX Design
- **Q-UI-001**: Should Arabic brand spelling be "معاوة" or "Maawa"? Consider brand recognition vs. localization.
- **Q-UI-002**: Icon style preference - outlined vs. filled? Consider consistency with Material Design 3.
- **Q-UI-003**: Amenity taxonomy - use standardized categories or custom property-specific tags?

### Performance & Technical
- **Q-UI-004**: Animation performance on lower-end devices - should we implement quality tiers?
- **Q-UI-005**: Image caching strategy - how long to cache property images vs. user avatars?
- **Q-UI-006**: Offline support scope - which screens should work without network?

### User Experience
- **Q-UI-007**: Onboarding flow - single screen vs. multi-step walkthrough?
- **Q-UI-008**: Search filters - advanced filters vs. simple search with smart suggestions?
- **Q-UI-009**: Booking flow - one-page vs. multi-step wizard?
- **Q-UI-010**: Voice navigation support - implement voice commands for accessibility?

### Accessibility
- **Q-UI-011**: High contrast mode - implement custom high contrast theme beyond system settings?

### Navigation & Routing
- **Q-NAV-001**: Route parameter validation - how strict should we be with invalid IDs? Show 404 vs. empty state?
- **Q-NAV-002**: Role-based navigation patterns - should different roles have completely different navigation structures or shared components?

## Resolved Questions

### Previously Resolved
- **Q-UI-001**: Font pairing - Resolved: Almarai for Arabic, Inter for Latin scripts
- **Q-UI-002**: Color scheme - Resolved: Material Design 3 with custom semantic colors
- **Q-UI-003**: Localization approach - Resolved: Flutter intl with ARB files

## Step 3 - Auth & Onboarding UIs

### Arabic/English Copy
- **Question**: Should Arabic copy use formal or informal tone?
- **Context**: Arabic has formal (fuṣḥā) and informal (ʿāmmiyya) variants
- **Options**: 
  - Formal: More professional, consistent with business apps
  - Informal: More approachable, matches modern app UX
- **Decision**: Pending team review

### Arabic-Indic Digits
- **Question**: Use Arabic-Indic digits (٠١٢٣٤٥٦٧٨٩) or Western digits (0123456789)?
- **Context**: Arabic locale traditionally uses Arabic-Indic digits
- **Options**:
  - Arabic-Indic: More culturally appropriate
  - Western: More universal, easier for international users
- **Decision**: Pending team review

### Avatar Picker Options
- **Question**: What avatar options should be available?
- **Context**: Need to balance inclusivity with simplicity
- **Options**:
  - Initials-based (current): Simple, works for all names
  - Icon-based: More visual, but limited options
  - Photo upload: Most personal, but requires permissions
- **Decision**: Pending team review

### Error Copy Tone/Style
- **Question**: Final tone/style for error copy (short vs descriptive)?
- **Context**: Balance between clarity and brevity
- **Options**:
  - Short: "Invalid email" - concise but less helpful
  - Descriptive: "Please enter a valid email address" - helpful but longer
- **Decision**: Pending team review

### Snackbar vs Dialog Patterns
- **Question**: Snackbar vs dialog for certain successes (e.g., KYC submitted) — which is the final pattern?
- **Context**: Different success types need different feedback patterns
- **Options**:
  - Snackbar: Non-intrusive, good for quick confirmations
  - Dialog: More prominent, good for important actions
- **Decision**: Pending team review

## Step 4 - Property UIs

### Final Amenity Taxonomy
- **Question**: Final amenity taxonomy (current seed is fine; confirm names/icons later)?
- **Context**: Current seed includes 12 amenities; need to confirm final list
- **Options**:
  - Keep current 12: Wi-Fi, Air Conditioning, Heating, Kitchen, Washer, Parking, TV, Elevator, Workspace, Pool, Balcony, Pet-friendly
  - Add more: Gym, Security, Garden, etc.
  - Reduce: Focus on most common amenities
- **Decision**: Pending team review

### Default View for Home
- **Question**: Default view for Home: List or Grid?
- **Context**: Need to decide initial view preference
- **Options**:
  - List: More information visible, better for browsing
  - Grid: More visual, better for quick scanning
- **Decision**: Pending team review

### Video Auto-play Policy
- **Question**: Should video auto-play on the detail screen by default or require an explicit tap to play?
- **Context**: Balance between engagement and user control
- **Options**:
  - Auto-play: More engaging, shows content immediately
  - Tap to play: User has control, respects bandwidth
- **Decision**: Don't auto-play by default—even when reduced-motion is OFF
