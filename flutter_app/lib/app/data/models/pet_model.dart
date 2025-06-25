class PetModel {
  final String id;
  final String name;
  final String breed;
  final int age;
  final PetSize size;
  final double weight;
  final String? color;
  final String? behaviorNotes;
  final String? medicalNotes;
  final String? vetName;
  final String? vetPhone;
  final String? vetAddress;
  final String? emergencyContact;
  final String? emergencyPhone;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String ownerId;

  PetModel({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.size,
    required this.weight,
    this.color,
    this.behaviorNotes,
    this.medicalNotes,
    this.vetName,
    this.vetPhone,
    this.vetAddress,
    this.emergencyContact,
    this.emergencyPhone,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerId,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? 0,
      size: PetSize.values.firstWhere(
        (e) => e.name == json['size'],
        orElse: () => PetSize.medium,
      ),
      weight: (json['weight'] ?? 0).toDouble(),
      color: json['color'],
      behaviorNotes: json['behaviorNotes'],
      medicalNotes: json['medicalNotes'],
      vetName: json['vetName'],
      vetPhone: json['vetPhone'],
      vetAddress: json['vetAddress'],
      emergencyContact: json['emergencyContact'],
      emergencyPhone: json['emergencyPhone'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      ownerId: json['ownerId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'age': age,
      'size': size.name,
      'weight': weight,
      'color': color,
      'behaviorNotes': behaviorNotes,
      'medicalNotes': medicalNotes,
      'vetName': vetName,
      'vetPhone': vetPhone,
      'vetAddress': vetAddress,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'ownerId': ownerId,
    };
  }

  String get sizeDisplayName {
    switch (size) {
      case PetSize.small:
        return 'Small (Under 25 lbs)';
      case PetSize.medium:
        return 'Medium (25-60 lbs)';
      case PetSize.large:
        return 'Large (Over 60 lbs)';
    }
  }

  String get petEmoji {
    final breedLower = breed.toLowerCase();
    if (breedLower.contains('cat') || breedLower.contains('kitten')) {
      return '🐱';
    } else if (breedLower.contains('dog') || breedLower.contains('puppy')) {
      return '🐶';
    } else if (breedLower.contains('bird')) {
      return '🐦';
    } else if (breedLower.contains('rabbit')) {
      return '🐰';
    } else {
      return '🐾';
    }
  }
}

enum PetSize { small, medium, large }