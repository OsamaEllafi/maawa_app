# Booking Widgets

This directory contains reusable widgets for the booking functionality in the Maawa app.

## Components

### BookingStatusChip

A chip widget that displays booking status with appropriate colors and icons.

**Features:**
- Displays different booking statuses (Requested, Pending Payment, Confirmed, Completed, Cancelled, Expired)
- Color-coded status indicators
- Compact and full-size variants
- Consistent styling with the app's design system

**Usage:**
```dart
BookingStatusChip(
  status: BookingStatus.pendingPayment,
  compact: true, // Optional, defaults to false
)
```

**Status Colors:**
- Requested: Warning (orange)
- Pending Payment: Primary (blue)
- Confirmed: Success (green)
- Completed: Success (dark green)
- Cancelled: Error (red)
- Expired: Secondary (gray)

### CountdownBadge

A countdown widget that displays a 30-minute countdown with smooth animations.

**Features:**
- Real-time countdown timer
- Smooth pulse animation when time is running low
- Color changes based on remaining time
- Automatic expiration handling
- Configurable display format (with/without seconds)

**Usage:**
```dart
CountdownBadge(
  endTime: DateTime.now().add(Duration(minutes: 30)),
  onExpired: () {
    // Handle expiration
  },
  showSeconds: true, // Optional, defaults to true
)
```

**Animation Behavior:**
- Normal state: Blue color, no animation
- < 5 minutes: Orange color, slow pulse
- < 1 minute: Red color, fast pulse
- Expired: Red color, no animation

## Booking Status Enum

The `BookingStatus` enum defines all possible booking states:

```dart
enum BookingStatus {
  requested,
  pendingPayment,
  confirmed,
  completed,
  cancelled,
  expired,
}
```

## Design System Integration

Both widgets follow the app's design system:
- Use `AppColors` for consistent color theming
- Follow `Spacing` constants for consistent spacing
- Use `BorderRadiusTokens` for consistent border radius
- Support both light and dark themes
- RTL (Arabic) text support

## Accessibility

- High contrast colors for status indicators
- Clear visual hierarchy
- Screen reader friendly labels
- Reduced motion support for animations

## Localization

All text strings are localized and support both English and Arabic:
- Status labels
- Time formatting
- Error messages
- Action buttons

## Usage Examples

### In a Booking Card
```dart
Card(
  child: ListTile(
    title: Text('Property Name'),
    subtitle: Row(
      children: [
        BookingStatusChip(status: booking.status, compact: true),
        if (booking.status == BookingStatus.pendingPayment)
          CountdownBadge(endTime: booking.paymentDeadline),
      ],
    ),
  ),
)
```

### In a Booking Detail Screen
```dart
Column(
  children: [
    BookingStatusChip(status: booking.status),
    if (booking.status == BookingStatus.pendingPayment)
      CountdownBadge(
        endTime: booking.paymentDeadline,
        onExpired: () => handlePaymentExpired(),
      ),
  ],
)
```
