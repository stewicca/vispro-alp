class AuthModel {
  final String userId;
  final String role;
  final String token;
  final String refreshToken;

  AuthModel({
    required this.userId,
    required this.role,
    required this.token,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userId'],
      role: json['role'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }
}
