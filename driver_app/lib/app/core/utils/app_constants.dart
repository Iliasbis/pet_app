class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Palm Kissed Paws';
  static const String driverAppName = 'Palm Kissed Paws Driver';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String driverDataKey = 'driver_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String driverLocationKey = 'driver_location';

  // Pagination
  static const int defaultPageSize = 10;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;

  // Driver Status
  static const Map<String, String> driverStatuses = {
    'offline': 'Offline',
    'available': 'Available',
    'busy': 'Busy',
    'on_ride': 'On Ride',
  };

  // Ride Status
  static const Map<String, String> rideStatuses = {
    'assigned': 'Assigned',
    'en_route_pickup': 'En Route to Pickup',
    'arrived_pickup': 'Arrived at Pickup',
    'pet_picked_up': 'Pet Picked Up',
    'en_route_dropoff': 'En Route to Drop-off',
    'arrived_dropoff': 'Arrived at Drop-off',
    'completed': 'Completed',
  };

  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String genericErrorMessage = 'Something went wrong. Please try again.';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String rideAcceptedMessage = 'Ride accepted successfully!';
  static const String rideCompletedMessage = 'Ride completed successfully!';

  // Regex Patterns
  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
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

  // Location Constants
  static const double locationUpdateInterval = 30.0; // seconds
  static const double minDistanceFilter = 10.0; // meters
}