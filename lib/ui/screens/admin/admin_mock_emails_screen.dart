import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/app_top_bar.dart';
import '../../widgets/common/skeleton_list.dart';

/// Admin mock emails screen
class AdminMockEmailsScreen extends StatefulWidget {
  const AdminMockEmailsScreen({super.key});

  @override
  State<AdminMockEmailsScreen> createState() => _AdminMockEmailsScreenState();
}

class _AdminMockEmailsScreenState extends State<AdminMockEmailsScreen> {
  final bool _isLoading = false;
  String _searchQuery = '';
  DemoMockEmail? _selectedEmail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(title: 'Mock Emails'),
      body: _isLoading
          ? const SkeletonList()
          : Row(
              children: [
                // Email list
                Expanded(
                  flex: 1,
                  child: _buildEmailList(context, theme),
                ),
                
                // Email detail viewer
                if (_selectedEmail != null)
                  Expanded(
                    flex: 2,
                    child: _buildEmailDetail(context, theme),
                  ),
              ],
            ),
    );
  }

  Widget _buildEmailList(BuildContext context, ThemeData theme) {
    final filteredEmails = _getFilteredEmails();

    return Column(
      children: [
        // Search bar
        Container(
          padding: EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          child: TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search emails...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
            ),
          ),
        ),
        
        // Email list
        Expanded(
          child: filteredEmails.isEmpty
              ? _buildEmptyState(context, theme)
              : ListView.builder(
                  itemCount: filteredEmails.length,
                  itemBuilder: (context, index) {
                    return _buildEmailListItem(
                      context,
                      email: filteredEmails[index],
                      theme: theme,
                    );
                  },
                ),
        ),
      ],
    );
  }

  List<DemoMockEmail> _getFilteredEmails() {
    var emails = DemoData.mockEmails;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      emails = emails.where((email) {
        return email.subject.toLowerCase().contains(query) ||
               email.to.toLowerCase().contains(query) ||
               email.from.toLowerCase().contains(query);
      }).toList();
    }

    return emails;
  }

  Widget _buildEmailListItem(
    BuildContext context, {
    required DemoMockEmail email,
    required ThemeData theme,
  }) {
    final isSelected = _selectedEmail?.id == email.id;
    
    return Container(
      decoration: BoxDecoration(
        color: isSelected 
            ? theme.colorScheme.primaryContainer 
            : theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSelected 
              ? theme.colorScheme.onPrimaryContainer 
              : theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            email.isRead ? Icons.mail : Icons.mail_outline,
            color: isSelected 
                ? theme.colorScheme.onPrimaryContainer 
                : theme.colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          email.subject,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: email.isRead ? FontWeight.normal : FontWeight.w600,
            color: isSelected 
                ? theme.colorScheme.onPrimaryContainer 
                : theme.colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To: ${email.to}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8)
                    : theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              _formatTimeAgo(email.createdAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.6)
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        onTap: () => setState(() => _selectedEmail = email),
      ),
    );
  }

  Widget _buildEmailDetail(BuildContext context, ThemeData theme) {
    if (_selectedEmail == null) {
      return _buildNoEmailSelected(context, theme);
    }

    return Column(
      children: [
        // Email header
        Container(
          padding: EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedEmail!.subject,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _copyEmailContent(context),
                    icon: const Icon(Icons.copy),
                    tooltip: 'Copy email content',
                  ),
                ],
              ),
              SizedBox(height: Spacing.sm),
              _buildEmailMetadata(context, theme),
            ],
          ),
        ),
        
        // Email content
        Expanded(
          child: _buildEmailContent(context, theme),
        ),
      ],
    );
  }

  Widget _buildEmailMetadata(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        _buildMetadataRow(
          context,
          icon: Icons.person_outline,
          label: 'From:',
          value: _selectedEmail!.from,
          theme: theme,
        ),
        SizedBox(height: Spacing.xs),
        _buildMetadataRow(
          context,
          icon: Icons.person,
          label: 'To:',
          value: _selectedEmail!.to,
          theme: theme,
        ),
        SizedBox(height: Spacing.xs),
        _buildMetadataRow(
          context,
          icon: Icons.schedule,
          label: 'Date:',
          value: _formatDateTime(_selectedEmail!.createdAt),
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildMetadataRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: Spacing.xs),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: Spacing.xs),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailContent(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(Spacing.md),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HTML content preview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
              ),
              child: _buildHtmlPreview(context, theme),
            ),
            SizedBox(height: Spacing.lg),
            
            // Raw HTML toggle
            _buildRawHtmlToggle(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHtmlPreview(BuildContext context, ThemeData theme) {
    // Simple HTML to text conversion for preview
    final htmlContent = _selectedEmail!.htmlContent;
    final textContent = _convertHtmlToText(htmlContent);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Preview',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: Spacing.md),
        Text(
          textContent,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildRawHtmlToggle(BuildContext context, ThemeData theme) {
    return ExpansionTile(
      title: Text(
        'View Raw HTML',
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(BorderRadiusTokens.small),
          ),
          child: SelectableText(
            _selectedEmail!.htmlContent,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoEmailSelected(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.email_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            'No email selected',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'Select an email from the list to view its content',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.email_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            'No emails found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            'Try adjusting your search',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _copyEmailContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final content = '''
Subject: ${_selectedEmail!.subject}
From: ${_selectedEmail!.from}
To: ${_selectedEmail!.to}
Date: ${_formatDateTime(_selectedEmail!.createdAt)}

${_convertHtmlToText(_selectedEmail!.htmlContent)}
    '''.trim();

    Clipboard.setData(ClipboardData(text: content));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.copy, color: AppColors.success500),
            SizedBox(width: Spacing.sm),
                            Expanded(child: Text(l10n.emailContentCopied)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
    );
  }

  String _convertHtmlToText(String html) {
    // Simple HTML to text conversion
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
        .replaceAll('&nbsp;', ' ') // Replace HTML entities
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .trim();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
