class Endpoints {
  Endpoints._();

  static const String baseUrlApi =
      "https://backoffice-api.dev.guiadehoy.com/api/v1/";

  static const String penaltyFee = baseUrlApi + "/api/v1/penaltyfee";

  static const String getArticlesByCity = baseUrlApi + "/api/v1/articles/";

  static const String login = baseUrlApi + "/api/v1/auth/login";

  static const int receiveTimeout = 5000;

  static const int connectionTimeout = 60000;
}
