import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Media carousel widget with accessibility support
class MediaCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final String? videoUrl;
  final double height;
  final double borderRadius;
  final VoidCallback? onImageTap;
  final VoidCallback? onVideoTap;

  const MediaCarousel({
    super.key,
    required this.imageUrls,
    this.videoUrl,
    this.height = 200,
    this.borderRadius = 12,
    this.onImageTap,
    this.onVideoTap,
  });

  @override
  State<MediaCarousel> createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<MediaCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _getIsReducedMotion() {
    return MediaQuery.of(context).accessibleNavigation;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allMedia = _getAllMedia();

    return Column(
      children: [
        // Main carousel
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Stack(
              children: [
                // PageView for images/videos
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: allMedia.length,
                  itemBuilder: (context, index) {
                    final media = allMedia[index];
                    return _buildMediaItem(media, index);
                  },
                ),
                
                // Navigation buttons
                if (allMedia.length > 1) ...[
                  // Previous button
                  Positioned(
                    left: Spacing.sm,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Semantics(
                        label: 'Previous image',
                        button: true,
                        child: IconButton(
                          onPressed: _currentIndex > 0 ? _previousPage : null,
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            color: theme.colorScheme.onSurface,
                            size: 32,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Next button
                  Positioned(
                    right: Spacing.sm,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Semantics(
                        label: 'Next image',
                        button: true,
                        child: IconButton(
                          onPressed: _currentIndex < allMedia.length - 1 ? _nextPage : null,
                          icon: Icon(
                            Icons.chevron_right_rounded,
                            color: theme.colorScheme.onSurface,
                            size: 32,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                
                // Video play button overlay
                if (widget.videoUrl != null && _currentIndex == 0)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Semantics(
                        label: 'Play property video',
                        button: true,
                        child: IconButton(
                          onPressed: widget.onVideoTap,
                          icon: Icon(
                            Icons.play_circle_filled_rounded,
                            color: theme.colorScheme.onSurface,
                            size: 64,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        
        // Page indicator
        if (allMedia.length > 1) ...[
          SizedBox(height: Spacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              allMedia.length,
              (index) => Semantics(
                label: 'Image ${index + 1} of ${allMedia.length}',
                selected: _currentIndex == index,
                child: AnimatedContainer(
                  duration: _getIsReducedMotion() ? Duration.zero : const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  List<MediaItem> _getAllMedia() {
    final media = <MediaItem>[];
    
    // Add video first if available
    if (widget.videoUrl != null) {
      media.add(MediaItem.video(widget.videoUrl!));
    }
    
    // Add images
    for (final imageUrl in widget.imageUrls) {
      media.add(MediaItem.image(imageUrl));
    }
    
    return media;
  }

  Widget _buildMediaItem(MediaItem media, int index) {
    return GestureDetector(
      onTap: media.isVideo ? widget.onVideoTap : widget.onImageTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: media.isVideo
            ? _buildVideoThumbnail(media.url)
            : _buildImage(media.url),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: Colors.grey[600],
          ),
        );
      },
    );
  }

  Widget _buildVideoThumbnail(String videoUrl) {
    return Stack(
      children: [
        _buildImage(videoUrl), // Use thumbnail image
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: _getIsReducedMotion() ? Duration.zero : const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_currentIndex < _getAllMedia().length - 1) {
      _pageController.nextPage(
        duration: _getIsReducedMotion() ? Duration.zero : const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

/// Media item model
class MediaItem {
  final String url;
  final bool isVideo;

  const MediaItem._({
    required this.url,
    required this.isVideo,
  });

  factory MediaItem.image(String url) => MediaItem._(url: url, isVideo: false);
  factory MediaItem.video(String url) => MediaItem._(url: url, isVideo: true);
}
