class LoginResponse {
  String access_token;
  int id_city;
  int user_id;

  LoginResponse(
      {required this.access_token,
      required this.id_city,
      required this.user_id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      access_token: json['access_token'],
      id_city: json['id_city'],
      user_id: json['user_id'],
    );
  }
}
