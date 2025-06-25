import 'pet_model.dart';
import 'service_model.dart';
import 'user_model.dart';

class BookingModel {
  final String id;
  final String pickupAddress;
  final String dropOffAddress;
  final DateTime pickupDate;
  final String pickupTime;
  final DateTime? dropOffDate;
  final String? dropOffTime;
  final BookingType type;
  final BookingStatus status;
  final double totalPrice;
  final bool needsCrate;
  final bool needsMedication;
  final int waitReturnHours;
  final bool isSpecialTime;
  final String? specialInstructions;
  final String? adminNotes;
  final String? assignedDriverId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final String petId;
  final String serviceId;
  final UserModel? user;
  final PetModel? pet;
  final ServiceModel? service;

  BookingModel({
    required this.id,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.pickupDate,
    required this.pickupTime,
    this.dropOffDate,
    this.dropOffTime,
    required this.type,
    required this.status,
    required this.totalPrice,
    required this.needsCrate,
    required this.needsMedication,
    required this.waitReturnHours,
    required this.isSpecialTime,
    this.specialInstructions,
    this.adminNotes,
    this.assignedDriverId,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.petId,
    required this.serviceId,
    this.user,
    this.pet,
    this.service,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      pickupAddress: json['pickupAddress'] ?? '',
      dropOffAddress: json['dropOffAddress'] ?? '',
      pickupDate: DateTime.parse(
          json['pickupDate'] ?? DateTime.now().toIso8601String()),
      pickupTime: json['pickupTime'] ?? '',
      dropOffDate: json['dropOffDate'] != null
          ? DateTime.parse(json['dropOffDate'])
          : null,
      dropOffTime: json['dropOffTime'],
      type: BookingType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => BookingType.oneWay,
      ),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      totalPrice: (() {
        final val = json['totalPrice'] ?? 0;
        if (val is num) return val.toDouble();
        if (val is String) return double.tryParse(val) ?? 0.0;
        return 0.0;
      })(),
      needsCrate: json['needsCrate'] ?? false,
      needsMedication: json['needsMedication'] ?? false,
      waitReturnHours: json['waitReturnHours'] ?? 0,
      isSpecialTime: json['isSpecialTime'] ?? false,
      specialInstructions: json['specialInstructions'],
      adminNotes: json['adminNotes'],
      assignedDriverId: json['assignedDriverId'],
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      userId: json['userId'] ?? '',
      petId: json['petId'] ?? '',
      serviceId: json['serviceId'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      pet: json['pet'] != null ? PetModel.fromJson(json['pet']) : null,
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pickupAddress': pickupAddress,
      'dropOffAddress': dropOffAddress,
      'pickupDate': pickupDate.toIso8601String(),
      'pickupTime': pickupTime,
      'dropOffDate': dropOffDate?.toIso8601String(),
      'dropOffTime': dropOffTime,
      'type': type.name,
      'status': status.name,
      'totalPrice': totalPrice,
      'needsCrate': needsCrate,
      'needsMedication': needsMedication,
      'waitReturnHours': waitReturnHours,
      'isSpecialTime': isSpecialTime,
      'specialInstructions': specialInstructions,
      'adminNotes': adminNotes,
      'assignedDriverId': assignedDriverId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'petId': petId,
      'serviceId': serviceId,
    };
  }

  String get statusDisplayName {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get statusEmoji {
    switch (status) {
      case BookingStatus.pending:
        return '⏳';
      case BookingStatus.confirmed:
        return '✅';
      case BookingStatus.inProgress:
        return '🚗';
      case BookingStatus.completed:
        return '🎉';
      case BookingStatus.cancelled:
        return '❌';
    }
  }

  String get typeDisplayName {
    switch (type) {
      case BookingType.oneWay:
        return 'One Way';
      case BookingType.roundTrip:
        return 'Round Trip';
    }
  }
}

enum BookingType { oneWay, roundTrip }

extension BookingTypeApi on BookingType {
  String get apiValue {
    switch (this) {
      case BookingType.oneWay:
        return 'one_way';
      case BookingType.roundTrip:
        return 'round_trip';
    }
  }
}

enum BookingStatus { pending, confirmed, inProgress, completed, cancelled }
