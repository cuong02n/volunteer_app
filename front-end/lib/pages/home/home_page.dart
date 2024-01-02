import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/pages/home/page_detail.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/status_widget.dart';

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
              Container(
                height: 65,
                color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: SizedBox(
                        width: 70,
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 45,
                            ),
                            Text('User $index')
                          ],
                        ),
                      ),
                    );
                  },
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
