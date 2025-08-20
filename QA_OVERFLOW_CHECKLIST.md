# QA Overflow Testing Checklist

## Device Configuration
- **Target Device Size**: 360×640 dp (minimum supported)
- **Text Scale**: 1.3x (accessibility setting)
- **Languages**: English (EN) and Arabic (AR)
- **Themes**: Light and Dark modes
- **Orientation**: Portrait and Landscape

## Pre-Testing Setup
1. Set device to 360×640 dp resolution
2. Enable text scale 1.3x in system settings
3. Clear app data and restart
4. Enable developer mode for overflow warnings

## Screen-by-Screen Testing

### 1. Home Screen (`/home`)
**Test Cases:**
- [ ] App launch shows ≥6 property cards
- [ ] Toggle between grid and list views
- [ ] Rotate device to landscape
- [ ] Switch between EN/AR languages
- [ ] Toggle light/dark themes
- [ ] Apply filters and verify results display
- [ ] Clear filters returns full list
- [ ] Search functionality works without overflow
- [ ] No red/yellow overflow warnings in console

**Expected Behavior:**
- Properties display in both grid (2-column) and list (horizontal) layouts
- Text scales properly without clipping
- Arabic text flows correctly in RTL
- Filters bar doesn't overflow horizontally

### 2. Property Detail Screen (`/properties/:id`)
**Test Cases:**
- [ ] Media carousel displays without overflow
- [ ] Video plays in bounded container
- [ ] Long property titles ellipsize properly
- [ ] Amenities chips wrap to multiple lines
- [ ] Description text scrolls within bounds
- [ ] Reviews section doesn't overflow
- [ ] CTA buttons remain accessible
- [ ] Rotate device during carousel viewing

**Expected Behavior:**
- Carousel maintains 16:9 aspect ratio
- All text content fits within screen bounds
- Amenities wrap gracefully without horizontal overflow
- Video player respects container constraints

### 3. Owner Properties Screen (`/owner/properties`)
**Test Cases:**
- [ ] Tab switching works smoothly
- [ ] Each tab has independent scroll state
- [ ] Long property lists scroll without jitter
- [ ] Property cards maintain consistent height
- [ ] Add/Edit buttons remain accessible
- [ ] Status badges don't overflow

**Expected Behavior:**
- Single scrollable per tab
- No nested scrollable conflicts
- Tab content preserves scroll position
- All UI elements remain within bounds

### 4. Property Editor Screen (`/owner/properties/edit`)
**Test Cases:**
- [ ] Form scrolls when keyboard opens
- [ ] All form fields remain accessible
- [ ] Media upload area has bounded height
- [ ] Save/Cancel buttons stay reachable
- [ ] Long text inputs don't overflow
- [ ] Validation messages display properly

**Expected Behavior:**
- Form scrolls smoothly with keyboard
- Bottom padding prevents keyboard overlap
- All form elements remain interactive
- No horizontal overflow in text fields

### 5. Booking Detail Screen (`/bookings/:id`)
**Test Cases:**
- [ ] Timeline displays without overflow
- [ ] Countdown badge fits on screen
- [ ] Status indicators remain visible
- [ ] Long booking details wrap properly
- [ ] Action buttons accessible
- [ ] Payment information displays correctly

**Expected Behavior:**
- Timeline fits within screen bounds
- All status information visible
- Text content wraps appropriately
- No horizontal scrolling required

### 6. Wallet Screen (`/wallet`)
**Test Cases:**
- [ ] Balance display fits on screen
- [ ] Transaction history scrolls smoothly
- [ ] Skeleton loading displays properly
- [ ] Top-up/Withdraw buttons accessible
- [ ] Long transaction descriptions wrap
- [ ] Currency formatting displays correctly

**Expected Behavior:**
- Balance prominently displayed
- Transaction list scrolls independently
- Skeleton replaces with actual data
- All amounts formatted consistently

### 7. Authentication Screens
**Test Cases:**
- [ ] Login form scrolls with keyboard
- [ ] Registration form fits all fields
- [ ] Password reset form accessible
- [ ] Error messages display properly
- [ ] Form validation works without overflow

**Expected Behavior:**
- Forms scroll when keyboard appears
- All fields remain accessible
- Error states display clearly
- No horizontal overflow

### 8. KYC Screen (`/profile/kyc`)
**Test Cases:**
- [ ] Form scrolls with keyboard open
- [ ] Document upload area bounded
- [ ] All form fields accessible
- [ ] Validation messages visible
- [ ] Submit button reachable

**Expected Behavior:**
- Form scrolls smoothly
- Upload area has defined bounds
- All validation feedback visible
- No overflow with keyboard

## Language-Specific Testing

### Arabic (AR) Testing
- [ ] RTL layout flows correctly
- [ ] Long Arabic words don't overflow
- [ ] Numbers display in Arabic-Indic format
- [ ] Text alignment respects RTL
- [ ] Icons and chevrons mirror correctly

### English (EN) Testing
- [ ] LTR layout flows correctly
- [ ] Long English titles ellipsize
- [ ] Numbers display in Latin format
- [ ] Text alignment respects LTR

## Text Scale Testing (1.3x)
- [ ] All text remains readable
- [ ] No text clipping occurs
- [ ] Buttons maintain minimum 48dp touch targets
- [ ] Form fields remain accessible
- [ ] Navigation elements stay functional

## Theme Testing
- [ ] Light theme displays correctly
- [ ] Dark theme displays correctly
- [ ] Theme switching doesn't cause overflow
- [ ] Colors maintain proper contrast
- [ ] No visual artifacts during theme changes

## Orientation Testing
- [ ] Portrait mode works correctly
- [ ] Landscape mode adapts properly
- [ ] Rotation doesn't cause overflow
- [ ] Content reflows appropriately
- [ ] Navigation remains accessible

## Performance Testing
- [ ] No frame drops during scrolling
- [ ] Smooth transitions between screens
- [ ] No memory leaks during testing
- [ ] App remains responsive
- [ ] No excessive CPU usage

## Accessibility Testing
- [ ] Screen reader compatibility
- [ ] Focus navigation works
- [ ] Touch targets meet minimum size
- [ ] Color contrast meets WCAG AA
- [ ] Reduced motion support

## Common Overflow Issues to Check
- [ ] Horizontal overflow in lists
- [ ] Vertical overflow in forms
- [ ] Text clipping in cards
- [ ] Button overflow in headers
- [ ] Media overflow in carousels
- [ ] Chip overflow in filters
- [ ] Navigation overflow in tabs

## Debug Tools Usage
- [ ] Layout Debug Panel accessible from Dev Tools
- [ ] Text scale preview works (1.0, 1.15, 1.3)
- [ ] Layout hints overlay displays correctly
- [ ] Sample preview area shows overflow scenarios

## Pass/Fail Criteria
- **PASS**: No red/yellow overflow warnings in console
- **PASS**: All content fits within screen bounds
- **PASS**: Smooth scrolling without jitter
- **PASS**: All interactive elements accessible
- **PASS**: Text scales properly without clipping
- **PASS**: RTL/LTR layouts work correctly

## Reporting
For each failed test case:
1. Document the specific screen and action
2. Note the device configuration (size, scale, language, theme)
3. Capture screenshot of overflow
4. Record console warnings/errors
5. Describe expected vs actual behavior

## Notes
- Test on actual device when possible
- Use browser dev tools for responsive testing
- Enable Flutter inspector for detailed layout analysis
- Check both debug and release builds
- Verify on different Android/iOS versions
