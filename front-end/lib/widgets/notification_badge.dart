import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/theme/theme.dart';

class NotificationBadge extends StatelessWidget {
  final Widget avatar;
  final String content;

  const NotificationBadge({super.key, required this.avatar, required this.content});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      constraints: const BoxConstraints(minHeight: 88),
      color: AppColor.lightGrey,
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 5,),
          Expanded(child: Text(
            content,
            softWrap: true,
            textAlign: TextAlign.justify,
          ))
        ],
      ),
    );
  }
}