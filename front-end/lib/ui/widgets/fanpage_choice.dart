import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/providers/fanpage_image_provider.dart';

typedef Json = Map<String, dynamic>;

class FanpageChoice extends StatelessWidget {
  late final FanpageImageProvider provider;
  final Fanpage fanpage;
  final bool canDelete;
  final VoidCallback? delete;
  FanpageChoice({super.key, required this.fanpage, this.canDelete = true, this.delete});

  @override
  Widget build(BuildContext context) {
    provider = FanpageImageProvider(fanpage: fanpage);
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
      child: Stack(
        children: [
          InkWell(
            onTap: _goToFanpage(context),
            child: Row(
              children: [
                Container(
                  width: 120,
                  padding: const EdgeInsets.fromLTRB(1, 1, 5, 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                    image: DecorationImage(
                      image: provider.coverProvider,
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
                              fanpage.fanpageName ?? "Fanpage không có tên",
                              style: AppTypology.titleMedium,
                            ),
                            FutureBuilder(
                              future: UserServerRepository.getUser(fanpage.leaderId!),
                              builder: (context,snapshot) {
                                String name = "";
                                if (snapshot.hasData) name = snapshot.requireData.name ?? "Người dùng mới";
                                return Text(
                                  "Admin: $name",
                                  style: AppTypology.titleSmall,
                                );
                              }
                            ),
                            Text(
                              "Follower: ${fanpage.subscriber ?? 0}",
                              style: AppTypology.titleSmall,
                            ),
                            Text(
                              "Giới thiệu: ",
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
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: delete,
              icon: Icon(Icons.delete, color: Colors.redAccent,),
            ),
          )
        ].sublist(0, (canDelete)? 2: 1),
      ),
    );
  }

  VoidCallback _goToFanpage(BuildContext context) {
    return () async {
      await context.push("/page/${fanpage.id!}");
    };
  }
}
