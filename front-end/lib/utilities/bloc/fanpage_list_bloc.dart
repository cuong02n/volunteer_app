import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FanpageListBloc extends Cubit<List<Fanpage>> {
  FanpageListBloc(List<Fanpage>? list) : super(list ?? []);

  void addFanpage(Fanpage fanpage) {
    state.add(fanpage);
    super.emit([...state]);
  }

  void removeFanpage(Fanpage fanpage) {
    state.remove(fanpage);
    super.emit([...state]);
  }

  void editFanpage(Fanpage fanpage) {
    try {
      state[state.indexWhere((element) => element.id == fanpage.id)] = fanpage;
      super.emit([...state]);
    }
    finally {

    }
  }
}