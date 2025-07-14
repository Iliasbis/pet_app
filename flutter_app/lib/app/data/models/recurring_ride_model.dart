class RecurringRideModel {
  final String id;
  final String name;
  final String petId;
  final String? petName;
  final String serviceId;
  final String? serviceName;
  final String pickupAddress;
  final String dropOffAddress;
  final String pickupTime;
  final RecurrenceType recurrenceType;
  final List<int> daysOfWeek; // 1-7 for Monday-Sunday
  final int? dayOfMonth; // For monthly recurrence
  final bool isActive;
  final DateTime? nextRideDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecurringRideModel({
    required this.id,
    required this.name,
    required this.petId,
    this.petName,
    required this.serviceId,
    this.serviceName,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.pickupTime,
    required this.recurrenceType,
    required this.daysOfWeek,
    this.dayOfMonth,
    required this.isActive,
    this.nextRideDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecurringRideModel.fromJson(Map<String, dynamic> json) {
    return RecurringRideModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      petId: json['petId'] ?? '',
      petName: json['petName'],
      serviceId: json['serviceId'] ?? '',
      serviceName: json['serviceName'],
      pickupAddress: json['pickupAddress'] ?? '',
      dropOffAddress: json['dropOffAddress'] ?? '',
      pickupTime: json['pickupTime'] ?? '',
      recurrenceType: RecurrenceType.values.firstWhere(
        (e) => e.name == json['recurrenceType'],
        orElse: () => RecurrenceType.weekly,
      ),
      daysOfWeek: List<int>.from(json['daysOfWeek'] ?? []),
      dayOfMonth: json['dayOfMonth'],
      isActive: json['isActive'] ?? true,
      nextRideDate: json['nextRideDate'] != null 
          ? DateTime.parse(json['nextRideDate']) 
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'petId': petId,
      'petName': petName,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'pickupAddress': pickupAddress,
      'dropOffAddress': dropOffAddress,
      'pickupTime': pickupTime,
      'recurrenceType': recurrenceType.name,
      'daysOfWeek': daysOfWeek,
      'dayOfMonth': dayOfMonth,
      'isActive': isActive,
      'nextRideDate': nextRideDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  RecurringRideModel copyWith({
    String? id,
    String? name,
    String? petId,
    String? petName,
    String? serviceId,
    String? serviceName,
    String? pickupAddress,
    String? dropOffAddress,
    String? pickupTime,
    RecurrenceType? recurrenceType,
    List<int>? daysOfWeek,
    int? dayOfMonth,
    bool? isActive,
    DateTime? nextRideDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecurringRideModel(
      id: id ?? this.id,
      name: name ?? this.name,
      petId: petId ?? this.petId,
      petName: petName ?? this.petName,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropOffAddress: dropOffAddress ?? this.dropOffAddress,
      pickupTime: pickupTime ?? this.pickupTime,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      isActive: isActive ?? this.isActive,
      nextRideDate: nextRideDate ?? this.nextRideDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get recurrenceDisplayName {
    switch (recurrenceType) {
      case RecurrenceType.daily:
        return 'Daily';
      case RecurrenceType.weekly:
        return 'Weekly';
      case RecurrenceType.monthly:
        return 'Monthly';
    }
  }

  String get scheduleDescription {
    switch (recurrenceType) {
      case RecurrenceType.daily:
        return 'Every day at $pickupTime';
      case RecurrenceType.weekly:
        final dayNames = daysOfWeek.map((day) => _getDayName(day)).join(', ');
        return '$dayNames at $pickupTime';
      case RecurrenceType.monthly:
        return 'Day $dayOfMonth of every month at $pickupTime';
    }
  }

  String _getDayName(int day) {
    switch (day) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}

enum RecurrenceType { daily, weekly, monthly }