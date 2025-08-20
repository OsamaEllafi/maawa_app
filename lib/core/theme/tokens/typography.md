# Typography Tokens

## Overview
This document defines the typography tokens for the Maawa app design system, supporting both English and Arabic languages with appropriate font families and text scaling.

## Font Families

### Primary Font Stack
- **English**: 'Inter' (Google Fonts) - Modern, highly legible sans-serif
- **Arabic**: 'Almarai' (Google Fonts) - Clean, contemporary Arabic font
- **Fallback**: System default sans-serif fonts

### Font Weights
- **Light**: 300
- **Regular**: 400
- **Medium**: 500
- **SemiBold**: 600
- **Bold**: 700
- **ExtraBold**: 800

## Text Styles

### Display Styles
- **Display Large**: 57px/3.563rem, Line Height: 64px/4rem, Weight: 400
- **Display Medium**: 45px/2.813rem, Line Height: 52px/3.25rem, Weight: 400
- **Display Small**: 36px/2.25rem, Line Height: 44px/2.75rem, Weight: 400

### Headline Styles
- **Headline Large**: 32px/2rem, Line Height: 40px/2.5rem, Weight: 400
- **Headline Medium**: 28px/1.75rem, Line Height: 36px/2.25rem, Weight: 400
- **Headline Small**: 24px/1.5rem, Line Height: 32px/2rem, Weight: 400

### Title Styles
- **Title Large**: 22px/1.375rem, Line Height: 28px/1.75rem, Weight: 400
- **Title Medium**: 16px/1rem, Line Height: 24px/1.5rem, Weight: 500
- **Title Small**: 14px/0.875rem, Line Height: 20px/1.25rem, Weight: 500

### Body Styles
- **Body Large**: 16px/1rem, Line Height: 24px/1.5rem, Weight: 400
- **Body Medium**: 14px/0.875rem, Line Height: 20px/1.25rem, Weight: 400
- **Body Small**: 12px/0.75rem, Line Height: 16px/1rem, Weight: 400

### Label Styles
- **Label Large**: 14px/0.875rem, Line Height: 20px/1.25rem, Weight: 500
- **Label Medium**: 12px/0.75rem, Line Height: 16px/1rem, Weight: 500
- **Label Small**: 11px/0.688rem, Line Height: 16px/1rem, Weight: 500

## Usage Guidelines

### Text Scaling
- Support text scaling up to 130% for accessibility
- Maintain minimum touch targets (48dp) regardless of text size
- Ensure line heights scale proportionally with font size

### Language Support
- Automatically switch font family based on text language
- Maintain consistent visual hierarchy across languages
- Consider different character widths for Arabic vs English

### Accessibility
- Minimum contrast ratio: 4.5:1 for normal text
- Minimum contrast ratio: 3:1 for large text (18pt+)
- Support system font size preferences
- Provide sufficient line spacing for readability

### Responsive Typography
- Scale text sizes appropriately for different screen sizes
- Maintain readability on small screens
- Use relative units (rem) for consistent scaling

## Implementation Notes

### Google Fonts Integration
```dart
// Locale-aware font application
if (locale.languageCode == 'ar') {
  return GoogleFonts.almaraiTextTheme(baseTheme.textTheme);
} else {
  return GoogleFonts.interTextTheme(baseTheme.textTheme);
}

// Fallback system
fontFamily: 'Inter, Almarai, system-ui, sans-serif'
```

### Text Theme Structure
```dart
TextTheme(
  displayLarge: TextStyle(...),
  displayMedium: TextStyle(...),
  // ... all other styles
)
```

### RTL Support
- Text alignment automatically adjusts for RTL languages
- Font family selection based on locale
- Maintain consistent spacing and layout in both directions
