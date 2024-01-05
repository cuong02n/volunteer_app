import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/pages/home/page_detail.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/status_widget.dart';
import 'package:thien_nguyen_app/ui/widgets/user_avatar.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tài khoản tích cực',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Xem tất cả'))
                ],
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
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () => context.push('/user/${users[index].id}'),
                                child: Column(
                                  children: [
                                    UserAvatar.collapsed(
                                      radius: 30,
                                      provider: UserAvatarProvider(user: users[index]),
                                    ),
                                    Text(users[index].name ?? "Người dùng", style: AppTypology.labelSmall,)
                                  ],
                                ),
                          ),
                        );
                      },
                    );
                    }
                    else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.report),);
                    }
                    else return Center(child: CircularProgressIndicator(),);
                  }
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chiến dịch gây quỹ nổi bật',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: Text('Xem tất cả'))
                ],
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const StatusWidget(isCollapsed: true,);
                    }),
              ),
            ],
          ),
        ),
        SliverAnimatedList(
            initialItemCount: 15,
            itemBuilder: (context, index, animation) => StatusWidget())
      ],
    );
  }
}

// Widget _buildAccount(String accountName) {
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 8.0),
//     child: Column(children: [
//       Icon(Icons.account_circle),
//       SizedBox(
//         height: 8.0,
//       ),
//       Text(accountName)
//     ]),
//   );
// }
