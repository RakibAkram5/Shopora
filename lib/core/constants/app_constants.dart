import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Shopora';
  static const String appSubtitle = 'Your world. Your style. One place.';
  static const String currencySymbol = 'Rs. ';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String productsCollection = 'products';
  static const String categoriesCollection = 'categories';
  static const String ordersCollection = 'orders';
  static const String reviewsCollection = 'reviews';
  static const String wishlistsCollection = 'wishlists';
  static const String cartsCollection = 'carts';
  static const String addressesCollection = 'addresses';
  static const String notificationsCollection = 'notifications';
  static const String bannersCollection = 'banners';

  // Shared Preferences Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyRecentSearches = 'recent_searches';
}

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF6C4DF6); // Electric Violet
  static const Color primaryDark = Color(0xFF4B2DB3); // Deep Violet
  static const Color accent = Color(0xFFFF6B8A); // Coral Pink
  static const Color background = Color(0xFFF8F7FC); // Soft Lavender White
  static const Color surface = Color(0xFFFFFFFF); // White

  // Text Colors
  static const Color textPrimary = Color(0xFF171522); // Deep Charcoal
  static const Color textSecondary = Color(0xFF77738A); // Muted Purple Gray

  // Status & Utility Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color discount = Color(0xFFFF4D6D);
  static const Color warning = Color(0xFFF59E0B);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF121019);
  static const Color darkSurface = Color(0xFF1E1A2B);
  static const Color darkCard = Color(0xFF262238);
  static const Color darkTextPrimary = Color(0xFFF1F0F7);
  static const Color darkTextSecondary = Color(0xFF9E99B3);
}
