import 'package:intl/intl.dart';

/// Currency formatter utility for Libyan Dinar (LYD)
class CurrencyFormatter {
  static const String _currencyCode = 'LYD';
  static const String _currencySymbol = 'د.ل';

  /// Format amount as LYD with proper decimal places
  static String formatLYD(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'ar_LY',
      symbol: _currencySymbol,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format amount as LYD without symbol (for input fields)
  static String formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'ar_LY');
    return formatter.format(amount);
  }

  /// Parse string to double amount
  static double? parseAmount(String amount) {
    try {
      // Remove currency symbol and spaces
      final cleanAmount = amount.replaceAll(RegExp(r'[^\d.,]'), '');
      return double.parse(cleanAmount.replaceAll(',', ''));
    } catch (e) {
      return null;
    }
  }

  /// Get currency symbol
  static String get symbol => _currencySymbol;

  /// Get currency code
  static String get code => _currencyCode;

  /// Format price range (e.g., "د.ل 1,234.00 - 2,345.00")
  static String formatPriceRange(double minPrice, double maxPrice) {
    return formatLYD(minPrice) + ' - ' + formatLYD(maxPrice);
  }

  /// Format price with discount
  static String formatPriceWithDiscount(
    double originalPrice,
    double discountedPrice,
  ) {
    final discount = originalPrice - discountedPrice;
    final discountPercentage = (discount / originalPrice * 100).round();

    return formatLYD(discountedPrice) + ' ($discountPercentage% off)';
  }
}
