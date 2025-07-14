class LoyaltyModel {
  final String userId;
  final int currentPoints;
  final String currentTier;
  final int currentTierPoints;
  final int nextTierPoints;
  final String referralCode;
  final int totalReferrals;
  final List<LoyaltyTransaction> transactions;
  final List<LoyaltyReward> availableRewards;

  LoyaltyModel({
    required this.userId,
    required this.currentPoints,
    required this.currentTier,
    required this.currentTierPoints,
    required this.nextTierPoints,
    required this.referralCode,
    required this.totalReferrals,
    required this.transactions,
    required this.availableRewards,
  });

  factory LoyaltyModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyModel(
      userId: json['userId'] ?? '',
      currentPoints: json['currentPoints'] ?? 0,
      currentTier: json['currentTier'] ?? 'Bronze',
      currentTierPoints: json['currentTierPoints'] ?? 0,
      nextTierPoints: json['nextTierPoints'] ?? 100,
      referralCode: json['referralCode'] ?? '',
      totalReferrals: json['totalReferrals'] ?? 0,
      transactions: (json['transactions'] as List? ?? [])
          .map((t) => LoyaltyTransaction.fromJson(t))
          .toList(),
      availableRewards: (json['availableRewards'] as List? ?? [])
          .map((r) => LoyaltyReward.fromJson(r))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'currentPoints': currentPoints,
      'currentTier': currentTier,
      'currentTierPoints': currentTierPoints,
      'nextTierPoints': nextTierPoints,
      'referralCode': referralCode,
      'totalReferrals': totalReferrals,
      'transactions': transactions.map((t) => t.toJson()).toList(),
      'availableRewards': availableRewards.map((r) => r.toJson()).toList(),
    };
  }
}

class LoyaltyTransaction {
  final String id;
  final int points;
  final String type;
  final String description;
  final DateTime createdAt;

  LoyaltyTransaction({
    required this.id,
    required this.points,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  factory LoyaltyTransaction.fromJson(Map<String, dynamic> json) {
    return LoyaltyTransaction(
      id: json['id'] ?? '',
      points: json['points'] ?? 0,
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points,
      'type': type,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class LoyaltyReward {
  final String id;
  final String name;
  final String description;
  final int pointsCost;
  final String type;
  final double? discountAmount;
  final String? discountType;

  LoyaltyReward({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsCost,
    required this.type,
    this.discountAmount,
    this.discountType,
  });

  factory LoyaltyReward.fromJson(Map<String, dynamic> json) {
    return LoyaltyReward(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pointsCost: json['pointsCost'] ?? 0,
      type: json['type'] ?? '',
      discountAmount: json['discountAmount']?.toDouble(),
      discountType: json['discountType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pointsCost': pointsCost,
      'type': type,
      'discountAmount': discountAmount,
      'discountType': discountType,
    };
  }
}