import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

typedef Json = Map<String, dynamic>;

class FanpageChoice extends StatelessWidget {
  const FanpageChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5.w),
      height: 180,
      decoration:
          BoxDecoration(
              border: Border.all(color: context.appTheme.colorScheme.secondary),
              borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: context.appTheme.colorScheme.primary,
        ),
        BoxShadow(
          color: context.appTheme.colorScheme.background,
          blurRadius: 4,
          spreadRadius: 0, // changes position of shadow
        ),
      ]),
      child: InkWell(
        onTap: _goToFanpage(context),
        child: Row(
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.fromLTRB(1, 1, 5, 1),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(AppImages.background),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fanpage",
                          style: AppTypology.titleMedium,
                        ),
                        Text(
                          "Admin: Username",
                          style: AppTypology.titleSmall,
                        ),
                        Text(
                          "Follower: 1.3k",
                          style: AppTypology.titleSmall,
                        ),
                        Text(
                          "Giới thiệu:",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: AppTypology.labelLarge.copyWith(
                              color: context.appTheme.colorScheme.secondary),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  VoidCallback _goToFanpage(BuildContext context) {
    return () {
      context.push("/page/123");
    };
  }
}
