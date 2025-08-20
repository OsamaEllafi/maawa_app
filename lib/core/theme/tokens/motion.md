# Motion Tokens

## Overview
This document defines the motion tokens for the Maawa app design system, providing consistent animation timing, easing curves, and motion patterns for a cohesive user experience.

## Easing Curves

### Standard Easing
- **Standard**: `Curves.easeInOut` - General purpose, smooth transitions
- **Standard Decelerate**: `Curves.easeOut` - Entering elements, appearing content
- **Standard Accelerate**: `Curves.easeIn` - Exiting elements, disappearing content

### Emphasized Easing
- **Emphasized**: `Curves.easeInOutCubic` - Important interactions, attention-grabbing
- **Emphasized Decelerate**: `Curves.easeOutCubic` - Dramatic entrances
- **Emphasized Accelerate**: `Curves.easeInCubic` - Dramatic exits

### Specialized Easing
- **Bounce**: `Curves.elasticOut` - Playful interactions, notifications
- **Sharp**: `Curves.easeInOutBack` - Mechanical movements, precise actions

## Duration Scale

### Micro Animations (120-240ms)
- **Micro**: 120ms - Hover states, subtle feedback
- **Micro Extended**: 180ms - Small state changes
- **Micro Emphasized**: 240ms - Important micro-interactions

### Standard Animations (250-400ms)
- **Standard**: 250ms - General transitions, page changes
- **Standard Extended**: 300ms - Complex transitions
- **Standard Emphasized**: 400ms - Important transitions

### Page Transitions (400-600ms)
- **Page**: 400ms - Route transitions, screen changes
- **Page Extended**: 500ms - Complex page transitions
- **Page Emphasized**: 600ms - Dramatic page changes

## Animation Patterns

### List Animations
- **List Item Add**: 300ms with `Curves.easeOut`
- **List Item Remove**: 250ms with `Curves.easeIn`
- **List Reorder**: 400ms with `Curves.easeInOut`
- **List Stagger**: 50ms delay between items

### Sheet Animations
- **Bottom Sheet Open**: 400ms with `Curves.easeOut`
- **Bottom Sheet Close**: 300ms with `Curves.easeIn`
- **Modal Open**: 500ms with `Curves.easeOutCubic`
- **Modal Close**: 400ms with `Curves.easeInCubic`

### Route Transitions
- **Push Route**: 400ms with `Curves.easeInOut`
- **Pop Route**: 350ms with `Curves.easeInOut`
- **Replace Route**: 300ms with `Curves.easeInOut`

### Component Animations
- **Button Press**: 120ms with `Curves.easeOut`
- **Card Hover**: 200ms with `Curves.easeInOut`
- **Icon State Change**: 150ms with `Curves.easeInOut`
- **Loading Spinner**: 1000ms linear (continuous)

## Implementation Guidelines

### Flutter Animate Integration
```dart
// Micro animation
Widget().animate()
  .fadeIn(duration: 120.ms)
  .slideY(begin: 0.1, end: 0)

// Standard animation
Widget().animate()
  .fadeIn(duration: 250.ms, curve: Curves.easeOut)
  .slideX(begin: 0.1, end: 0, curve: Curves.easeOut)

// Emphasized animation
Widget().animate()
  .fadeIn(duration: 400.ms, curve: Curves.easeOutCubic)
  .scale(begin: 0.8, end: 1.0, curve: Curves.easeOutCubic)
```

### Custom Animation Curves
```dart
class MotionCurves {
  static const standard = Curves.easeInOut;
  static const standardDecelerate = Curves.easeOut;
  static const standardAccelerate = Curves.easeIn;
  static const emphasized = Curves.easeInOutCubic;
  static const emphasizedDecelerate = Curves.easeOutCubic;
  static const emphasizedAccelerate = Curves.easeInCubic;
  static const bounce = Curves.elasticOut;
  static const sharp = Curves.easeInOutBack;
}
```

### Duration Constants
```dart
class MotionDuration {
  static const micro = Duration(milliseconds: 120);
  static const microExtended = Duration(milliseconds: 180);
  static const microEmphasized = Duration(milliseconds: 240);
  static const standard = Duration(milliseconds: 250);
  static const standardExtended = Duration(milliseconds: 300);
  static const standardEmphasized = Duration(milliseconds: 400);
  static const page = Duration(milliseconds: 400);
  static const pageExtended = Duration(milliseconds: 500);
  static const pageEmphasized = Duration(milliseconds: 600);
}
```

## Accessibility Considerations

### Reduced Motion
- Respect `MediaQuery.platformBrightness` for reduced motion preferences
- Provide alternative animations for users with motion sensitivity
- Use shorter durations and simpler curves when reduced motion is enabled
- Check `MediaQuery.of(context).accessibleNavigation` for reduced motion setting
- Disable animations when `MediaQuery.of(context).accessibleNavigation` is true

### Performance
- Use `AnimationController` efficiently to avoid memory leaks
- Prefer `AnimatedBuilder` over `setState` for smooth animations
- Consider using `CustomPainter` for complex animations

### User Experience
- Ensure animations enhance rather than hinder usability
- Provide clear visual feedback for all interactions
- Maintain consistent timing across similar interactions
- Avoid excessive motion that could be distracting

## Common Animation Patterns

### Fade In/Out
```dart
Widget().animate()
  .fadeIn(duration: MotionDuration.standard, curve: MotionCurves.standardDecelerate)
  .fadeOut(duration: MotionDuration.standard, curve: MotionCurves.standardAccelerate)
```

### Slide In/Out
```dart
Widget().animate()
  .slideX(begin: 0.1, end: 0, duration: MotionDuration.standard, curve: MotionCurves.standardDecelerate)
  .slideX(begin: 0, end: -0.1, duration: MotionDuration.standard, curve: MotionCurves.standardAccelerate)
```

### Scale In/Out
```dart
Widget().animate()
  .scale(begin: 0.8, end: 1.0, duration: MotionDuration.standard, curve: MotionCurves.standardDecelerate)
  .scale(begin: 1.0, end: 0.8, duration: MotionDuration.standard, curve: MotionCurves.standardAccelerate)
```

### Staggered Animations
```dart
ListView.builder(
  itemBuilder: (context, index) {
    return Widget().animate(delay: (50 * index).ms)
      .fadeIn(duration: MotionDuration.standard, curve: MotionCurves.standardDecelerate)
      .slideY(begin: 0.1, end: 0, curve: MotionCurves.standardDecelerate);
  },
)
```
