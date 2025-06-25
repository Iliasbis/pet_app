import 'pet_model.dart';

class ServiceModel {
  final String id;
  final String name;
  final String? description;
  final ServiceType type;
  final double smallPetPrice;
  final double mediumPetPrice;
  final double largePetPrice;
  final double cratePrice;
  final double medicationPrice;
  final double waitReturnHourlyPrice;
  final double specialTimePrice;
  final double roundTripMultiplier;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceModel({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    required this.smallPetPrice,
    required this.mediumPetPrice,
    required this.largePetPrice,
    required this.cratePrice,
    required this.medicationPrice,
    required this.waitReturnHourlyPrice,
    required this.specialTimePrice,
    required this.roundTripMultiplier,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    double parsePrice(dynamic value, [double fallback = 0.0]) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? fallback;
      return fallback;
    }
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      type: ServiceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ServiceType.local,
      ),
      smallPetPrice: parsePrice(json['smallPetPrice']),
      mediumPetPrice: parsePrice(json['mediumPetPrice']),
      largePetPrice: parsePrice(json['largePetPrice']),
      cratePrice: parsePrice(json['cratePrice']),
      medicationPrice: parsePrice(json['medicationPrice']),
      waitReturnHourlyPrice: parsePrice(json['waitReturnHourlyPrice']),
      specialTimePrice: parsePrice(json['specialTimePrice']),
      roundTripMultiplier: parsePrice(json['roundTripMultiplier'], 1.6),
      isActive: json['isActive'] ?? true,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.name,
      'smallPetPrice': smallPetPrice,
      'mediumPetPrice': mediumPetPrice,
      'largePetPrice': largePetPrice,
      'cratePrice': cratePrice,
      'medicationPrice': medicationPrice,
      'waitReturnHourlyPrice': waitReturnHourlyPrice,
      'specialTimePrice': specialTimePrice,
      'roundTripMultiplier': roundTripMultiplier,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get typeDisplayName {
    switch (type) {
      case ServiceType.local:
        return 'Local (Up to 15 miles)';
      case ServiceType.standard:
        return 'Standard (16-30 miles)';
      case ServiceType.long:
        return 'Long Distance (31-50 miles)';
      case ServiceType.extended:
        return 'Extended (51+ miles)';
    }
  }

  String get typeEmoji {
    switch (type) {
      case ServiceType.local:
        return '🏠';
      case ServiceType.standard:
        return '🚗';
      case ServiceType.long:
        return '🛣️';
      case ServiceType.extended:
        return '🌎';
    }
  }

  double getPriceForPetSize(PetSize petSize) {
    switch (petSize) {
      case PetSize.small:
        return smallPetPrice;
      case PetSize.medium:
        return mediumPetPrice;
      case PetSize.large:
        return largePetPrice;
    }
  }
}

enum ServiceType { local, standard, long, extended }
