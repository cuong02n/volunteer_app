import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/models/entity/criteria_event.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/repositories/server/event_provider.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/pages/event/event_detail_page.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/event_widget.dart';
import 'package:thien_nguyen_app/ui/widgets/user_avatar.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Thien Nguyen'),
          leading: Image.asset('assets/logo/origin.png'),
          floating: true,
          pinned: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            //IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle))
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tài khoản tích cực',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Xem tất cả'))
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 92,
                child: FutureBuilder(
                    future: UserServerRepository.getAllUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<User> users = snapshot.requireData;
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: InkWell(
                                onTap: () =>
                                    context.push('/user/${users[index].id}'),
                                child: Column(
                                  children: [
                                    UserAvatar.collapsed(
                                      radius: 30,
                                      provider: UserAvatarProvider(
                                          user: users[index]),
                                    ),
                                    Text(
                                      users[index].name ?? "Người dùng",
                                      style: AppTypology.labelSmall,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Icon(Icons.report),
                        );
                      } else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chiến dịch gây quỹ nổi bật',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Xem tất cả'))
                  ],
                ),
              ),
              FutureBuilder(
                  future: EventServerRepository.getAllEventByPriority(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Event> events = snapshot.requireData;
                      return SizedBox(
                        width: double.infinity,
                        height: 220,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: events.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return EventWidget(
                                  isCollapsed: true,
                                  event: events[index],
                                );
                              }
                        ),
                      );
                    } else if (!snapshot.hasError){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else {
                      print(snapshot.error);
                      return SizedBox();
                    }
                  }),
            ],
          ),
        ),
        FutureBuilder(
          future: EventServerRepository.getEvents(EventCriteria()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverAnimatedList(
                initialItemCount: snapshot.requireData.length,
                itemBuilder: (context, index, animation) => EventWidget(event: snapshot.requireData[index]));
            }
            else if (snapshot.hasError) {
              return SliverToBoxAdapter(child: Icon(Icons.error));
            }
            else return SliverToBoxAdapter();
          }
        )
      ],
    );
  }
}
