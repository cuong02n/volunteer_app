import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/user_avatar.dart';

import '../../models/entity/fanpage.dart';
import '../pages/home/page_detail.dart';

class EventWidget extends StatefulWidget {
  final Event? event;
  final double? width;
  final bool isCollapsed;

  const EventWidget(
      {super.key, this.width, this.isCollapsed = false, this.event});

  @override
  State<EventWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<EventWidget> {
  double get _width => widget.width ?? 100.w;

  double get _process {
    if (widget.event?.progress != null && widget.event?.target != null) {
      return widget.event!.progress! / widget.event!.target!;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCollapsed == false) {
      return FutureBuilder(
          future: FanpageServerRepository.getFanpage(widget.event!.fanpageId!),
          builder: (context, snapshot) {
            Fanpage? fanpage;
            if (snapshot.hasData) fanpage = snapshot.requireData;
            List<InlineSpan> name = [
              TextSpan(
                text: fanpage?.fanpageName ?? 'User name',
                style: AppTypology.titleMedium,
              ),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Icon(Icons.check_circle,
                    color: context.appTheme.primaryColor, size: 16),
              )),
            ].sublist(0, (fanpage?.status == FanpageStatus.VERIFIED) ? 2 : 1);
            return GestureDetector(
              onTap: () => context.push('/event/${widget.event!.id!}', extra: widget.event!),
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(0.02 * _width, 10, 0.02 * _width, 10),
                width: _width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 2.0),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                AssetImage(AppImages.defaultUserAvatar),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              ...name,
                              const TextSpan(
                                  text: ' đang kêu gọi ủng hộ',
                                  style: AppTypology.bodyMedium),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 160,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage(AppImages.background),
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                    Container(
                      height: 120,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                          color: AppColor.lightGrey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.event?.title ?? "Tên chiến dịch",
                                style: AppTypology.titleMedium),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Đã đạt được ',
                                        style: AppTypology.titleMedium,
                                      ),
                                      TextSpan(
                                          text:
                                              '${NumberFormat.compact().format(widget.event?.progress ?? 0)} VNĐ',
                                          style: AppTypology.labelMedium
                                              .copyWith(
                                                  color: context
                                                      .appTheme.primaryColor)),
                                    ],
                                  ),
                                ),
                                Text(
                                  NumberFormat.percentPattern()
                                      .format(_process),
                                  style: AppTypology.labelSmall,
                                )
                              ],
                            ),
                            LinearProgressIndicator(
                              value: _process,
                              backgroundColor:
                                  context.appTheme.colorScheme.onPrimary,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  context.appTheme.primaryColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                    onPressed: _join,
                                    child: const Text("Tham gia")),
                                OutlinedButton(
                                    onPressed: _donate,
                                    child: const Text("Ủng hộ"))
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
          });
    } else {
      return FutureBuilder(
          future: FanpageServerRepository.getFanpage(widget.event!.fanpageId!),
          builder: (context, snapshot) {
            Fanpage? fanpage;
            if (snapshot.hasData) fanpage = snapshot.requireData;
            List<InlineSpan> name = [
              TextSpan(
                text: fanpage?.fanpageName ?? 'User name',
                style: AppTypology.titleMedium,
              ),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Icon(Icons.check_circle,
                    color: context.appTheme.primaryColor, size: 16),
              )),
            ].sublist(0, (fanpage?.status == FanpageStatus.VERIFIED) ? 2 : 1);
            return GestureDetector(
              onTap: () => context.push('/event/${widget.event!.id!}', extra: widget.event!),
              child: SizedBox(
                width: 250,
                child: Column(
                  children: [
                    Stack(alignment: Alignment.bottomLeft, children: [
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage(AppImages.background),
                              fit: BoxFit.fitWidth,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text.rich(TextSpan(children: name)),
                      )
                    ]),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                          color: AppColor.lightGrey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.event!.title ?? "Chiến dịch",
                                style: TextStyle(fontSize: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Đã đạt được ',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      TextSpan(
                                          text:
                                              "${NumberFormat.compact().format(widget.event?.progress ?? 0)}đ",
                                          style: AppTypology.labelMedium
                                              .copyWith(
                                                  color: context
                                                      .appTheme.primaryColor)),
                                    ],
                                  ),
                                ),
                                Text(
                                  NumberFormat.percentPattern()
                                      .format(_process),
                                  style: AppTypology.labelSmall,
                                )
                              ],
                            ),
                            LinearProgressIndicator(
                              value: _process,
                              backgroundColor:
                                  context.appTheme.colorScheme.onPrimary,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  context.appTheme.primaryColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Tham gia",
                                      style: TextStyle(fontSize: 10),
                                    )),
                                OutlinedButton(
                                    onPressed: _donate,
                                    child: const Text("Ủng hộ",
                                        style: TextStyle(fontSize: 10)))
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
          });
    }
  }

  void _join() {}

  void _donate() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: CachedNetworkImage(
                imageUrl: 'https://img.vietqr.io/image/${widget.event!.bank}-${widget.event!.bankAccount}-compact2.png',
                width: 100,
                height: 100,
                progressIndicatorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())),
          );
        });
  }
}
