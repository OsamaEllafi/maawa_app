# Color Tokens

## Overview
This document defines the color tokens for the Maawa app design system, supporting both light and dark themes with WCAG AA accessibility compliance.

## Color Palette

### Primary Colors
- **Primary 50**: #E3F2FD (Light) / #0D47A1 (Dark) - Subtle primary background
- **Primary 100**: #BBDEFB (Light) / #1565C0 (Dark) - Light primary background
- **Primary 500**: #2196F3 (Light) / #42A5F5 (Dark) - Main primary color
- **Primary 600**: #1E88E5 (Light) / #1976D2 (Dark) - Primary hover state
- **Primary 700**: #1976D2 (Light) / #1565C0 (Dark) - Primary pressed state
- **Primary 900**: #0D47A1 (Light) / #0D47A1 (Dark) - Primary text on light surfaces

### Secondary Colors
- **Secondary 50**: #F3E5F5 (Light) / #4A148C (Dark) - Subtle secondary background
- **Secondary 100**: #E1BEE7 (Light) / #6A1B9A (Dark) - Light secondary background
- **Secondary 500**: #9C27B0 (Light) / #AB47BC (Dark) - Main secondary color
- **Secondary 600**: #8E24AA (Light) / #9C27B0 (Dark) - Secondary hover state
- **Secondary 700**: #7B1FA2 (Light) / #8E24AA (Dark) - Secondary pressed state

### Surface Colors
- **Surface 0**: #FFFFFF (Light) / #121212 (Dark) - Primary surface
- **Surface 50**: #FAFAFA (Light) / #1E1E1E (Dark) - Secondary surface
- **Surface 100**: #F5F5F5 (Light) / #2D2D2D (Dark) - Tertiary surface
- **Surface 200**: #EEEEEE (Light) / #424242 (Dark) - Elevated surface
- **Surface 300**: #E0E0E0 (Light) / #616161 (Dark) - Divider surface

### Background Colors
- **Background**: #FFFFFF (Light) / #121212 (Dark) - Main background
- **Background Secondary**: #F8F9FA (Light) / #1E1E1E (Dark) - Secondary background

### Semantic Colors

#### Success
- **Success 50**: #E8F5E8 (Light) / #1B5E20 (Dark)
- **Success 500**: #4CAF50 (Light) / #66BB6A (Dark)
- **Success 600**: #43A047 (Light) / #4CAF50 (Dark)
- **Success 700**: #388E3C (Light) / #388E3C (Dark)

#### Warning
- **Warning 50**: #FFF8E1 (Light) / #F57F17 (Dark)
- **Warning 500**: #FFC107 (Light) / #FFB300 (Dark)
- **Warning 600**: #FFB300 (Light) / #FF8F00 (Dark)
- **Warning 700**: #FFA000 (Light) / #FF6F00 (Dark)

#### Error
- **Error 50**: #FFEBEE (Light) / #C62828 (Dark)
- **Error 500**: #F44336 (Light) / #EF5350 (Dark)
- **Error 600**: #E53935 (Light) / #E53935 (Dark)
- **Error 700**: #D32F2F (Light) / #D32F2F (Dark)

### Text Colors
- **Text Primary**: #212121 (Light) / #FFFFFF (Dark) - Primary text
- **Text Secondary**: #757575 (Light) / #B3B3B3 (Dark) - Secondary text
- **Text Disabled**: #BDBDBD (Light) / #666666 (Dark) - Disabled text
- **Text Inverse**: #FFFFFF (Light) / #212121 (Dark) - Text on colored backgrounds

### State Colors
- **Hover Overlay**: rgba(0, 0, 0, 0.04) (Light) / rgba(255, 255, 255, 0.04) (Dark)
- **Pressed Overlay**: rgba(0, 0, 0, 0.08) (Light) / rgba(255, 255, 255, 0.08) (Dark)
- **Disabled Overlay**: rgba(0, 0, 0, 0.12) (Light) / rgba(255, 255, 255, 0.12) (Dark)

## Usage Guidelines

### Contrast Ratios
All color combinations must meet WCAG AA standards:
- Normal text: 4.5:1 minimum contrast ratio
- Large text: 3:1 minimum contrast ratio
- UI components: 3:1 minimum contrast ratio

### Accessibility
- Always test color combinations for sufficient contrast
- Provide alternative indicators beyond color alone
- Support high contrast mode preferences
- Consider colorblind users when choosing color combinations

### Theme Switching
- Colors automatically adapt between light and dark themes
- Maintain consistent semantic meaning across themes
- Preserve brand identity in both themes
