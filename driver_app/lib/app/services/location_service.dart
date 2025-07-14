import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/app_constants.dart';

class LocationService extends GetxService {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  
  final currentPosition = Rxn<Position>();
  final isLocationEnabled = false.obs;
  final isTracking = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLocationEnabled.value = false;
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLocationEnabled.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLocationEnabled.value = false;
      return;
    }

    isLocationEnabled.value = true;
    await getCurrentLocation();
  }

  Future<Position?> getCurrentLocation() async {
    if (!isLocationEnabled.value) {
      await _checkLocationPermission();
      if (!isLocationEnabled.value) return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentPosition.value = position;
      await _saveLocationToStorage(position);
      return position;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  Future<void> startLocationTracking() async {
    if (!isLocationEnabled.value || isTracking.value) return;

    isTracking.value = true;
    
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: AppConstants.minDistanceFilter.toInt(),
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      currentPosition.value = position;
      _saveLocationToStorage(position);
      _sendLocationUpdate(position);
    });
  }

  void stopLocationTracking() {
    isTracking.value = false;
  }

  Future<void> _saveLocationToStorage(Position position) async {
    await _prefs.setString(
      AppConstants.driverLocationKey,
      '${position.latitude},${position.longitude}',
    );
  }

  void _sendLocationUpdate(Position position) {
    // Send location update to server via socket or API
    // This will be implemented when we add the socket service
    print('Location update: ${position.latitude}, ${position.longitude}');
  }

  Future<double> getDistanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) async {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  Future<double> getBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) async {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  String get locationString {
    if (currentPosition.value == null) return 'Unknown';
    return '${currentPosition.value!.latitude.toStringAsFixed(6)}, ${currentPosition.value!.longitude.toStringAsFixed(6)}';
  }
}