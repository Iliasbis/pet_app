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
    _prefs.remove(AppConstants.userDataKey);
    _prefs.setBool(AppConstants.isLoggedInKey, false);
    getx.Get.offAllNamed('/login');
  }

  // Auth APIs
  Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post('/auth/login', data: data);
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post('/auth/register', data: data);
  }

  Future<Response> getProfile() async {
    return await _dio.get('/users/me');
  }

  // User APIs
  Future<Response> updateProfile(Map<String, dynamic> data) async {
    return await _dio.patch('/users/me', data: data);
  }

  // Pet APIs
  Future<Response> getPets() async {
    return await _dio.get('/pets');
  }

  Future<Response> createPet(Map<String, dynamic> data) async {
    return await _dio.post('/pets', data: data);
  }

  Future<Response> updatePet(String id, Map<String, dynamic> data) async {
    return await _dio.patch('/pets/$id', data: data);
  }

  Future<Response> deletePet(String id) async {
    return await _dio.delete('/pets/$id');
  }

  // Service APIs
  Future<Response> getServices() async {
    return await _dio.get('/services');
  }

  Future<Response> calculatePrice(
      String serviceId, Map<String, dynamic> params) async {
    return await _dio.get('/services/calculate-price/$serviceId',
        queryParameters: params);
  }

  // Booking APIs
  Future<Response> getBookings() async {
    return await _dio.get('/bookings');
  }

  Future<Response> createBooking(Map<String, dynamic> data) async {
    return await _dio.post('/bookings', data: data);
  }

  Future<Response> getBooking(String id) async {
    return await _dio.get('/bookings/$id');
  }

  Future<Response> updateBooking(String id, Map<String, dynamic> data) async {
    return await _dio.patch('/bookings/$id', data: data);
  }

  Future<Response> cancelBooking(String id) async {
    return await _dio.delete('/bookings/$id');
  }

  // Payment APIs
  Future<Response> createPaymentIntent(Map<String, dynamic> data) async {
    return await _dio.post('/payments/create-intent', data: data);
  }

  Future<Response> confirmPayment(Map<String, dynamic> data) async {
    return await _dio.post('/payments/confirm', data: data);
  }

  // Loyalty APIs
  Future<Response> getLoyaltyData() async {
    return await _dio.get('/loyalty');
  }

  Future<Response> redeemLoyaltyPoints(int points) async {
    return await _dio.post('/loyalty/redeem', data: {
      'points': points,
      'description': 'Points redeemed for reward',
    });
  }

  Future<Response> processReferral(String referralCode) async {
    return await _dio.post('/loyalty/referral', data: {
      'referralCode': referralCode,
    });
  }

  // Recurring Rides APIs
  Future<Response> getRecurringRides() async {
    return await _dio.get('/recurring-rides');
  }

  Future<Response> createRecurringRide(Map<String, dynamic> data) async {
    return await _dio.post('/recurring-rides', data: data);
  }

  Future<Response> updateRecurringRide(String id, Map<String, dynamic> data) async {
    return await _dio.patch('/recurring-rides/$id', data: data);
  }

  Future<Response> deleteRecurringRide(String id) async {
    return await _dio.delete('/recurring-rides/$id');
  }

  // Messages APIs
  Future<Response> getConversations() async {
    return await _dio.get('/messages/conversations');
  }

  Future<Response> getMessages(String conversationId) async {
    return await _dio.get('/messages/conversations/$conversationId/messages');
  }

  Future<Response> sendMessage(String conversationId, String message) async {
    return await _dio.post('/messages/conversations/$conversationId/messages', data: {
      'content': message,
    });
  }

  // Notifications APIs
  Future<Response> getNotifications() async {
    return await _dio.get('/notifications');
  }

  Future<Response> markNotificationAsRead(String id) async {
    return await _dio.patch('/notifications/$id/read');
  }

  Future<Response> getUnreadNotificationsCount() async {
    return await _dio.get('/notifications/unread/count');
  }
}
