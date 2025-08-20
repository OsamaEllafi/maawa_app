import 'package:flutter/foundation.dart';
import '../core/data/amenities_data.dart';
import '../core/utils/currency_formatter.dart';

/// Demo booking status enum
enum DemoBookingStatus {
  requested,
  accepted,
  pendingPayment,
  confirmed,
  completed,
  cancelled,
  expired,
}

/// Demo booking model
class DemoBooking {
  final String id;
  final String propertyId;
  final String titleEn;
  final String titleAr;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final DemoBookingStatus status;
  final DateTime? pendingUntil; // when status == pendingPayment

  const DemoBooking({
    required this.id,
    required this.propertyId,
    required this.titleEn,
    required this.titleAr,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.status,
    this.pendingUntil,
  });

  DemoBooking copyWith({DemoBookingStatus? status, DateTime? pendingUntil}) =>
      DemoBooking(
        id: id,
        propertyId: propertyId,
        titleEn: titleEn,
        titleAr: titleAr,
        guests: guests,
        checkIn: checkIn,
        checkOut: checkOut,
        status: status ?? this.status,
        pendingUntil: pendingUntil,
      );
}

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

  /// Create a copy with updated fields
  DemoProperty copyWith({
    String? id,
    String? title,
    String? titleAr,
    String? description,
    String? descriptionAr,
    String? type,
    String? typeAr,
    double? pricePerNight,
    int? capacity,
    double? rating,
    int? reviewCount,
    String? location,
    String? locationAr,
    List<String>? imageUrls,
    String? videoUrl,
    List<String>? amenityIds,
    List<DemoReview>? reviews,
    bool? isAvailable,
    bool? isFeatured,
  }) {
    return DemoProperty(
      id: id ?? this.id,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      type: type ?? this.type,
      typeAr: typeAr ?? this.typeAr,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      capacity: capacity ?? this.capacity,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      location: location ?? this.location,
      locationAr: locationAr ?? this.locationAr,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      amenityIds: amenityIds ?? this.amenityIds,
      reviews: reviews ?? this.reviews,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
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

  /// Demo bookings list
  static List<DemoBooking> bookings = <DemoBooking>[
    // Deterministic booking_1 entry (important: matches what My Bookings was tapping)
    DemoBooking(
      id: 'booking_1',
      propertyId: properties.first.id,
      titleEn: 'Pending — ${properties.first.title}',
      titleAr: 'قيد الدفع — ${properties.first.titleAr}',
      checkIn: DateTime.now().add(const Duration(days: 2)),
      checkOut: DateTime.now().add(const Duration(days: 5)),
      guests: 2,
      status: DemoBookingStatus.pendingPayment,
      pendingUntil: DateTime.now().add(const Duration(minutes: 30)),
    ),
    // Pending payment (shows countdown)
    DemoBooking(
      id: 'bkg_pp_001',
      propertyId: properties.first.id,
      titleEn: 'Pending Payment — Modern Downtown Apartment',
      titleAr: 'في انتظار الدفع — شقة حديثة وسط المدينة',
      checkIn: DateTime.now().add(const Duration(days: 2)),
      checkOut: DateTime.now().add(const Duration(days: 5)),
      guests: 2,
      status: DemoBookingStatus.pendingPayment,
      pendingUntil: DateTime.now().add(const Duration(minutes: 30)),
    ),
    // A couple of others for variety
    DemoBooking(
      id: 'bkg_req_002',
      propertyId: properties[1].id,
      titleEn: 'Requested — Cozy Beach House',
      titleAr: 'تم الطلب — بيت الشاطئ الدافئ',
      checkIn: DateTime.now().add(const Duration(days: 10)),
      checkOut: DateTime.now().add(const Duration(days: 13)),
      guests: 4,
      status: DemoBookingStatus.requested,
    ),
    DemoBooking(
      id: 'bkg_cfm_003',
      propertyId: properties[2].id,
      titleEn: 'Confirmed — Luxury Villa',
      titleAr: 'مؤكد — فيلا فاخرة',
      checkIn: DateTime.now().add(const Duration(days: 20)),
      checkOut: DateTime.now().add(const Duration(days: 23)),
      guests: 6,
      status: DemoBookingStatus.confirmed,
    ),
  ];

  /// Get booking by ID with robust lookup that tolerates different ID shapes
  static DemoBooking? bookingById(String id) {
    try {
      return bookings.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  // Wallet demo data
  static const double _walletBalance = 2450.00;

  static double get walletBalance => _walletBalance;

  static List<DemoTransaction> transactions = <DemoTransaction>[
    DemoTransaction(
      id: 'txn_001',
      type: DemoTransactionType.topup,
      title: 'Wallet Top-up',
      subtitle: 'Credit Card',
      amount: 500.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: DemoTransactionStatus.completed,
    ),
    DemoTransaction(
      id: 'txn_002',
      type: DemoTransactionType.booking,
      title: 'Booking Payment',
      subtitle: 'Downtown Apartment',
      amount: -450.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: DemoTransactionStatus.completed,
    ),
    DemoTransaction(
      id: 'txn_003',
      type: DemoTransactionType.withdrawal,
      title: 'Withdrawal',
      subtitle: 'Bank Transfer',
      amount: -200.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: DemoTransactionStatus.completed,
    ),
    DemoTransaction(
      id: 'txn_004',
      type: DemoTransactionType.topup,
      title: 'Wallet Top-up',
      subtitle: 'Bank Transfer',
      amount: 1000.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: DemoTransactionStatus.completed,
    ),
    DemoTransaction(
      id: 'txn_005',
      type: DemoTransactionType.booking,
      title: 'Booking Payment',
      subtitle: 'Beach House',
      amount: -300.00,
      date: DateTime.now().subtract(const Duration(days: 7)),
      status: DemoTransactionStatus.completed,
    ),
    DemoTransaction(
      id: 'txn_006',
      type: DemoTransactionType.adjustment,
      title: 'Bonus Credit',
      subtitle: 'Referral Reward',
      amount: 50.00,
      date: DateTime.now().subtract(const Duration(days: 10)),
      status: DemoTransactionStatus.completed,
    ),
  ];

  /// Get filtered transactions by type
  static List<DemoTransaction> filteredTransactions(DemoTransactionType? type) {
    if (type == null) return transactions;
    return transactions.where((tx) => tx.type == type).toList();
  }

  /// Add a new transaction to the beginning of the list
  static void addTransaction(DemoTransaction tx) {
    transactions.insert(0, tx);
  }

  /// Update booking status (UI-only helper)
  static bool updateBookingStatus(String id, DemoBookingStatus status) {
    final i = bookings.indexWhere((b) => b.id == id);
    if (i == -1) return false;
    final b = bookings[i];
    bookings[i] = b.copyWith(status: status, pendingUntil: null);
    return true;
  }

  /// Get all reviews for a property
  static List<DemoReview> getReviewsForProperty(String propertyId) {
    final property = getPropertyById(propertyId);
    return property?.reviews ?? [];
  }

  /// Add a review to a property (UI-only helper)
  static void addReviewToProperty(String propertyId, DemoReview review) {
    final propertyIndex = properties.indexWhere((p) => p.id == propertyId);
    if (propertyIndex == -1) return;

    final property = properties[propertyIndex];
    final updatedReviews = [...property.reviews, review];

    // Calculate new average rating
    final totalRating = updatedReviews.fold<double>(
      0,
      (sum, r) => sum + r.rating,
    );
    final newRating = totalRating / updatedReviews.length;

    // Note: In a real app, this would update the property in the database
    // For demo purposes, we'd need to create a mutable property structure
    // or maintain reviews separately
    debugPrint('New rating would be: $newRating');
  }

  /// Calculate average rating for multiple reviews
  static double calculateAverageRating(List<DemoReview> reviews) {
    if (reviews.isEmpty) return 0.0;
    final totalRating = reviews.fold<double>(
      0,
      (sum, review) => sum + review.rating,
    );
    return totalRating / reviews.length;
  }

  /// Add a new review to a property
  static DemoReview addReview({
    required String propertyId,
    required double rating,
    required String commentEn,
    required String commentAr,
    String authorNameEn = 'Guest',
    String authorNameAr = 'ضيف',
  }) {
    final pIndex = properties.indexWhere((p) => p.id == propertyId);
    if (pIndex == -1) throw StateError('Property not found: $propertyId');

    final review = DemoReview(
      id: 'rvw_${DateTime.now().millisecondsSinceEpoch}',
      userName: authorNameEn,
      userNameAr: authorNameAr,
      rating: rating,
      comment: commentEn.trim(),
      commentAr: commentAr.trim(),
      date: DateTime.now(),
    );
    final updated = [...properties[pIndex].reviews, review];

    properties[pIndex] = properties[pIndex].copyWith(reviews: updated);
    return review;
  }

  /// Get reviews aggregate data for a property
  static ({double avg, int count}) reviewsAggregate(String propertyId) {
    final p = properties.firstWhere(
      (p) => p.id == propertyId,
      orElse: () => throw StateError('Property not found: $propertyId'),
    );
    if (p.reviews.isEmpty) return (avg: 0.0, count: 0);
    final sum = p.reviews.fold<double>(0, (a, r) => a + r.rating);
    final avg = double.parse((sum / p.reviews.length).toStringAsFixed(1));
    return (avg: avg, count: p.reviews.length);
  }

  // Admin demo data
  static final List<DemoUser> users = [
    DemoUser(
      id: 'user_001',
      name: 'Ahmed Hassan',
      email: 'ahmed@example.com',
      role: DemoUserRole.tenant,
      status: DemoUserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLoginAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    DemoUser(
      id: 'user_002',
      name: 'Sarah Johnson',
      email: 'sarah@example.com',
      role: DemoUserRole.owner,
      status: DemoUserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      lastLoginAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DemoUser(
      id: 'user_003',
      name: 'Omar Khalil',
      email: 'omar@example.com',
      role: DemoUserRole.admin,
      status: DemoUserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      lastLoginAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    DemoUser(
      id: 'user_004',
      name: 'Fatima Ali',
      email: 'fatima@example.com',
      role: DemoUserRole.tenant,
      status: DemoUserStatus.locked,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      lastLoginAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    DemoUser(
      id: 'user_005',
      name: 'Youssef Mahmoud',
      email: 'youssef@example.com',
      role: DemoUserRole.owner,
      status: DemoUserStatus.suspended,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      lastLoginAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  static final List<DemoPropertyApproval> propertyApprovals = [
    DemoPropertyApproval(
      id: 'approval_001',
      propertyId: 'prop_006',
      propertyTitle: 'New Beach Villa',
      ownerName: 'Sarah Johnson',
      ownerEmail: 'sarah@example.com',
      status: DemoPropertyApprovalStatus.pending,
      submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    DemoPropertyApproval(
      id: 'approval_002',
      propertyId: 'prop_007',
      propertyTitle: 'Downtown Studio',
      ownerName: 'Youssef Mahmoud',
      ownerEmail: 'youssef@example.com',
      status: DemoPropertyApprovalStatus.pending,
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DemoPropertyApproval(
      id: 'approval_003',
      propertyId: 'prop_008',
      propertyTitle: 'Mountain Cabin',
      ownerName: 'Ahmed Hassan',
      ownerEmail: 'ahmed@example.com',
      status: DemoPropertyApprovalStatus.rejected,
      submittedAt: DateTime.now().subtract(const Duration(days: 3)),
      reviewedAt: DateTime.now().subtract(const Duration(days: 2)),
      rejectionReason: 'Property images are unclear and incomplete',
    ),
  ];

  static final List<DemoMockEmail> mockEmails = [
    DemoMockEmail(
      id: 'email_001',
      subject: 'Welcome to Maawa - Your Account is Ready!',
      to: 'ahmed@example.com',
      from: 'noreply@maawa.com',
      htmlContent: '''
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #1976d2;">Welcome to Maawa!</h2>
          <p>Dear Ahmed Hassan,</p>
          <p>Welcome to Maawa! Your account has been successfully created and is ready to use.</p>
          <p>You can now:</p>
          <ul>
            <li>Browse available properties</li>
            <li>Make booking requests</li>
            <li>Manage your profile</li>
          </ul>
          <p>If you have any questions, please don't hesitate to contact our support team.</p>
          <p>Best regards,<br>The Maawa Team</p>
        </div>
      ''',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    DemoMockEmail(
      id: 'email_002',
      subject: 'Booking Confirmation - Downtown Apartment',
      to: 'sarah@example.com',
      from: 'bookings@maawa.com',
      htmlContent: '''
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #2e7d32;">Booking Confirmed!</h2>
          <p>Dear Sarah Johnson,</p>
          <p>Your booking for <strong>Downtown Apartment</strong> has been confirmed!</p>
          <p><strong>Check-in:</strong> March 15, 2024<br>
          <strong>Check-out:</strong> March 18, 2024<br>
          <strong>Total:</strong> د.ل 750.00</p>
          <p>We look forward to hosting you!</p>
          <p>Best regards,<br>The Maawa Team</p>
        </div>
      ''',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DemoMockEmail(
      id: 'email_003',
      subject: 'Property Approval Required',
      to: 'admin@maawa.com',
      from: 'system@maawa.com',
      htmlContent: '''
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #f57c00;">Property Approval Required</h2>
          <p>A new property has been submitted for approval:</p>
          <p><strong>Property:</strong> New Beach Villa<br>
          <strong>Owner:</strong> Sarah Johnson<br>
          <strong>Submitted:</strong> 2 hours ago</p>
          <p>Please review and approve or reject this property listing.</p>
          <p>Best regards,<br>Maawa System</p>
        </div>
      ''',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  // Admin helper methods
  static int get pendingPropertyApprovalsCount => 
    propertyApprovals.where((p) => p.status == DemoPropertyApprovalStatus.pending).length;

  static int get activeUsersCount => 
    users.where((u) => u.status == DemoUserStatus.active).length;

  static int get totalBookingsCount => bookings.length;

  static double get totalRevenue => 
    transactions.where((t) => t.type == DemoTransactionType.booking).fold(0.0, (sum, t) => sum + t.amount.abs());
}

// Wallet transaction models
enum DemoTransactionType { topup, withdrawal, booking, adjustment }

enum DemoTransactionStatus { pending, completed, failed, cancelled }

class DemoTransaction {
  final String id;
  final DemoTransactionType type;
  final String title;
  final String subtitle;
  final double amount; // positive for credits, negative for debits
  final DateTime date;
  final DemoTransactionStatus status;

  const DemoTransaction({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.status,
  });

  bool get isCredit => amount >= 0;
  bool get isDebit => amount < 0;
}

// Admin-related models
enum DemoUserRole { tenant, owner, admin }

enum DemoUserStatus { active, locked, suspended }

class DemoUser {
  final String id;
  final String name;
  final String email;
  final DemoUserRole role;
  final DemoUserStatus status;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final String? avatarUrl;

  const DemoUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.createdAt,
    this.lastLoginAt,
    this.avatarUrl,
  });

  String get roleDisplayName {
    switch (role) {
      case DemoUserRole.tenant:
        return 'Tenant';
      case DemoUserRole.owner:
        return 'Property Owner';
      case DemoUserRole.admin:
        return 'Administrator';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case DemoUserStatus.active:
        return 'Active';
      case DemoUserStatus.locked:
        return 'Locked';
      case DemoUserStatus.suspended:
        return 'Suspended';
    }
  }
}

enum DemoPropertyApprovalStatus { pending, approved, rejected }

class DemoPropertyApproval {
  final String id;
  final String propertyId;
  final String propertyTitle;
  final String ownerName;
  final String ownerEmail;
  final DemoPropertyApprovalStatus status;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  const DemoPropertyApproval({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.ownerName,
    required this.ownerEmail,
    required this.status,
    required this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
  });
}

class DemoMockEmail {
  final String id;
  final String subject;
  final String to;
  final String from;
  final String htmlContent;
  final DateTime createdAt;
  final bool isRead;

  const DemoMockEmail({
    required this.id,
    required this.subject,
    required this.to,
    required this.from,
    required this.htmlContent,
    required this.createdAt,
    this.isRead = false,
  });
}
