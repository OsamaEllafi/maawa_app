# Spacing Tokens

## Overview
This document defines the spacing tokens for the Maawa app design system, providing a consistent 4pt base unit system for margins, padding, and layout spacing.

## Base Unit System
- **Base Unit**: 4px (0.25rem)
- **Scale**: 4pt increments for consistent spacing
- **Responsive**: Scales with device pixel density and accessibility settings

## Spacing Scale

### Micro Spacing (0-16px)
- **0**: 0px - No spacing
- **1**: 4px (0.25rem) - Minimal spacing
- **2**: 8px (0.5rem) - Small spacing
- **3**: 12px (0.75rem) - Medium-small spacing
- **4**: 16px (1rem) - Base spacing unit

### Small Spacing (20-32px)
- **5**: 20px (1.25rem) - Small-medium spacing
- **6**: 24px (1.5rem) - Medium spacing
- **7**: 28px (1.75rem) - Medium-large spacing
- **8**: 32px (2rem) - Large spacing

### Medium Spacing (36-64px)
- **9**: 36px (2.25rem) - Large-medium spacing
- **10**: 40px (2.5rem) - Extra large spacing
- **12**: 48px (3rem) - Section spacing
- **16**: 64px (4rem) - Major section spacing

### Large Spacing (80px+)
- **20**: 80px (5rem) - Page-level spacing
- **24**: 96px (6rem) - Screen-level spacing
- **32**: 128px (8rem) - Maximum spacing

## Usage Guidelines

### Component Spacing
- **Internal Padding**: 16px (4) for most components
- **Component Margins**: 8px (2) between related components
- **Section Spacing**: 24px (6) between major sections
- **Page Margins**: 16px (4) on mobile, 24px (6) on tablet/desktop

### Touch Targets
- **Minimum Touch Target**: 48px (12) for interactive elements
- **Button Padding**: 12px (3) vertical, 16px (4) horizontal
- **Icon Button Size**: 48px (12) for accessibility compliance

### Layout Spacing
- **Grid Gutter**: 16px (4) for content grids
- **Card Spacing**: 16px (4) between cards
- **List Item Spacing**: 8px (2) between list items
- **Form Field Spacing**: 16px (4) between form fields

### Responsive Spacing
- **Mobile**: Use smaller spacing values (1-8)
- **Tablet**: Use medium spacing values (4-12)
- **Desktop**: Use larger spacing values (6-16)

## Border Radius

### Component Radius
- **Small**: 4px (1) - Buttons, small components
- **Medium**: 8px (2) - Cards, medium components
- **Large**: 12px (3) - Modals, large components
- **Extra Large**: 16px (4) - Full-screen overlays

### Special Cases
- **Pill**: 50% - Rounded buttons, chips
- **Circle**: 50% - Avatar images, circular buttons

## Elevation/Shadow

### Shadow Levels
- **Level 1**: Subtle elevation for cards and surfaces
- **Level 2**: Medium elevation for floating elements
- **Level 3**: High elevation for modals and overlays
- **Level 4**: Maximum elevation for tooltips and dropdowns

### Shadow Properties
```dart
// Level 1
BoxShadow(
  offset: Offset(0, 1),
  blurRadius: 3,
  color: Colors.black.withOpacity(0.12),
)

// Level 2
BoxShadow(
  offset: Offset(0, 3),
  blurRadius: 6,
  color: Colors.black.withOpacity(0.16),
)

// Level 3
BoxShadow(
  offset: Offset(0, 6),
  blurRadius: 12,
  color: Colors.black.withOpacity(0.20),
)

// Level 4
BoxShadow(
  offset: Offset(0, 12),
  blurRadius: 24,
  color: Colors.black.withOpacity(0.24),
)
```

## Implementation

### Spacing Constants
```dart
class Spacing {
  static const double xs = 4.0;   // 1
  static const double sm = 8.0;   // 2
  static const double md = 16.0;  // 4
  static const double lg = 24.0;  // 6
  static const double xl = 32.0;  // 8
  static const double xxl = 48.0; // 12
}
```

### Usage Examples
```dart
// Padding
Padding(
  padding: EdgeInsets.all(Spacing.md), // 16px
  child: Widget(),
)

// Margin
Container(
  margin: EdgeInsets.symmetric(
    horizontal: Spacing.sm, // 8px
    vertical: Spacing.lg,   // 24px
  ),
  child: Widget(),
)

// Gap
Column(
  children: [
    Widget1(),
    SizedBox(height: Spacing.md), // 16px gap
    Widget2(),
  ],
)
```

## Accessibility Considerations
- Maintain minimum 48px touch targets regardless of spacing
- Ensure sufficient spacing for users with motor impairments
- Support system accessibility settings for spacing preferences
- Provide clear visual separation between interactive elements
