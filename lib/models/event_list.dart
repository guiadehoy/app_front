import 'package:app_scanner/models/event_response.dart';

class EventList {
  late final List<EventResponse> events;

  EventList({
    required this.events,
  });

  factory EventList.fromJson(List<dynamic> json) {
    return EventList(
      events: json.map((post) => EventResponse.fromJson(post)).toList(),
    );
  }
}
