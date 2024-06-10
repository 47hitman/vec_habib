import 'package:dio/dio.dart';

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://develop-at.vesperia.id:1091',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // Login request
  Future<String?> login(
      String phoneNumber, String password, String countryCode) async {
    try {
      final response = await _dio.post('/api/v1/sign-in', data: {
        'phone_number': phoneNumber,
        'password': password,
        'country_code': countryCode,
      });

      // If login is successful, return the access token
      if (response.data['data'] != null &&
          response.data['data']['token'] != null) {
        return response.data['data']['token'];
      }
      return null;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // Example method to get user details
  Future<Map<String, dynamic>?> getUserDetails(String token) async {
    try {
      final response = await _dio.get('/api/v1/user',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      return response.data;
    } catch (e) {
      print('Error getting user details: $e');
      return null;
    }
  }

  // Add more methods for other API requests as needed
}
