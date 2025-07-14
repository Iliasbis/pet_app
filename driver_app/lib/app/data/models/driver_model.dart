class DriverModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? address;
  final String? licenseNumber;
  final String? vehicleInfo;
  final DriverStatus status;
  final double? currentLatitude;
  final double? currentLongitude;
  final double rating;
  final int totalRides;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.address,
    this.licenseNumber,
    this.vehicleInfo,
    required this.status,
    this.currentLatitude,
    this.currentLongitude,
    required this.rating,
    required this.totalRides,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'],
      address: json['address'],
      licenseNumber: json['licenseNumber'],
      vehicleInfo: json['vehicleInfo'],
      status: DriverStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => DriverStatus.offline,
      ),
      currentLatitude: json['currentLatitude']?.toDouble(),
      currentLongitude: json['currentLongitude']?.toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      totalRides: json['totalRides'] ?? 0,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'licenseNumber': licenseNumber,
      'vehicleInfo': vehicleInfo,
      'status': status.name,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
      'rating': rating,
      'totalRides': totalRides,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}';
  
  String get statusDisplayName {
    switch (status) {
      case DriverStatus.offline:
        return 'Offline';
      case DriverStatus.available:
        return 'Available';
      case DriverStatus.busy:
        return 'Busy';
      case DriverStatus.onRide:
        return 'On Ride';
    }
  }
}

enum DriverStatus { offline, available, busy, onRide }