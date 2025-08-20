import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../common/app_top_bar.dart';

/// Debug panel for testing layout overflow scenarios
class LayoutDebugPanel extends StatefulWidget {
  const LayoutDebugPanel({super.key});

  @override
  State<LayoutDebugPanel> createState() => _LayoutDebugPanelState();
}

class _LayoutDebugPanelState extends State<LayoutDebugPanel> {
  double _textScaleFactor = 1.0;
  bool _showLayoutHints = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: 'Layout Debug Panel',
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(_textScaleFactor),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simulate Small Screen',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Spacing.sm),
                    Text(
                      'This panel helps test overflow scenarios on small devices (360×640 dp) with different text scales.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              SizedBox(height: Spacing.xl),

              // Text Scale Controls
              Text(
                'Text Scale Preview',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Spacing.md),
              Row(
                children: [
                  _buildScaleButton(1.0, '1.0'),
                  SizedBox(width: Spacing.sm),
                  _buildScaleButton(1.15, '1.15'),
                  SizedBox(width: Spacing.sm),
                  _buildScaleButton(1.3, '1.3'),
                ],
              ),

              SizedBox(height: Spacing.xl),

              // Layout Hints Toggle
              Row(
                children: [
                  Text(
                    'Show Layout Hints',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _showLayoutHints,
                    onChanged: (value) {
                      setState(() {
                        _showLayoutHints = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: Spacing.sm),
              Text(
                'Draws non-interactive guides to help identify layout boundaries and potential overflow areas.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              SizedBox(height: Spacing.xl),

              // Sample Preview Area
              Text(
                'Sample Preview Area',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Spacing.md),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                ),
                child: _showLayoutHints
                    ? _buildLayoutHintsPreview(theme)
                    : _buildSampleContent(theme),
              ),

              SizedBox(height: Spacing.xl),

              // Instructions
              Text(
                'Testing Instructions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Spacing.md),
              _buildInstructionItem(
                theme,
                '1. Set text scale to 1.3',
                'This simulates accessibility settings that can cause overflow.',
              ),
              _buildInstructionItem(
                theme,
                '2. Enable layout hints',
                'Visual guides help identify problematic areas.',
              ),
              _buildInstructionItem(
                theme,
                '3. Test on small screens',
                'Use browser dev tools or emulator to test 360×640 dp.',
              ),
              _buildInstructionItem(
                theme,
                '4. Check Arabic text',
                'Long Arabic words can cause horizontal overflow.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScaleButton(double scale, String label) {
    final theme = Theme.of(context);
    final isSelected = _textScaleFactor == scale;

    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _textScaleFactor = scale;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHighest,
          foregroundColor: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildLayoutHintsPreview(ThemeData theme) {
    return Stack(
      children: [
        // Sample content
        _buildSampleContent(theme),
        
        // Layout hints overlay
        CustomPaint(
          painter: LayoutHintsPainter(theme),
          size: Size.infinite,
        ),
      ],
    );
  }

  Widget _buildSampleContent(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.all(Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sample property card
          Container(
            padding: EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
              border: Border.all(
                color: theme.colorScheme.outline,
              ),
            ),
            child: Row(
              children: [
                // Sample image
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
                  ),
                  child: Icon(
                    Icons.home,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: Spacing.sm),
                // Sample content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sample Property Title That Might Be Long',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        'Sample Location',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.warning500,
                          ),
                          SizedBox(width: Spacing.xs),
                          Text(
                            '4.5 (123)',
                            style: theme.textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Text(
                            'د.ل 1,234',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: Spacing.md),
          
          // Sample filters
          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.xs,
            children: [
              _buildSampleChip(theme, 'Wi-Fi'),
              _buildSampleChip(theme, 'Air Conditioning'),
              _buildSampleChip(theme, 'Kitchen'),
              _buildSampleChip(theme, 'Parking'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSampleChip(ThemeData theme, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildInstructionItem(ThemeData theme, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: Spacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Spacing.xs),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for drawing layout hints
class LayoutHintsPainter extends CustomPainter {
  final ThemeData theme;

  LayoutHintsPainter(this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.colorScheme.primary.withValues(alpha: 0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw grid lines
    const gridSize = 20.0;
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw safe area indicators
    final safePaint = Paint()
      ..color = theme.colorScheme.error.withValues(alpha: 0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Top safe area
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, 50),
      safePaint,
    );

    // Bottom safe area
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 50, size.width, 50),
      safePaint,
    );

    // Left safe area
    canvas.drawRect(
      Rect.fromLTWH(0, 0, 20, size.height),
      safePaint,
    );

    // Right safe area
    canvas.drawRect(
      Rect.fromLTWH(size.width - 20, 0, 20, size.height),
      safePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
