import 'package:dio/dio.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    final response = await dio.post(
      'https://bd46-182-253-247-224.ngrok-free.app/api/auth/signin',
      data: {
        "username": username,
        "password": password,
      },
    );
    return response.data;
  }
}
