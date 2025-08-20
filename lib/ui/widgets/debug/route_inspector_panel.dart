import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/app_top_bar.dart';

/// Route Inspector panel for debugging route information
/// Shows current route details and provides copy functionality
class RouteInspectorPanel extends StatelessWidget {
  const RouteInspectorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routerState = GoRouterState.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Route Inspector'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              context,
              title: 'Current Location',
              content: routerState.uri.toString(),
              icon: Icons.location_on_outlined,
              canCopy: true,
            ),
            SizedBox(height: Spacing.md),
            
            _buildInfoCard(
              context,
              title: 'Matched Location',
              content: routerState.matchedLocation,
              icon: Icons.route_outlined,
              canCopy: true,
            ),
            SizedBox(height: Spacing.md),

            if (routerState.pathParameters.isNotEmpty) ...[
                             _buildInfoCard(
                 context,
                 title: 'Path Parameters',
                 content: routerState.pathParameters.toString(),
                 icon: Icons.code_outlined,
                 canCopy: true,
               ),
              SizedBox(height: Spacing.md),
            ],

            if (routerState.uri.queryParameters.isNotEmpty) ...[
              _buildInfoCard(
                context,
                title: 'Query Parameters',
                content: routerState.uri.queryParameters.toString(),
                icon: Icons.query_stats_outlined,
                canCopy: true,
              ),
              SizedBox(height: Spacing.md),
            ],

            if (routerState.uri.fragment.isNotEmpty) ...[
              _buildInfoCard(
                context,
                title: 'Fragment',
                content: routerState.uri.fragment,
                icon: Icons.link_outlined,
                canCopy: true,
              ),
              SizedBox(height: Spacing.md),
            ],

            _buildInfoCard(
              context,
              title: 'Route Name',
              content: routerState.name ?? 'No name',
              icon: Icons.label_outlined,
              canCopy: routerState.name != null,
            ),
            SizedBox(height: Spacing.md),

            _buildInfoCard(
              context,
              title: 'Extra Data',
              content: routerState.extra?.toString() ?? 'No extra data',
              icon: Icons.data_object_outlined,
              canCopy: routerState.extra != null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    required bool canCopy,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (canCopy)
                  IconButton(
                    icon: const Icon(Icons.copy_outlined),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: content));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copied $title to clipboard'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    tooltip: 'Copy to clipboard',
                  ),
              ],
            ),
            SizedBox(height: Spacing.sm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.sm),
                             decoration: BoxDecoration(
                 color: theme.colorScheme.surfaceContainerHighest,
                 borderRadius: BorderRadius.circular(8),
               ),
              child: SelectableText(
                content,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
