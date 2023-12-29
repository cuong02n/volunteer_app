import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/notification_badge.dart';

typedef Json = Map<String, dynamic>;

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  List<Json> notifications = [
    for (int i = 0; i < 1000; i++)
      {
        'avatar': null,
        'content':
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit e ante et just"
                .substring(0, Random().nextInt(70))
      }
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            "Thông báo",
            style: TextStyle(color: context.appTheme.primaryColor),
          ),
          pinned: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: context.appTheme.primaryColor,
              height: 1,
              width: double.infinity,
            ),
          )
        ),
        SliverAnimatedList(
          initialItemCount: notifications.length,
          itemBuilder: (context, index, animation) {
            final avatar = notifications[index]['avatar'];
            final content = notifications[index]['content'];
            return Dismissible(
              key: GlobalKey(),
              child: NotificationBadge(
                avatar: Icon(Icons.account_circle, size: 10.w),
                content: content,
              ),
            );
          },
        )
      ],
    );
  }
}
