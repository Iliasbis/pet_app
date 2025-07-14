import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_constants.dart';

class ApiProvider {
  late Dio _dio;
  final SharedPreferences _prefs = getx.Get.find<SharedPreferences>();

  ApiProvider() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token to requests
          final token = _prefs.getString(AppConstants.accessTokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // Handle token expiration
          if (error.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          handler.next(error);
        },
      ),
    );
  }

  void _handleUnauthorized() {
    _prefs.remove(AppConstants.accessTokenKey);
    _prefs.remove(AppConstants.driverDataKey);
    _prefs.setBool(AppConstants.isLoggedInKey, false);
    getx.Get.offAllNamed('/login');
  }

  // Auth APIs
  Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post('/auth/driver/login', data: data);
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post('/auth/driver/register', data: data);
  }

  Future<Response> getProfile() async {
    return await _dio.get('/drivers/me');
  }

  // Driver APIs
  Future<Response> updateProfile(Map<String, dynamic> data) async {
    return await _dio.patch('/drivers/me', data: data);
  }

  Future<Response> updateStatus(String status) async {
    return await _dio.patch('/drivers/me/status', data: {'status': status});
  }

  Future<Response> updateLocation(double latitude, double longitude) async {
    return await _dio.patch('/drivers/me/location', data: {
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  // Ride APIs
  Future<Response> getAssignedRides() async {
    return await _dio.get('/drivers/rides/assigned');
  }

  Future<Response> getRideHistory() async {
    return await _dio.get('/drivers/rides/history');
  }

  Future<Response> getRideDetails(String rideId) async {
    return await _dio.get('/drivers/rides/$rideId');
  }

  Future<Response> acceptRide(String rideId) async {
    return await _dio.post('/drivers/rides/$rideId/accept');
  }

  Future<Response> updateRideStatus(String rideId, String status, {Map<String, dynamic>? data}) async {
    final payload = {'status': status};
    if (data != null) payload.addAll(data);
    return await _dio.patch('/drivers/rides/$rideId/status', data: payload);
  }

  Future<Response> completeRide(String rideId, Map<String, dynamic> data) async {
    return await _dio.post('/drivers/rides/$rideId/complete', data: data);
  }

  // Messaging APIs
  Future<Response> getConversations() async {
    return await _dio.get('/drivers/conversations');
  }

  Future<Response> getMessages(String conversationId) async {
    return await _dio.get('/drivers/conversations/$conversationId/messages');
  }

  Future<Response> sendMessage(String conversationId, String message) async {
    return await _dio.post('/drivers/conversations/$conversationId/messages', data: {
      'message': message,
    });
  }

  // Earnings APIs
  Future<Response> getEarnings({String? period}) async {
    final queryParams = period != null ? {'period': period} : <String, dynamic>{};
    return await _dio.get('/drivers/earnings', queryParameters: queryParams);
  }

  Future<Response> getEarningsDetails(String rideId) async {
    return await _dio.get('/drivers/earnings/$rideId');
  }

  // Schedule APIs
  Future<Response> getSchedule() async {
    return await _dio.get('/drivers/schedule');
  }

  Future<Response> updateSchedule(Map<String, dynamic> data) async {
    return await _dio.patch('/drivers/schedule', data: data);
  }

  // Notification APIs
  Future<Response> updateFCMToken(String token) async {
    return await _dio.patch('/drivers/fcm-token', data: {'token': token});
  }

  Future<Response> getNotifications() async {
    return await _dio.get('/drivers/notifications');
  }

  Future<Response> markNotificationAsRead(String notificationId) async {
    return await _dio.patch('/drivers/notifications/$notificationId/read');
  }
}