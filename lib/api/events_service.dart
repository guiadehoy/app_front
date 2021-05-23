import 'dart:convert';
import 'package:app_scanner/models/login_response.dart';
import 'package:dio/dio.dart';

class EventsProvider {
  Dio _client;

  EventsProvider(this._client);

  Future<LoginResponse> fetchEventList() async {
    try {
      final response = await _client.get('/scanner/events/user');
      return LoginResponse.fromJson(response.data);
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw new Exception(errorMessage);
    }
  }
}
