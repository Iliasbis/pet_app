class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Palm Kissed Paws';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl =
      'http://10.0.2.2:3000/api/v1'; // For Android emulator only

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';

  // Pagination
  static const int defaultPageSize = 10;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;

  // Pet Size Limits (in pounds)
  static const double smallPetMaxWeight = 25.0;
  static const double mediumPetMaxWeight = 60.0;

  // Service Types
  static const Map<String, String> serviceTypes = {
    'local': 'Local (Up to 15 miles)',
    'standard': 'Standard (16-30 miles)',
    'long': 'Long Distance (31-50 miles)',
    'extended': 'Extended (51+ miles)',
  };

  // Booking Status
  static const Map<String, String> bookingStatuses = {
    'pending': 'Pending',
    'confirmed': 'Confirmed',
    'in_progress': 'In Progress',
    'completed': 'Completed',
    'cancelled': 'Cancelled',
  };

  // Payment Methods
  static const Map<String, String> paymentMethods = {
    'stripe': 'Credit Card',
    'paypal': 'PayPal',
    'cash': 'Cash',
  };

  // Error Messages
  static const String networkErrorMessage =
      'Network error. Please check your connection.';
  static const String serverErrorMessage =
      'Server error. Please try again later.';
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registrationSuccessMessage = 'Registration successful!';
  static const String bookingSuccessMessage = 'Booking created successfully!';
  static const String petAddedSuccessMessage = 'Pet added successfully!';

  // Regex Patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phonePattern = r'^\+?1?[2-9]\d{2}[2-9]\d{2}\d{4}$';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // UI Constants
  static const double borderRadius = 12.0;
  static const double largeBorderRadius = 16.0;
  static const double cardElevation = 8.0;
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
}
