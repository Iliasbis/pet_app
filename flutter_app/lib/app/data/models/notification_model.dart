class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.data,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      data: json['data'],
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'data': data,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get typeEmoji {
    switch (type) {
      case 'booking_confirmed':
        return '✅';
      case 'driver_assigned':
        return '🚗';
      case 'ride_started':
        return '🏁';
      case 'ride_completed':
        return '🎉';
      case 'payment_processed':
        return '💳';
      case 'message':
        return '💬';
      case 'promotion':
        return '🎁';
      default:
        return '📱';
    }
  }
}