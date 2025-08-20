import 'package:flutter/material.dart';

/// Amenity data model for property listings
class Amenity {
  final String id;
  final String name;
  final String nameAr;
  final IconData icon;
  final String description;
  final String descriptionAr;

  const Amenity({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.icon,
    required this.description,
    required this.descriptionAr,
  });

  /// Get localized name based on current locale
  String getLocalizedName(String locale) {
    return locale == 'ar' ? nameAr : name;
  }

  /// Get localized description based on current locale
  String getLocalizedDescription(String locale) {
    return locale == 'ar' ? descriptionAr : description;
  }
}

/// Predefined amenities for the application
class AmenitiesData {
  static const List<Amenity> allAmenities = [
    Amenity(
      id: 'wifi',
      name: 'Wi-Fi',
      nameAr: 'واي فاي',
      icon: Icons.wifi,
      description: 'High-speed wireless internet',
      descriptionAr: 'إنترنت لاسلكي عالي السرعة',
    ),
    Amenity(
      id: 'air_conditioning',
      name: 'Air Conditioning',
      nameAr: 'مكيف هواء',
      icon: Icons.ac_unit,
      description: 'Central air conditioning system',
      descriptionAr: 'نظام تكييف مركزي',
    ),
    Amenity(
      id: 'heating',
      name: 'Heating',
      nameAr: 'تدفئة',
      icon: Icons.thermostat,
      description: 'Central heating system',
      descriptionAr: 'نظام تدفئة مركزي',
    ),
    Amenity(
      id: 'kitchen',
      name: 'Kitchen',
      nameAr: 'مطبخ',
      icon: Icons.kitchen,
      description: 'Fully equipped kitchen',
      descriptionAr: 'مطبخ مجهز بالكامل',
    ),
    Amenity(
      id: 'washer',
      name: 'Washer',
      nameAr: 'غسالة',
      icon: Icons.local_laundry_service,
      description: 'Washing machine available',
      descriptionAr: 'غسالة متوفرة',
    ),
    Amenity(
      id: 'parking',
      name: 'Parking',
      nameAr: 'موقف سيارات',
      icon: Icons.local_parking,
      description: 'Free parking available',
      descriptionAr: 'موقف سيارات مجاني',
    ),
    Amenity(
      id: 'tv',
      name: 'TV',
      nameAr: 'تلفاز',
      icon: Icons.tv,
      description: 'Smart TV with streaming',
      descriptionAr: 'تلفاز ذكي مع بث',
    ),
    Amenity(
      id: 'elevator',
      name: 'Elevator',
      nameAr: 'مصعد',
      icon: Icons.elevator,
      description: 'Building elevator access',
      descriptionAr: 'وصول مصعد المبنى',
    ),
    Amenity(
      id: 'workspace',
      name: 'Workspace',
      nameAr: 'مساحة عمل',
      icon: Icons.work,
      description: 'Dedicated workspace area',
      descriptionAr: 'مساحة عمل مخصصة',
    ),
    Amenity(
      id: 'pool',
      name: 'Pool',
      nameAr: 'مسبح',
      icon: Icons.pool,
      description: 'Swimming pool access',
      descriptionAr: 'وصول مسبح',
    ),
    Amenity(
      id: 'balcony',
      name: 'Balcony',
      nameAr: 'شرفة',
      icon: Icons.balcony,
      description: 'Private balcony or terrace',
      descriptionAr: 'شرفة أو تراس خاص',
    ),
    Amenity(
      id: 'pet_friendly',
      name: 'Pet Friendly',
      nameAr: 'صديق للحيوانات',
      icon: Icons.pets,
      description: 'Pets allowed',
      descriptionAr: 'الحيوانات الأليفة مسموحة',
    ),
  ];

  /// Get amenity by ID
  static Amenity? getById(String id) {
    try {
      return allAmenities.firstWhere((amenity) => amenity.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get amenities by IDs
  static List<Amenity> getByIds(List<String> ids) {
    return allAmenities.where((amenity) => ids.contains(amenity.id)).toList();
  }

  /// Get all amenity IDs
  static List<String> getAllIds() {
    return allAmenities.map((amenity) => amenity.id).toList();
  }
}
