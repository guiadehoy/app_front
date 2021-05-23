class LoginResponse {
  String accessToken;
  String profile;
  String refreshToken;
  String email;
  String name;

  LoginResponse(
      {required this.accessToken,
      required this.profile,
      required this.refreshToken,
      required this.email,
      required this.name});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      profile: json['profile'],
      refreshToken: json['refresh_token'],
      email: json['email'],
      name: json['name'],
    );
  }
}
