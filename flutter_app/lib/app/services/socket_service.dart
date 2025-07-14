import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/app_constants.dart';

class SocketService extends GetxService {
  late IO.Socket _socket;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  
  final isConnected = false.obs;
  final connectionStatus = 'Disconnected'.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket = IO.io(
      AppConstants.baseUrl.replaceAll('/api/v1', ''),
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      print('Socket connected');
      isConnected.value = true;
      connectionStatus.value = 'Connected';
      _authenticateSocket();
    });

    _socket.onDisconnect((_) {
      print('Socket disconnected');
      isConnected.value = false;
      connectionStatus.value = 'Disconnected';
    });

    _socket.onConnectError((error) {
      print('Socket connection error: $error');
      connectionStatus.value = 'Connection Error';
    });

    _setupEventListeners();
  }

  void _setupEventListeners() {
    // Listen for booking updates
    _socket.on('booking_updated', (data) {
      print('Booking updated: $data');
      _handleBookingUpdated(data);
    });

    // Listen for driver assignment
    _socket.on('driver_assigned', (data) {
      print('Driver assigned: $data');
      _handleDriverAssigned(data);
    });

    // Listen for ride tracking updates
    _socket.on('ride_tracking_update', (data) {
      print('Ride tracking update: $data');
      _handleRideTrackingUpdate(data);
    });

    // Listen for messages
    _socket.on('new_message', (data) {
      print('New message: $data');
      _handleNewMessage(data);
    });

    // Listen for promotional offers
    _socket.on('promotional_offer', (data) {
      print('Promotional offer: $data');
      _handlePromotionalOffer(data);
    });
  }

  void connect() {
    if (!isConnected.value) {
      _socket.connect();
    }
  }

  void disconnect() {
    if (isConnected.value) {
      _socket.disconnect();
    }
  }

  void _authenticateSocket() {
    final token = _prefs.getString(AppConstants.accessTokenKey);
    if (token != null) {
      _socket.emit('authenticate', {'token': token, 'userType': 'customer'});
    }
  }

  // Emit events
  void joinBookingRoom(String bookingId) {
    if (isConnected.value) {
      _socket.emit('join_booking_room', {'bookingId': bookingId});
    }
  }

  void leaveBookingRoom(String bookingId) {
    if (isConnected.value) {
      _socket.emit('leave_booking_room', {'bookingId': bookingId});
    }
  }

  void sendMessage(String conversationId, String message, String recipientId) {
    if (isConnected.value) {
      _socket.emit('send_message', {
        'conversationId': conversationId,
        'message': message,
        'recipientId': recipientId,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  void requestRideTracking(String bookingId) {
    if (isConnected.value) {
      _socket.emit('request_ride_tracking', {'bookingId': bookingId});
    }
  }

  // Event handlers
  void _handleBookingUpdated(dynamic data) {
    // Handle booking updates
    Get.snackbar(
      'Booking Update',
      'Your booking status has been updated',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleDriverAssigned(dynamic data) {
    // Handle driver assignment
    Get.snackbar(
      'Driver Assigned',
      'A driver has been assigned to your booking',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleRideTrackingUpdate(dynamic data) {
    // Handle ride tracking updates
    // Update tracking screen if visible
  }

  void _handleNewMessage(dynamic data) {
    // Handle new message
    Get.snackbar(
      'New Message',
      data['message'],
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handlePromotionalOffer(dynamic data) {
    // Handle promotional offers
    Get.snackbar(
      'Special Offer!',
      data['message'],
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onClose() {
    _socket.dispose();
    super.onClose();
  }
}