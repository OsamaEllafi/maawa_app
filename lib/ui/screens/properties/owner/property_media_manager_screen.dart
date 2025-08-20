import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/common/app_top_bar.dart';

/// Property media manager screen for managing property images and videos
class PropertyMediaManagerScreen extends StatefulWidget {
  const PropertyMediaManagerScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  State<PropertyMediaManagerScreen> createState() =>
      _PropertyMediaManagerScreenState();
}

class _PropertyMediaManagerScreenState
    extends State<PropertyMediaManagerScreen> {
  List<MediaItem> _mediaItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMediaItems();
  }

  void _loadMediaItems() {
    // Simulate loading media items
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _mediaItems = [
            MediaItem(
              id: '1',
              type: MediaType.image,
              url: 'assets/images/property_1.jpg',
              thumbnail: 'assets/images/property_1.jpg',
              isPrimary: true,
            ),
            MediaItem(
              id: '2',
              type: MediaType.image,
              url: 'assets/images/property_2.jpg',
              thumbnail: 'assets/images/property_2.jpg',
              isPrimary: false,
            ),
            MediaItem(
              id: '3',
              type: MediaType.video,
              url: 'assets/videos/property_tour.mp4',
              thumbnail: 'assets/images/video_thumbnail.jpg',
              isPrimary: false,
            ),
            MediaItem(
              id: '4',
              type: MediaType.image,
              url: 'assets/images/property_3.jpg',
              thumbnail: 'assets/images/property_3.jpg',
              isPrimary: false,
            ),
            MediaItem(
              id: '5',
              type: MediaType.image,
              url: 'assets/images/property_4.jpg',
              thumbnail: 'assets/images/property_4.jpg',
              isPrimary: false,
            ),
          ];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: l10n.mediaManager,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: _addMedia,
            tooltip: l10n.addMedia,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header with instructions
                Container(
                  padding: EdgeInsets.all(Spacing.md),
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      SizedBox(width: Spacing.sm),
                      Expanded(
                        child: Text(
                          l10n.mediaManagerInstructions,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Media grid
                Expanded(
                  child: _mediaItems.isEmpty
                      ? _buildEmptyState()
                      : ReorderableListView.builder(
                          padding: EdgeInsets.all(Spacing.md),
                          itemCount: _mediaItems.length,
                          onReorder: _onReorder,
                          itemBuilder: (context, index) {
                            final item = _mediaItems[index];
                            return KeyedSubtree(
                              key: ValueKey(item.id),
                              child: _buildMediaItem(item, index)
                                  .animate()
                                  .fadeIn(
                                    delay: (index * 100).ms,
                                    duration: 400.ms,
                                  )
                                  .slideX(begin: 0.3),
                            );
                          },
                        ),
                ),

                // Bottom actions
                if (_mediaItems.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(Spacing.md),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border(
                        top: BorderSide(
                          color: theme.colorScheme.outline.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _addMedia,
                            icon: const Icon(Icons.add_photo_alternate),
                            label: Text(l10n.addMoreMedia),
                          ),
                        ),
                        SizedBox(width: Spacing.md),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _saveChanges,
                            icon: const Icon(Icons.save),
                            label: Text(l10n.saveChanges),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildMediaItem(MediaItem item, int index) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            // Media thumbnail
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                child: item.type == MediaType.video
                    ? _buildVideoThumbnail(item)
                    : _buildImageThumbnail(item),
              ),
            ),

            // Primary badge
            if (item.isPrimary)
              Positioned(
                top: Spacing.sm,
                left: Spacing.sm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.small,
                    ),
                  ),
                  child: Text(
                    l10n.primary,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // Video indicator
            if (item.type == MediaType.video)
              Positioned(
                top: Spacing.sm,
                right: Spacing.sm,
                child: Container(
                  padding: EdgeInsets.all(Spacing.xs),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.small,
                    ),
                  ),
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 20),
                ),
              ),

            // Drag handle
            Positioned(
              bottom: Spacing.sm,
              right: Spacing.sm,
              child: Semantics(
                label: 'Drag to reorder',
                child: Container(
                  padding: EdgeInsets.all(Spacing.xs),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(
                      BorderRadiusTokens.small,
                    ),
                  ),
                  child: Icon(Icons.drag_handle, color: Colors.white, size: 16),
                ),
              ),
            ),

            // Action buttons overlay
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Semantics(
                      label: item.isPrimary
                          ? l10n.primaryImage
                          : l10n.setAsPrimary,
                      button: true,
                      child: IconButton(
                        icon: Icon(
                          item.isPrimary ? Icons.star : Icons.star_border,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => _setPrimary(item),
                        tooltip: item.isPrimary
                            ? l10n.primaryImage
                            : l10n.setAsPrimary,
                      ),
                    ),
                    Semantics(
                      label: l10n.deleteMedia,
                      button: true,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => _deleteMedia(item),
                        tooltip: l10n.deleteMedia,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(MediaItem item) {
    return Image.asset(
      item.thumbnail,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image, size: 48, color: Colors.grey),
        );
      },
    );
  }

  Widget _buildVideoThumbnail(MediaItem item) {
    return Stack(
      children: [
        Image.asset(
          item.thumbnail,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(
                Icons.video_library,
                size: 48,
                color: Colors.grey,
              ),
            );
          },
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: Spacing.md),
          Text(
            l10n.noMediaItems,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Spacing.sm),
          Text(
            l10n.addMediaToGetStarted,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Spacing.lg),
          ElevatedButton.icon(
            onPressed: _addMedia,
            icon: const Icon(Icons.add_photo_alternate),
            label: Text(l10n.addFirstMedia),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8));
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _mediaItems.removeAt(oldIndex);
      _mediaItems.insert(newIndex, item);
    });
  }

  void _addMedia() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.addMedia, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: Spacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.pop();
                      _simulateAddImage();
                    },
                    icon: const Icon(Icons.photo),
                    label: Text(l10n.addPhoto),
                  ),
                ),
                SizedBox(width: Spacing.md),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.pop();
                      _simulateAddVideo();
                    },
                    icon: const Icon(Icons.videocam),
                    label: Text(l10n.addVideo),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.md),
            TextButton(
              onPressed: () => context.pop(),
              child: Text(l10n.cancel),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateAddImage() {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _mediaItems.add(
        MediaItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: MediaType.image,
          url: 'assets/images/property_new.jpg',
          thumbnail: 'assets/images/property_new.jpg',
          isPrimary: false,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.imageAddedSuccessfully),
        backgroundColor: AppColors.success500,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _simulateAddVideo() {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _mediaItems.add(
        MediaItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: MediaType.video,
          url: 'assets/videos/property_new.mp4',
          thumbnail: 'assets/images/video_thumbnail_new.jpg',
          isPrimary: false,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.videoAddedSuccessfully),
        backgroundColor: AppColors.success500,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _setPrimary(MediaItem item) {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      for (final mediaItem in _mediaItems) {
        mediaItem.isPrimary = mediaItem.id == item.id;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.primaryImageSet),
        backgroundColor: AppColors.success500,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteMedia(MediaItem item) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteMedia),
        content: Text(l10n.deleteMediaConfirmation),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text(l10n.cancel)),
          ElevatedButton(
            onPressed: () {
              context.pop();
              setState(() {
                _mediaItems.removeWhere((media) => media.id == item.id);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.mediaDeletedSuccessfully),
                  backgroundColor: AppColors.success500,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error500,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.mediaChangesSaved),
        backgroundColor: AppColors.success500,
        behavior: SnackBarBehavior.floating,
      ),
    );

    context.pop();
  }
}

/// Media item model
class MediaItem {
  final String id;
  final MediaType type;
  final String url;
  final String thumbnail;
  bool isPrimary;

  MediaItem({
    required this.id,
    required this.type,
    required this.url,
    required this.thumbnail,
    this.isPrimary = false,
  });
}

/// Media type enum
enum MediaType { image, video }
