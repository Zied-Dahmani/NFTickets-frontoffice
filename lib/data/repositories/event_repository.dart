import 'package:nftickets/data/models/event_model.dart';
import 'package:nftickets/data/providers/event_data_provider.dart';
import 'package:nftickets/data/repositories/event_repository_interface.dart';

class EventRepository implements IEventRepository {
  final EventDataProvider _eventDataProvider = EventDataProvider();

  @override
  Future<dynamic> getUpcomingEvents() async {
    final result = await _eventDataProvider.getUpcomingEvents();
    return result.statusCode == 200
        ? result.data.map((event) => Event.fromJson(event)).toList()
        : null;
  }
}
