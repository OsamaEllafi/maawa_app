# UI Widgets

## Overview
This directory contains reusable UI components for the Maawa app design system. All components follow the design tokens and support both light/dark themes and RTL languages.

## Component Categories

### Buttons
- **PrimaryButton**: Main call-to-action buttons
- **SecondaryButton**: Secondary actions
- **OutlinedButton**: Bordered buttons for less prominent actions
- **TextButton**: Text-only buttons
- **IconButton**: Icon-only buttons with proper touch targets

### Inputs
- **TextField**: Standard text input with validation
- **EmailField**: Email-specific input with validation
- **PasswordField**: Password input with show/hide toggle
- **SearchField**: Search input with clear functionality
- **MultilineField**: Multi-line text input
- **SelectField**: Dropdown selection component

### Cards
- **BasicCard**: Simple card container
- **ElevatedCard**: Card with shadow elevation
- **OutlinedCard**: Card with border outline
- **PropertyCard**: Specialized card for property listings
- **BookingCard**: Specialized card for booking information

### Navigation
- **AppBar**: Custom app bar with theme support
- **BottomNavigationBar**: Bottom navigation with icons
- **TabBar**: Tab navigation component
- **Breadcrumb**: Navigation breadcrumbs

### Feedback
- **LoadingSpinner**: Loading indicator
- **Skeleton**: Content loading placeholders with subtle shimmer (≤1s cycle)
- **EmptyState**: Empty state illustrations
- **ErrorState**: Error state with retry options
- **SuccessMessage**: Success feedback component

### Media
- **ImageCarousel**: Image gallery with pagination
- **VideoPlayer**: Video playback component
- **Avatar**: User profile images
- **MediaGrid**: Grid layout for media content

### Data Display
- **PropertyList**: List of properties with filtering
- **BookingList**: List of bookings with status
- **ReviewList**: List of reviews with ratings
- **TransactionList**: List of wallet transactions

### Forms
- **FormField**: Wrapper for form inputs
- **FormSection**: Grouped form sections
- **ValidationMessage**: Form validation feedback
- **SubmitButton**: Form submission button

### Overlays
- **Modal**: Full-screen modal overlay
- **BottomSheet**: Bottom sheet overlay
- **Dialog**: Confirmation dialogs
- **Tooltip**: Contextual help tooltips

### Specialized Components
- **RatingControl**: Star rating component
- **CountdownBadge**: Time-based countdown display
- **RoleSimulator**: Development tool for role switching
- **LanguageSelector**: Language switching component
- **ThemeToggle**: Theme switching component

## Usage Guidelines

### Component Structure
```dart
class ComponentName extends StatelessWidget {
  const ComponentName({
    super.key,
    required this.parameter,
    this.optionalParameter,
  });

  final String parameter;
  final String? optionalParameter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return Widget();
  }
}
```

### Theme Integration
- All components use `Theme.of(context)` for colors and typography
- Support both light and dark themes automatically
- Use semantic color tokens from the design system

### Localization
- All text content uses `AppLocalizations.of(context)!`
- Support both English and Arabic languages
- RTL layout automatically handled by Flutter

### Accessibility
- Minimum 48dp touch targets for interactive elements
- Proper semantic labels and hints
- Support for screen readers
- Keyboard navigation support

### Responsive Design
- Components adapt to different screen sizes
- Use responsive breakpoints for layout changes
- Maintain usability on small screens

## Component Examples

### Button Usage
```dart
PrimaryButton(
  onPressed: () => handleAction(),
  child: Text(l10n.common.save),
)

SecondaryButton(
  onPressed: () => handleCancel(),
  child: Text(l10n.common.cancel),
)
```

### Input Usage
```dart
TextField(
  controller: textController,
  decoration: InputDecoration(
    labelText: l10n.inputs.textField,
    hintText: l10n.inputs.placeholder,
  ),
)
```

### Card Usage
```dart
ElevatedCard(
  child: Padding(
    padding: EdgeInsets.all(Spacing.md),
    child: Text(l10n.cards.cardContent),
  ),
)
```

## Development Guidelines

### Creating New Components
1. Follow the existing naming conventions
2. Include proper documentation
3. Add accessibility support
4. Test with both themes and languages
5. Add to the style guide for preview

### Testing Components
- Test with light and dark themes
- Test with English and Arabic languages
- Test accessibility features
- Test responsive behavior
- Test with different content lengths

### Performance Considerations
- Use `const` constructors where possible
- Minimize widget rebuilds
- Use efficient layout widgets
- Consider lazy loading for large lists

## Style Guide Integration
All components are showcased in the Style Guide screen for easy reference and testing. The style guide includes:
- Component variations
- Theme switching
- Language switching
- Interactive examples
- Accessibility testing
