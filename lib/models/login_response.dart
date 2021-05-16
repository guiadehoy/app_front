class LoginResponse {
  String accessToken;
  int useriId;

  LoginResponse({required this.accessToken, required this.useriId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      useriId: json['id_city'],
    );
  }
}
