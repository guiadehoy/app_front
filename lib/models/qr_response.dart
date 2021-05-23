class QrResponse {
  String typeTicket;
  String message;
  String name;

  QrResponse({
    required this.typeTicket,
    required this.message,
    required this.name,
  });

  factory QrResponse.fromJson(Map<String, dynamic> json) {
    return QrResponse(
      typeTicket: json['type_ticket'],
      message: json['message'],
      name: json['name'],
    );
  }
}
