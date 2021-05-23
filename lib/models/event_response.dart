class EventResponse {
  String hourLabel;
  int id;
  String image;
  String scannedQrLabel;
  String name;

  EventResponse(
      {required this.hourLabel,
      required this.id,
      required this.image,
      required this.scannedQrLabel,
      required this.name});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      hourLabel: json['hourLabel'],
      id: json['id'],
      image: json['image'],
      scannedQrLabel: json['scannedQrLabel'],
      name: json['name'],
    );
  }
}
