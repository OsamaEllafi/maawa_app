
import '../core/data/amenities_data.dart';
import '../core/utils/currency_formatter.dart';

/// Demo property model
class DemoProperty {
  final String id;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;
  final String type;
  final String typeAr;
  final double pricePerNight;
  final int capacity;
  final double rating;
  final int reviewCount;
  final String location;
  final String locationAr;
  final List<String> imageUrls;
  final String? videoUrl;
  final List<String> amenityIds;
  final List<DemoReview> reviews;
  final bool isAvailable;
  final bool isFeatured;

  const DemoProperty({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.descriptionAr,
    required this.type,
    required this.typeAr,
    required this.pricePerNight,
    required this.capacity,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.locationAr,
    required this.imageUrls,
    this.videoUrl,
    required this.amenityIds,
    required this.reviews,
    this.isAvailable = true,
    this.isFeatured = false,
  });

  /// Get localized title
  String getLocalizedTitle(String locale) {
    return locale == 'ar' ? titleAr : title;
  }

  /// Get localized description
  String getLocalizedDescription(String locale) {
    return locale == 'ar' ? descriptionAr : description;
  }

  /// Get localized type
  String getLocalizedType(String locale) {
    return locale == 'ar' ? typeAr : type;
  }

  /// Get localized location
  String getLocalizedLocation(String locale) {
    return locale == 'ar' ? locationAr : location;
  }

  /// Get formatted price
  String get formattedPrice => CurrencyFormatter.formatLYD(pricePerNight);

  /// Get amenities
  List<Amenity> get amenities => AmenitiesData.getByIds(amenityIds);
}

/// Demo review model
class DemoReview {
  final String id;
  final String userName;
  final String userNameAr;
  final double rating;
  final String comment;
  final String commentAr;
  final DateTime date;
  final String? userAvatar;

  const DemoReview({
    required this.id,
    required this.userName,
    required this.userNameAr,
    required this.rating,
    required this.comment,
    required this.commentAr,
    required this.date,
    this.userAvatar,
  });

  /// Get localized user name
  String getLocalizedName(String locale) {
    return locale == 'ar' ? userNameAr : userName;
  }

  /// Get localized comment
  String getLocalizedComment(String locale) {
    return locale == 'ar' ? commentAr : comment;
  }

