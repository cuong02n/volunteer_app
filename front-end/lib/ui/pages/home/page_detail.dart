import 'package:flutter/material.dart';

import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

class PageDetail extends StatelessWidget {
  final String fanpageName;
  const PageDetail({super.key, required this.fanpageName});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            // title: Text(fanpageName),
            background: Image.asset(
              AppImages.background,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mode_standby,
                            size: 30.0, color: Colors.green),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mục tiêu chiến dịch',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text('100,000 VNĐ',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    // Row con thứ hai
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Thời gian còn lại',
                                style: TextStyle(fontSize: 10)),
                            Text('1 ngày',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight
                                        .bold)), // Thay đổi với thời gian còn lại thực tế
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fanpageName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Địa chỉ')
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tạo bởi'),
                          TextButton(
                            onPressed: () {},
                            child: Text(fanpageName),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Đã đạt được ',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    TextSpan(
                                        text: '10.000',
                                        style: AppTypology.labelMedium.copyWith(
                                            color:
                                                context.appTheme.primaryColor)),
                                  ],
                                ),
                              ),
                              Text(
                                "34%",
                                style: AppTypology.labelSmall,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          LinearProgressIndicator(
                            value: 0.34,
                            backgroundColor:
                                context.appTheme.colorScheme.onPrimary,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                context.appTheme.primaryColor),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      style: TextStyle(fontSize: 10)))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Câu chuyện',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Very long Text Vekkkkkkkkkkkkkkkkkkkkkkkk Vekkkkkkkkkkkkkkkkkkkkkkkk Vekkkkkkkkkkkkkkkkkkkkkkkk Vekkkkkkkkkkkkkkkkkkkkkkkk')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Ảnh: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Image.asset('assets/images/cute_meos.jpg')
              ],
            ),
          ),
        )
      ],
    );
  }
}
