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
    // Listen for new ride assignments
    _socket.on('ride_assigned', (data) {
      print('New ride assigned: $data');
      _handleRideAssigned(data);
    });

    // Listen for ride updates
    _socket.on('ride_updated', (data) {
      print('Ride updated: $data');
      _handleRideUpdated(data);
    });

    // Listen for ride cancellations
    _socket.on('ride_cancelled', (data) {
      print('Ride cancelled: $data');
      _handleRideCancelled(data);
    });

    // Listen for messages
    _socket.on('new_message', (data) {
      print('New message: $data');
      _handleNewMessage(data);
    });

    // Listen for driver status updates
    _socket.on('driver_status_updated', (data) {
      print('Driver status updated: $data');
      _handleDriverStatusUpdated(data);
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
      _socket.emit('authenticate', {'token': token, 'userType': 'driver'});
    }
  }

  // Emit events
  void updateDriverLocation(double latitude, double longitude) {
    if (isConnected.value) {
      _socket.emit('driver_location_update', {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  void updateDriverStatus(String status) {
    if (isConnected.value) {
      _socket.emit('driver_status_update', {'status': status});
    }
  }

  void updateRideStatus(String rideId, String status, {Map<String, dynamic>? additionalData}) {
    if (isConnected.value) {
      final data = {
        'rideId': rideId,
        'status': status,
        'timestamp': DateTime.now().toIso8601String(),
      };
      if (additionalData != null) {
        data.addAll(additionalData);
      }
      _socket.emit('ride_status_update', data);
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

  void joinRideRoom(String rideId) {
    if (isConnected.value) {
      _socket.emit('join_ride_room', {'rideId': rideId});
    }
  }

  void leaveRideRoom(String rideId) {
    if (isConnected.value) {
      _socket.emit('leave_ride_room', {'rideId': rideId});
    }
  }

  // Event handlers
  void _handleRideAssigned(dynamic data) {
    // Handle new ride assignment
    Get.toNamed('/ride-details', arguments: data['rideId']);
  }

  void _handleRideUpdated(dynamic data) {
    // Handle ride updates
    // Refresh current ride data if viewing ride details
  }

  void _handleRideCancelled(dynamic data) {
    // Handle ride cancellation
    Get.snackbar(
      'Ride Cancelled',
      'The ride has been cancelled by the customer',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleNewMessage(dynamic data) {
    // Handle new message
    Get.snackbar(
      'New Message',
      data['message'],
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleDriverStatusUpdated(dynamic data) {
    // Handle driver status updates
    print('Driver status updated to: ${data['status']}');
  }

  @override
  void onClose() {
    _socket.dispose();
    super.onClose();
  }
}