  /// Get formatted date
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

/// Demo data provider
class DemoData {
  static final List<DemoProperty> properties = [
    DemoProperty(
      id: 'prop_001',
      title: 'Modern Downtown Apartment',
      titleAr: 'شقة حديثة في وسط المدينة',
      description:
          'Spacious 2-bedroom apartment in the heart of downtown with stunning city views. Perfect for business travelers or families.',
      descriptionAr:
          'شقة واسعة من غرفتي نوم في قلب وسط المدينة مع إطلالات خلابة على المدينة. مثالية للمسافرين في رحلات العمل أو العائلات.',
      type: 'Apartment',
      typeAr: 'شقة',
      pricePerNight: 250.0,
      capacity: 4,
      rating: 4.8,
      reviewCount: 127,
      location: 'Downtown, Tripoli',
      locationAr: 'وسط المدينة، طرابلس',
      imageUrls: [
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
      ],
      videoUrl: 'assets/videos/placeholder.mp4',
      amenityIds: [
        'wifi',
        'air_conditioning',
        'kitchen',
        'parking',
        'tv',
        'elevator',
      ],
      reviews: [
        DemoReview(
          id: 'rev_001',
          userName: 'Ahmed Hassan',
          userNameAr: 'أحمد حسن',
          rating: 5.0,
          comment:
              'Excellent location and very clean apartment. Highly recommended!',
          commentAr: 'موقع ممتاز وشقة نظيفة جداً. أنصح بها بشدة!',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        DemoReview(
          id: 'rev_002',
          userName: 'Sarah Johnson',
          userNameAr: 'سارة جونسون',
          rating: 4.5,
          comment: 'Great stay, the apartment was exactly as described.',
          commentAr: 'إقامة رائعة، الشقة كانت تماماً كما وُصفت.',
          date: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ],
      isFeatured: true,
    ),
    DemoProperty(
      id: 'prop_002',
      title: 'Cozy Beach House',
      titleAr: 'بيت شاطئ دافئ',
      description:
          'Beautiful beachfront house with private access to the Mediterranean Sea. Perfect for a relaxing vacation.',
      descriptionAr:
          'بيت جميل على الشاطئ مع وصول خاص للبحر الأبيض المتوسط. مثالي لقضاء عطلة مريحة.',
      type: 'House',
      typeAr: 'بيت',
      pricePerNight: 400.0,
      capacity: 6,
      rating: 4.9,
      reviewCount: 89,
      location: 'Beach Road, Benghazi',
      locationAr: 'طريق الشاطئ، بنغازي',
      imageUrls: [
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
      ],
      amenityIds: [
        'wifi',
        'air_conditioning',
        'kitchen',
        'washer',
        'parking',
        'pool',
        'balcony',
      ],
      reviews: [
        DemoReview(
          id: 'rev_003',
          userName: 'Fatima Ali',
          userNameAr: 'فاطمة علي',
          rating: 5.0,
          comment: 'Absolutely stunning! The beach access is incredible.',
          commentAr: 'مذهلة تماماً! الوصول للشاطئ رائع.',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
    ),
    DemoProperty(
      id: 'prop_003',
      title: 'Luxury Villa with Pool',
      titleAr: 'فيلا فاخرة مع مسبح',
      description:
          'Exclusive villa with private pool, garden, and stunning mountain views. Perfect for large groups.',
      descriptionAr:
          'فيلا حصرية مع مسبح خاص وحديقة وإطلالات خلابة على الجبال. مثالية للمجموعات الكبيرة.',
      type: 'Villa',
      typeAr: 'فيلا',
      pricePerNight: 600.0,
      capacity: 8,
      rating: 4.7,
      reviewCount: 156,
      location: 'Mountain View, Misrata',
      locationAr: 'إطلالة الجبل، مصراتة',
      imageUrls: [
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
      ],
      amenityIds: [
        'wifi',
        'air_conditioning',
        'heating',
        'kitchen',
        'washer',
        'parking',
        'tv',
        'pool',
        'balcony',
        'workspace',
      ],
      reviews: [
        DemoReview(
          id: 'rev_004',
          userName: 'Omar Khalil',
          userNameAr: 'عمر خليل',
          rating: 4.5,
          comment:
              'Beautiful villa with amazing amenities. The pool was perfect!',
          commentAr: 'فيلا جميلة مع مرافق مذهلة. المسبح كان مثالياً!',
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ],
    ),
    DemoProperty(
      id: 'prop_004',
      title: 'Studio in City Center',
      titleAr: 'استوديو في وسط المدينة',
      description:
          'Compact and modern studio apartment perfect for solo travelers or couples.',
      descriptionAr: 'استوديو مدمج وحديث مثالي للمسافرين الفرديين أو الأزواج.',
      type: 'Studio',
      typeAr: 'استوديو',
      pricePerNight: 120.0,
      capacity: 2,
      rating: 4.3,
      reviewCount: 67,
      location: 'City Center, Zawiya',
      locationAr: 'وسط المدينة، الزاوية',
      imageUrls: [
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
      ],
      amenityIds: ['wifi', 'air_conditioning', 'kitchen', 'tv', 'elevator'],
      reviews: [
        DemoReview(
          id: 'rev_005',
          userName: 'Layla Ahmed',
          userNameAr: 'ليلى أحمد',
          rating: 4.0,
          comment: 'Good value for money, clean and well-located.',
          commentAr: 'قيمة جيدة مقابل المال، نظيف وموقع جيد.',
          date: DateTime.now().subtract(const Duration(days: 7)),
        ),
      ],
    ),
    DemoProperty(
      id: 'prop_005',
      title: 'Pet-Friendly Cottage',
      titleAr: 'كوخ صديق للحيوانات',
      description:
          'Charming cottage surrounded by nature, perfect for pet owners and nature lovers.',
      descriptionAr:
          'كوخ ساحر محاط بالطبيعة، مثالي لأصحاب الحيوانات الأليفة وعشاق الطبيعة.',
      type: 'Cottage',
      typeAr: 'كوخ',
      pricePerNight: 180.0,
      capacity: 3,
      rating: 4.6,
      reviewCount: 42,
      location: 'Countryside, Tobruk',
      locationAr: 'الريف، طبرق',
      imageUrls: [
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
        'assets/images/placeholder.png',
      ],
      amenityIds: [
        'wifi',
        'heating',
        'kitchen',
        'parking',
        'pet_friendly',
        'balcony',
      ],
      reviews: [
        DemoReview(
          id: 'rev_006',
          userName: 'Youssef Mahmoud',
          userNameAr: 'يوسف محمود',
          rating: 4.5,
          comment:
              'Perfect for our dog! Beautiful surroundings and very peaceful.',
          commentAr: 'مثالي لكلبنا! محيط جميل وهادئ جداً.',
          date: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ],
    ),
  ];

  /// Get property by ID
  static DemoProperty? getPropertyById(String id) {
    try {
      return properties.firstWhere((property) => property.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get featured properties
  static List<DemoProperty> getFeaturedProperties() {
    return properties.where((property) => property.isFeatured).toList();
  }

  /// Get properties by type
  static List<DemoProperty> getPropertiesByType(String type) {
    return properties
        .where((property) => property.type.toLowerCase() == type.toLowerCase())
        .toList();
  }

  /// Get properties by price range
  static List<DemoProperty> getPropertiesByPriceRange(
    double minPrice,
    double maxPrice,
  ) {
    return properties
        .where(
          (property) =>
              property.pricePerNight >= minPrice &&
              property.pricePerNight <= maxPrice,
        )
        .toList();
  }

  /// Get properties by capacity
  static List<DemoProperty> getPropertiesByCapacity(int capacity) {
    return properties
        .where((property) => property.capacity >= capacity)
        .toList();
  }

  /// Search properties by title or location
  static List<DemoProperty> searchProperties(String query) {
    final lowercaseQuery = query.toLowerCase();
    return properties
        .where(
          (property) =>
              property.title.toLowerCase().contains(lowercaseQuery) ||
              property.titleAr.contains(query) ||
              property.location.toLowerCase().contains(lowercaseQuery) ||
              property.locationAr.contains(query),
        )
        .toList();
  }

  /// Get all property types
  static List<String> getAllPropertyTypes() {
    return properties.map((property) => property.type).toSet().toList();
  }

  /// Get price range
  static Map<String, double> getPriceRange() {
    final prices = properties
        .map((property) => property.pricePerNight)
        .toList();
    return {
      'min': prices.reduce((a, b) => a < b ? a : b),
      'max': prices.reduce((a, b) => a > b ? a : b),
    };
  }
}
