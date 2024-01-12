import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListBloc extends Cubit<List<Event>> {
  final Stream<List<Event>>? getEvents;
  EventListBloc(List<Event>? list, {this.getEvents}) : super(list ?? []);

  @override
  void emit(List<Event> state) {
    super.emit([...state]);
  }

  void addEvent(Event event) {
    state.add(event);
    super.emit([...state]);
  }

  void removeEvent(Event event) {
    state.remove(event);
    super.emit([...state]);
  }

  void editEvent(Event event) {
    try {
      state[state.indexWhere((element) => element.id == event.id)] = event;
      super.emit([...state]);
    }
    finally {

    }
  }
}