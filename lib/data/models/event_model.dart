import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class Event with _$Event {
  const Event._();
  const factory Event({
    required dynamic id,
    required String name,
    required String image,
    required DateTime dateTime,
    required String description,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  String convertDate() => DateFormat('MMM d, h:mm a').format(dateTime);

}
