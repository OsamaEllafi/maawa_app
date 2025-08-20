import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/data/amenities_data.dart';
import '../../../widgets/common/app_top_bar.dart';

/// Property editor screen for creating and editing properties
class PropertyEditorScreen extends StatefulWidget {
  const PropertyEditorScreen({super.key, this.propertyId});

  final String? propertyId;

  @override
  State<PropertyEditorScreen> createState() => _PropertyEditorScreenState();
}

class _PropertyEditorScreenState extends State<PropertyEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  final _capacityController = TextEditingController();
  final _checkInController = TextEditingController();
  final _checkOutController = TextEditingController();

  String _selectedType = 'apartment';
  List<String> _selectedAmenities = [];
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.propertyId != null;
    if (_isEditing) {
      _loadPropertyData();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _capacityController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  void _loadPropertyData() {
    // Simulate loading property data
    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Pre-fill form with demo data
          _titleController.text = 'Beautiful Apartment in City Center';
          _descriptionController.text =
              'A modern and spacious apartment with stunning city views. Perfect for families and business travelers.';
          _addressController.text = '123 Main Street, Downtown';
          _priceController.text = '150';
          _capacityController.text = '4';
          _checkInController.text = '15:00';
          _checkOutController.text = '11:00';
          _selectedType = 'apartment';
          _selectedAmenities = ['wifi', 'parking', 'kitchen'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppTopBar(
        title: _isEditing ? l10n.editProperty : l10n.addProperty,
        actions: [
          if (!_isLoading)
            TextButton(onPressed: _saveProperty, child: Text(l10n.save)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FocusTraversalGroup(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        [
                              // Basic Information Section
                              _buildSectionHeader(
                                l10n.basicInformation,
                                Icons.info_outline,
                              ),
                              SizedBox(height: Spacing.md),

                              // Title
                              TextFormField(
                                controller: _titleController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: l10n.propertyTitle,
                                  hintText: l10n.propertyTitleHint,
                                  prefixIcon: const Icon(Icons.title),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.propertyTitleRequired;
                                  }
                                  if (value.trim().length < 10) {
                                    return l10n.propertyTitleTooShort;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: Spacing.md),

                              // Description
                              TextFormField(
                                controller: _descriptionController,
                                maxLines: 4,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: l10n.propertyDescription,
                                  hintText: l10n.propertyDescriptionHint,
                                  prefixIcon: const Icon(Icons.description),
                                  alignLabelWithHint: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.propertyDescriptionRequired;
                                  }
                                  if (value.trim().length < 50) {
                                    return l10n.propertyDescriptionTooShort;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: Spacing.lg),

                              // Property Details Section
                              _buildSectionHeader(
                                l10n.propertyDetails,
                                Icons.home,
                              ),
                              SizedBox(height: Spacing.md),

                              // Property Type
                              DropdownButtonFormField<String>(
                                value: _selectedType,
                                decoration: InputDecoration(
                                  labelText: l10n.propertyType,
                                  prefixIcon: const Icon(Icons.category),
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: 'apartment',
                                    child: Text(l10n.apartment),
                                  ),
                                  DropdownMenuItem(
                                    value: 'house',
                                    child: Text(l10n.house),
                                  ),
                                  DropdownMenuItem(
                                    value: 'villa',
                                    child: Text(l10n.villa),
                                  ),
                                  DropdownMenuItem(
                                    value: 'studio',
                                    child: Text(l10n.studio),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() => _selectedType = value!);
                                },
                              ),
                              SizedBox(height: Spacing.md),

                              // Address
                              TextFormField(
                                controller: _addressController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: l10n.address,
                                  hintText: l10n.addressHint,
                                  prefixIcon: const Icon(Icons.location_on),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.addressRequired;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: Spacing.md),

                              // Price and Capacity Row
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _priceController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: l10n.pricePerNight,
                                        hintText: l10n.priceHint,
                                        prefixIcon: const Icon(
                                          Icons.attach_money,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return l10n.priceRequired;
                                        }
                                        final price = double.tryParse(value);
                                        if (price == null || price <= 0) {
                                          return l10n.priceInvalid;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: Spacing.md),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _capacityController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: l10n.capacity,
                                        hintText: l10n.capacityHint,
                                        prefixIcon: const Icon(Icons.people),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return l10n.capacityRequired;
                                        }
                                        final capacity = int.tryParse(value);
                                        if (capacity == null || capacity <= 0) {
                                          return l10n.capacityInvalid;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Spacing.md),

                              // Check-in/Check-out Times
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _checkInController,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: l10n.checkInTime,
                                        hintText: '15:00',
                                        prefixIcon: const Icon(Icons.login),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return l10n.checkInTimeRequired;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: Spacing.md),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _checkOutController,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        labelText: l10n.checkOutTime,
                                        hintText: '11:00',
                                        prefixIcon: const Icon(Icons.logout),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return l10n.checkOutTimeRequired;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Spacing.lg),

                              // Amenities Section
                              _buildSectionHeader(
                                l10n.amenities,
                                Icons.local_offer,
                              ),
                              SizedBox(height: Spacing.md),
                              _buildAmenitiesSelector(),
                              SizedBox(height: Spacing.lg),

                              // Save Button
                              SizedBox(
                                width: double.infinity,
                                child: Semantics(
                                  label: _isEditing
                                      ? l10n.updateProperty
                                      : l10n.createProperty,
                                  button: true,
                                  child: ElevatedButton.icon(
                                    onPressed: _saveProperty,
                                    icon: const Icon(Icons.save),
                                    label: Text(
                                      _isEditing
                                          ? l10n.updateProperty
                                          : l10n.createProperty,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Spacing.md,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                            .animate(interval: 100.ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.3),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        SizedBox(width: Spacing.sm),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenitiesSelector() {
    final theme = Theme.of(context);
    final amenities = AmenitiesData.allAmenities;

    return Wrap(
      spacing: Spacing.sm,
      runSpacing: Spacing.sm,
      children: amenities.map((amenity) {
        final isSelected = _selectedAmenities.contains(amenity.id);
        return FilterChip(
          label: Text(amenity.name),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedAmenities.add(amenity.id);
              } else {
                _selectedAmenities.remove(amenity.id);
              }
            });
          },
          avatar: Icon(
            amenity.icon,
            size: 16,
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
          ),
          selectedColor: theme.colorScheme.primary,
          checkmarkColor: theme.colorScheme.onPrimary,
        );
      }).toList(),
    );
  }

  void _saveProperty() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    // Show loading
    setState(() => _isLoading = true);

    // Simulate save operation
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() => _isLoading = false);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? l10n.propertyUpdatedSuccessfully
                  : l10n.propertyCreatedSuccessfully,
            ),
            backgroundColor: AppColors.success500,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Navigate back
        context.pop();
      }
    });
  }
}
