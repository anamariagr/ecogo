import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'api_client.dart';

class AuthService extends GetxService {
  final ApiClient apiClient;
  final storage = GetStorage();

  AuthService(this.apiClient);

  Future<bool> login(String email, String googleId) async {
    final response = await apiClient.post('/login', {
      'email': email,
      'google_id': googleId,
    });

    print({
      'email': email,
      'google_id': googleId,
    });

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");
    print("Full Response: ${response}");
    if (response.isOk) {
      final token = response.body['token'];
      final user = response.body['user'];
      storage.write('token', token);
      storage.write('user', user);
      // Almacenar token
      apiClient.setToken(token);
      return true;
    } else {
      // Get.snackbar('Login Failed', response.body['error'] ?? 'Unknown error');
      return false;
    }
  }

  Future<bool> register(
      String email, String googleId, String name, String? profilePhoto) async {
    final response = await apiClient.post('/register', {
      'email': email,
      'google_id': googleId,
      'name': name,
      'profile_photo': profilePhoto,
    });

    if (response.isOk) {
      final token = response.body['token'];
      final user = response.body['user'];
      storage.write('token', token);
      storage.write('user', user);

      apiClient.setToken(token);
      return true;
    } else {
      //   Get.snackbar('Registration Failed', response.body['error'] ?? 'Unknown error');
      return false;
    }
  }

  Future<void> logout() async {
    apiClient.removeToken();
  }
}
