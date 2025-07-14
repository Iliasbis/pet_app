import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../data/models/booking_model.dart';
import '../../data/providers/api_provider.dart';
import '../../services/socket_service.dart';

class TrackingController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SocketService _socketService = Get.find<SocketService>();

  late GoogleMapController mapController;
  final booking = Rxn<BookingModel>();
  final driverLocation = Rxn<LatLng>();
  final estimatedArrival = Rxn<DateTime>();
  final isLoading = false.obs;
  final markers = <Marker>{}.obs;
  final polylines = <Polyline>{}.obs;

  Timer? _trackingTimer;

  @override
  void onInit() {
    super.onInit();
    final bookingId = Get.arguments as String?;
    if (bookingId != null) {
      loadBookingDetails(bookingId);
      startTracking(bookingId);
    }
  }

  @override
  void onClose() {
    _trackingTimer?.cancel();
    super.onClose();
  }

  Future<void> loadBookingDetails(String bookingId) async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getBooking(bookingId);
      booking.value = BookingModel.fromJson(response.data);
      _setupMapMarkers();
    } catch (e) {
      print('Error loading booking details: $e');
      Get.snackbar(
        'Error',
        'Failed to load booking details',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void startTracking(String bookingId) {
    _socketService.joinBookingRoom(bookingId);
    _socketService.requestRideTracking(bookingId);

    // Set up periodic tracking updates
    _trackingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _requestLocationUpdate(bookingId);
    });
  }

  void _requestLocationUpdate(String bookingId) {
    _socketService.requestRideTracking(bookingId);
  }

  void _setupMapMarkers() {
    if (booking.value == null) return;

    final bookingData = booking.value!;
    markers.clear();

    // Pickup marker
    markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(
          double.parse(bookingData.pickupAddress.split(',')[0]), // This would need proper geocoding
          double.parse(bookingData.pickupAddress.split(',')[1]),
        ),
        infoWindow: const InfoWindow(
          title: 'Pickup Location',
          snippet: 'Pet pickup point',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    // Drop-off marker
    markers.add(
      Marker(
        markerId: const MarkerId('dropoff'),
        position: LatLng(
          double.parse(bookingData.dropOffAddress.split(',')[0]), // This would need proper geocoding
          double.parse(bookingData.dropOffAddress.split(',')[1]),
        ),
        infoWindow: const InfoWindow(
          title: 'Drop-off Location',
          snippet: 'Pet destination',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    // Driver marker (if available)
    if (driverLocation.value != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: driverLocation.value!,
          infoWindow: const InfoWindow(
            title: 'Driver Location',
            snippet: 'Current driver position',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  void updateDriverLocation(double latitude, double longitude) {
    driverLocation.value = LatLng(latitude, longitude);
    _setupMapMarkers();
    
    // Update camera to show driver location
    if (::mapController != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(driverLocation.value!),
      );
    }
  }

  void updateEstimatedArrival(DateTime arrival) {
    estimatedArrival.value = arrival;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    
    // Fit map to show all markers
    if (markers.isNotEmpty) {
      _fitMapToMarkers();
    }
  }

  void _fitMapToMarkers() {
    if (markers.isEmpty) return;

    double minLat = markers.first.position.latitude;
    double maxLat = markers.first.position.latitude;
    double minLng = markers.first.position.longitude;
    double maxLng = markers.first.position.longitude;

    for (final marker in markers) {
      minLat = math.min(minLat, marker.position.latitude);
      maxLat = math.max(maxLat, marker.position.latitude);
      minLng = math.min(minLng, marker.position.longitude);
      maxLng = math.max(maxLng, marker.position.longitude);
    }

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100.0, // padding
      ),
    );
  }

  void callDriver() {
    // Implement call driver functionality
    Get.snackbar(
      'Calling Driver',
      'Connecting you with your driver...',
      backgroundColor: Colors.blue,
    );
  }

  void messageDriver() {
    // Navigate to messaging screen
    Get.toNamed('/messages', arguments: booking.value?.id);
  }

  String get statusText {
    if (booking.value == null) return 'Loading...';
    
    switch (booking.value!.status) {
      case BookingStatus.confirmed:
        return 'Driver is on the way to pickup location';
      case BookingStatus.inProgress:
        return 'Driver is transporting your pet';
      case BookingStatus.completed:
        return 'Ride completed successfully';
      default:
        return 'Booking ${booking.value!.statusDisplayName}';
    }
  }

  String get estimatedArrivalText {
    if (estimatedArrival.value == null) return 'Calculating...';
    
    final now = DateTime.now();
    final difference = estimatedArrival.value!.difference(now);
    
    if (difference.inMinutes <= 0) {
      return 'Arriving now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes';
    } else {
      return '${difference.inHours}h ${difference.inMinutes % 60}m';
    }
  }
}