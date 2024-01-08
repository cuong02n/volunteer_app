import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/entity/criteria_event.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/repositories/server/event_provider.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/avatar.dart';
import 'package:thien_nguyen_app/ui/widgets/background_image.dart';
import 'package:thien_nguyen_app/ui/widgets/status_widget.dart';
import 'package:thien_nguyen_app/utilities/bloc/event_list_bloc.dart';

part 'child_page_body.dart';

part 'child_page_status_list.dart';

class ChildPagePage extends StatelessWidget {
  final int id;
  final EventListBloc _bloc = EventListBloc(null);

  ChildPagePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      lazy: false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.white10,
          ),
          extendBodyBehindAppBar: true,
          body: FutureBuilder(
              future: FanpageServerRepository.getFanpage(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: [
                        ChildPageBody(fanpage: snapshot.requireData),
                        FutureBuilder(
                          future: EventServerRepository.getEvents(EventCriteria(fanpageId: id)),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _bloc.emit(snapshot.requireData);
                              return ChildPageStatusList();
                            } else {
                              return const SizedBox();
                            }
                          }
                        )
                      ],
                    );
                } else if (snapshot.hasError)
                  return Center(
                    child: Icon(Icons.report),
                  );
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              })),
    );
  }
}
