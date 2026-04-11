import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class ApiClient extends GetConnect {
  final storage = GetStorage();
  final String baseUrl = 'http://192.168.2.6:8000/api';

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;

    // Interceptor para agregar token y depurar solicitudes
    httpClient.addRequestModifier<Object?>((request) {
      final token = storage.read<String>('jwt_token');

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.headers['Accept'] = 'application/json';

      // Depuración de la solicitud
      print('--- API REQUEST ---');
      print('URL: ${request.url}');
      print('Body: ${_getBodyAsString(request)}'); // Obtiene el cuerpo como string
      print('Method: ${request.method}');
      print('Headers: ${request.headers}');
      print('--------------------');

      return request;
    });

    // Interceptor para depurar respuestas
    httpClient.addResponseModifier<Object?>((request, response) {
      // Depuración de la respuesta
      print('--- API RESPONSE ---');
      print('URL: ${request.url}');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.bodyString}');
      print('---------------------');

      return response;
    });

    super.onInit();
  }

  // Método para convertir el cuerpo de la solicitud en un string legible
  String _getBodyAsString(request) {
    try {
      if (request.bodyBytes.isNotEmpty) {
        return utf8.decode(request.bodyBytes);
      } else {
        return 'No Body';
      }
    } catch (e) {
      return 'Error reading body: $e';
    }
  }

  // Método para establecer el token en el almacenamiento
  void setToken(String token) {
    storage.write('jwt_token', token);
  }

  // Método para eliminar el token en el almacenamiento
  void removeToken() {
    storage.remove('jwt_token');
  }
}
