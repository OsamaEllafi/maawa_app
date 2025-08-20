import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../demo/demo_data.dart';
import '../../widgets/common/property_card.dart';
import '../../widgets/common/filters_bar.dart';
import '../../widgets/common/skeleton_list.dart';
import '../../../app/navigation/app_router.dart';

/// Home screen for property browsing
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<DemoProperty> _properties = [];
  List<DemoProperty> _filteredProperties = [];
  bool _isLoading = true;
  bool _isGridView = false;

  // Filter states
  String? _selectedType;
  RangeValues? _priceRange;
  int? _selectedCapacity;
  String _searchQuery = '';

  // Debug flag for diagnostics
  final bool _debugResults = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  void _loadProperties() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _properties = DemoData.properties;
          _filteredProperties = _properties;
          _isLoading = false;
        });
      }
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredProperties = _properties.where((property) {
        // Type filter
        if (_selectedType != null && property.type != _selectedType) {
          return false;
        }

        // Price range filter
        if (_priceRange != null) {
          if (property.pricePerNight < _priceRange!.start ||
              property.pricePerNight > _priceRange!.end) {
            return false;
          }
        }

        // Capacity filter
        if (_selectedCapacity != null &&
            property.capacity < _selectedCapacity!) {
          return false;
        }

        // Search filter
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          final title = property.title.toLowerCase();
          final titleAr = property.titleAr;
          final location = property.location.toLowerCase();
          final locationAr = property.locationAr;

          if (!title.contains(query) &&
              !titleAr.contains(_searchQuery) &&
              !location.contains(query) &&
              !locationAr.contains(_searchQuery)) {
            return false;
          }
        }

        return true;
      }).toList();
    });
  }

  void _onTypeChanged(String? type) {
    setState(() {
      _selectedType = type;
    });
    _applyFilters();
  }

  void _onPriceRangeChanged(RangeValues? range) {
    setState(() {
      _priceRange = range;
    });
    _applyFilters();
  }

  void _onCapacityChanged(int? capacity) {
    setState(() {
      _selectedCapacity = capacity;
    });
    _applyFilters();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  void _onClearFilters() {
    setState(() {
      _selectedType = null;
      _priceRange = null;
      _selectedCapacity = null;
      _searchQuery = '';
    });
    _applyFilters();
  }

  void _onPropertyTap(DemoProperty property) {
    debugPrint('PUSH → PropertyDetailScreen with id: ${property.id}');
    context.pushNamed(
      'propertyDetails',
      pathParameters: {'id': property.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final l10n = Localizations.localeOf(context).languageCode;
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Filters bar (non-scrollable header)
          SliverToBoxAdapter(
            child: FiltersBar(
              selectedType: _selectedType,
              priceRange: _priceRange,
              selectedCapacity: _selectedCapacity,
              searchQuery: _searchQuery,
              onTypeChanged: _onTypeChanged,
              onPriceRangeChanged: _onPriceRangeChanged,
              onCapacityChanged: _onCapacityChanged,
              onSearchChanged: _onSearchChanged,
              onClearFilters: _onClearFilters,
            ),
          ),

          // View toggle and results count (non-scrollable)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
              child: Row(
                children: [
                  Text(
                    '${_filteredProperties.length} properties found',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Semantics(
                    label: !_isGridView
                        ? 'List view selected'
                        : 'Switch to list view',
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isGridView = false;
                        });
                      },
                      icon: Icon(
                        Icons.view_list,
                        color: !_isGridView ? theme.colorScheme.primary : null,
                      ),
                    ),
                  ),
                  Semantics(
                    label: _isGridView
                        ? 'Grid view selected'
                        : 'Switch to grid view',
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isGridView = true;
                        });
                      },
                      icon: Icon(
                        Icons.grid_view,
                        color: _isGridView ? theme.colorScheme.primary : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Debug results area (temporary)
          if (_debugResults)
            SliverToBoxAdapter(
              child: Container(
                height: 2,
                color: Colors.redAccent,
                margin: EdgeInsets.symmetric(horizontal: Spacing.lg),
              ),
            ),

          // Results content
          if (_isLoading)
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: SkeletonList(isGridView: _isGridView),
              ),
            )
          else if (_filteredProperties.isEmpty)
            SliverToBoxAdapter(
              child: _buildEmptyState(theme, l10n, isReducedMotion),
            )
          else if (_isGridView)
            SliverPadding(
              padding: EdgeInsets.all(Spacing.lg),
              sliver: SliverGrid(
                key: const ValueKey('home_grid_sliver'),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: kGridSpacing,
                  mainAxisSpacing: kGridSpacing,
                  mainAxisExtent: kGridCardHeight,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final property = _filteredProperties[index];
                    return PropertyCard(
                      property: property,
                      isGridView: true,
                      onTap: () => _onPropertyTap(property),
                      animationDelay: isReducedMotion ? 0 : index * 100,
                    );
                  },
                  childCount: _filteredProperties.length,
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.all(Spacing.lg),
              sliver: SliverList(
                key: const ValueKey('home_list_sliver'),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final property = _filteredProperties[index];
                    // Debug logging (temporary)
                    if (index < 3) {
                      debugPrint('List item built: $index');
                    }
                    return PropertyCard(
                      key: ValueKey(property.id),
                      property: property,
                      isGridView: false,
                      onTap: () => _onPropertyTap(property),
                      animationDelay: isReducedMotion ? 0 : index * 100,
                    );
                  },
                  childCount: _filteredProperties.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, String l10n, bool isReducedMotion) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Spacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(
                    Icons.search_off_rounded,
                    size: 60,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
                .animate()
                .fadeIn(duration: isReducedMotion ? 0.ms : 600.ms)
                .scale(
                  begin: isReducedMotion
                      ? const Offset(1.0, 1.0)
                      : const Offset(0.8, 0.8),
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.lg),

            // Empty state title
            Text(
                  'No properties found',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(
                  delay: isReducedMotion ? 0.ms : 200.ms,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                )
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.md),

            // Empty state message
            Text(
                  'Try adjusting your filters or search terms to find more properties.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(
                  delay: isReducedMotion ? 0.ms : 400.ms,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                )
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),

            SizedBox(height: Spacing.xl),

            // Clear filters button
            FilledButton.icon(
                  onPressed: _onClearFilters,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Filters'),
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.lg,
                      vertical: Spacing.md,
                    ),
                  ),
                )
                .animate()
                .fadeIn(
                  delay: isReducedMotion ? 0.ms : 600.ms,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                )
                .slideY(
                  begin: isReducedMotion ? 0.0 : 0.3,
                  duration: isReducedMotion ? 0.ms : 600.ms,
                ),
          ],
        ),
      ),
    );
  }
}
