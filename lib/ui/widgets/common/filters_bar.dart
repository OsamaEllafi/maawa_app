import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../demo/demo_data.dart';

/// Filters bar widget for property browsing
class FiltersBar extends StatefulWidget {
  final String? selectedType;
  final RangeValues? priceRange;
  final int? selectedCapacity;
  final String searchQuery;
  final Function(String?) onTypeChanged;
  final Function(RangeValues?) onPriceRangeChanged;
  final Function(int?) onCapacityChanged;
  final Function(String) onSearchChanged;
  final VoidCallback? onClearFilters;

  const FiltersBar({
    super.key,
    this.selectedType,
    this.priceRange,
    this.selectedCapacity,
    this.searchQuery = '',
    required this.onTypeChanged,
    required this.onPriceRangeChanged,
    required this.onCapacityChanged,
    required this.onSearchChanged,
    this.onClearFilters,
  });

  @override
  State<FiltersBar> createState() => _FiltersBarState();
}

class _FiltersBarState extends State<FiltersBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
  }

  @override
  void didUpdateWidget(FiltersBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _searchController.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = Localizations.localeOf(context).languageCode;
    final isReducedMotion = MediaQuery.of(context).accessibleNavigation;

    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(Spacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search properties...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                widget.onSearchChanged('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BorderRadiusTokens.medium),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest,
                    ),
                    onChanged: widget.onSearchChanged,
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Semantics(
                  label: _showFilters ? 'Hide filters' : 'Show filters',
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _showFilters = !_showFilters;
                      });
                    },
                    icon: Icon(
                      _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
                      color: _showFilters ? theme.colorScheme.primary : null,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: _showFilters 
                          ? theme.colorScheme.primaryContainer 
                          : theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filters section
          if (_showFilters)
            Container(
              padding: EdgeInsets.fromLTRB(Spacing.lg, 0, Spacing.lg, Spacing.lg),
              child: Column(
                children: [
                  // Filter chips
                  _buildFilterChips(theme, l10n, isReducedMotion),
                  
                  SizedBox(height: Spacing.md),
                  
                  // Price range slider
                  _buildPriceRangeSlider(theme, isReducedMotion),
                  
                  SizedBox(height: Spacing.md),
                  
                  // Capacity selector
                  _buildCapacitySelector(theme, l10n, isReducedMotion),
                  
                  SizedBox(height: Spacing.md),
                  
                  // Clear filters button
                  if (_hasActiveFilters())
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: widget.onClearFilters,
                        icon: const Icon(Icons.clear_all),
                        label: const Text('Clear Filters'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                        ),
                      ),
                    ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: isReducedMotion ? 0.ms : 300.ms)
                .slideY(begin: isReducedMotion ? 0.0 : -0.3, duration: isReducedMotion ? 0.ms : 300.ms),
        ],
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme, String l10n, bool isReducedMotion) {
    final propertyTypes = DemoData.getAllPropertyTypes();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Type',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),
        Wrap(
          spacing: Spacing.sm,
          runSpacing: Spacing.xs,
          children: [
            // All types chip
            FilterChip(
              label: const Text('All'),
              selected: widget.selectedType == null,
              onSelected: (selected) {
                widget.onTypeChanged(null);
              },
            ),
            // Property type chips
            ...propertyTypes.map((type) => FilterChip(
              label: Text(type),
              selected: widget.selectedType == type,
              onSelected: (selected) {
                widget.onTypeChanged(selected ? type : null);
              },
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRangeSlider(ThemeData theme, bool isReducedMotion) {
    final priceRange = DemoData.getPriceRange();
    final currentRange = widget.priceRange ?? RangeValues(priceRange['min']!, priceRange['max']!);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price Range',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${currentRange.start.round()} - ${currentRange.end.round()} LYD',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.sm),
        Semantics(
          label: 'Price range from ${CurrencyFormatter.formatLYD(currentRange.start)} to ${CurrencyFormatter.formatLYD(currentRange.end)} per night',
          child: RangeSlider(
            values: currentRange,
            min: priceRange['min']!,
            max: priceRange['max']!,
            divisions: 20,
            labels: RangeLabels(
              currentRange.start.round().toString(),
              currentRange.end.round().toString(),
            ),
            onChanged: (values) {
              widget.onPriceRangeChanged(values);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCapacitySelector(ThemeData theme, String l10n, bool isReducedMotion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Capacity',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.sm),
        Wrap(
          spacing: Spacing.sm,
          runSpacing: Spacing.xs,
          children: [
            // Any capacity chip
            FilterChip(
              label: const Text('Any'),
              selected: widget.selectedCapacity == null,
              onSelected: (selected) {
                widget.onCapacityChanged(null);
              },
            ),
            // Capacity chips
            ...List.generate(6, (index) {
              final capacity = index + 1;
              return Semantics(
                label: '$capacity guests',
                selected: widget.selectedCapacity == capacity,
                child: FilterChip(
                  label: Text('$capacity+'),
                  selected: widget.selectedCapacity == capacity,
                  onSelected: (selected) {
                    widget.onCapacityChanged(selected ? capacity : null);
                  },
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  bool _hasActiveFilters() {
    return widget.selectedType != null ||
           widget.priceRange != null ||
           widget.selectedCapacity != null ||
           widget.searchQuery.isNotEmpty;
  }
}
