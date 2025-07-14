class RideModel {
  final String id;
  final String customerId;
  final String? customerName;
  final String? customerPhone;
  final String petId;
  final String? petName;
  final String? petBreed;
  final String? petSize;
  final String pickupAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final String dropOffAddress;
  final double dropOffLatitude;
  final double dropOffLongitude;
  final DateTime scheduledTime;
  final RideStatus status;
  final RideType type;
  final double totalPrice;
  final bool needsCrate;
  final bool needsMedication;
  final String? specialInstructions;
  final String? customerNotes;
  final DateTime? estimatedArrival;
  final DateTime? actualPickupTime;
  final DateTime? actualDropOffTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  RideModel({
    required this.id,
    required this.customerId,
    this.customerName,
    this.customerPhone,
    required this.petId,
    this.petName,
    this.petBreed,
    this.petSize,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropOffAddress,
    required this.dropOffLatitude,
    required this.dropOffLongitude,
    required this.scheduledTime,
    required this.status,
    required this.type,
    required this.totalPrice,
    required this.needsCrate,
    required this.needsMedication,
    this.specialInstructions,
    this.customerNotes,
    this.estimatedArrival,
    this.actualPickupTime,
    this.actualDropOffTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      petId: json['petId'] ?? '',
      petName: json['petName'],
      petBreed: json['petBreed'],
      petSize: json['petSize'],
      pickupAddress: json['pickupAddress'] ?? '',
      pickupLatitude: (json['pickupLatitude'] ?? 0).toDouble(),
      pickupLongitude: (json['pickupLongitude'] ?? 0).toDouble(),
      dropOffAddress: json['dropOffAddress'] ?? '',
      dropOffLatitude: (json['dropOffLatitude'] ?? 0).toDouble(),
      dropOffLongitude: (json['dropOffLongitude'] ?? 0).toDouble(),
      scheduledTime: DateTime.parse(json['scheduledTime'] ?? DateTime.now().toIso8601String()),
      status: RideStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RideStatus.assigned,
      ),
      type: RideType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => RideType.oneWay,
      ),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      needsCrate: json['needsCrate'] ?? false,
      needsMedication: json['needsMedication'] ?? false,
      specialInstructions: json['specialInstructions'],
      customerNotes: json['customerNotes'],
      estimatedArrival: json['estimatedArrival'] != null 
          ? DateTime.parse(json['estimatedArrival']) 
          : null,
      actualPickupTime: json['actualPickupTime'] != null 
          ? DateTime.parse(json['actualPickupTime']) 
          : null,
      actualDropOffTime: json['actualDropOffTime'] != null 
          ? DateTime.parse(json['actualDropOffTime']) 
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'petId': petId,
      'petName': petName,
      'petBreed': petBreed,
      'petSize': petSize,
      'pickupAddress': pickupAddress,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffAddress': dropOffAddress,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
      'scheduledTime': scheduledTime.toIso8601String(),
      'status': status.name,
      'type': type.name,
      'totalPrice': totalPrice,
      'needsCrate': needsCrate,
      'needsMedication': needsMedication,
      'specialInstructions': specialInstructions,
      'customerNotes': customerNotes,
      'estimatedArrival': estimatedArrival?.toIso8601String(),
      'actualPickupTime': actualPickupTime?.toIso8601String(),
      'actualDropOffTime': actualDropOffTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get statusDisplayName {
    switch (status) {
      case RideStatus.assigned:
        return 'Assigned';
      case RideStatus.enRoutePickup:
        return 'En Route to Pickup';
      case RideStatus.arrivedPickup:
        return 'Arrived at Pickup';
      case RideStatus.petPickedUp:
        return 'Pet Picked Up';
      case RideStatus.enRouteDropoff:
        return 'En Route to Drop-off';
      case RideStatus.arrivedDropoff:
        return 'Arrived at Drop-off';
      case RideStatus.completed:
        return 'Completed';
    }
  }

  String get statusEmoji {
    switch (status) {
      case RideStatus.assigned:
        return '📋';
      case RideStatus.enRoutePickup:
        return '🚗';
      case RideStatus.arrivedPickup:
        return '📍';
      case RideStatus.petPickedUp:
        return '🐾';
      case RideStatus.enRouteDropoff:
        return '🚗';
      case RideStatus.arrivedDropoff:
        return '📍';
      case RideStatus.completed:
        return '✅';
    }
  }

  String get typeDisplayName {
    switch (type) {
      case RideType.oneWay:
        return 'One Way';
      case RideType.roundTrip:
        return 'Round Trip';
    }
  }
}

enum RideStatus {
  assigned,
  enRoutePickup,
  arrivedPickup,
  petPickedUp,
  enRouteDropoff,
  arrivedDropoff,
  completed,
}

enum RideType { oneWay, roundTrip }