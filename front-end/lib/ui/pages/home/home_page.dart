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
            IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle))
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
                height: 80,
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
                height: 250,
                color: Colors.amber,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageDetail(
                                fanpageName:
                                    'Fanpage Name', // Truyền dữ liệu từ bài đăng được chọn (nếu cần)
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              Stack(alignment: Alignment.bottomLeft, children: [
                                Container(
                                  height: 100,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.background),
                                        fit: BoxFit.fitWidth,
                                      )),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.account_circle),
                                    Text(
                                      'Fanpage Name',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Icon(Icons.check_circle,
                                        color: context.appTheme.primaryColor,
                                        size: 16)
                                  ],
                                ),
                              ]),
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(10)),
                                    color: AppColor.lightGrey),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Tên chiến dịch",
                                          style: TextStyle(fontSize: 10)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Đã đạt được ',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                TextSpan(
                                                    text: '10.000',
                                                    style: AppTypology
                                                        .labelMedium
                                                        .copyWith(
                                                            color: context
                                                                .appTheme
                                                                .primaryColor)),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "34%",
                                            style: AppTypology.labelSmall,
                                          )
                                        ],
                                      ),
                                      LinearProgressIndicator(
                                        value: 0.34,
                                        backgroundColor: context
                                            .appTheme.colorScheme.onPrimary,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                context.appTheme.primaryColor),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Tham gia",
                                                style: TextStyle(fontSize: 10),
                                              )),
                                          OutlinedButton(
                                              onPressed: () {},
                                              child: Text("Ủng hộ",
                                                  style:
                                                      TextStyle(fontSize: 10)))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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
