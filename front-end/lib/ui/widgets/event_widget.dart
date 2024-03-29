import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/providers/event_image_provider.dart';

import '../../models/entity/fanpage.dart';

class EventWidget extends StatefulWidget {
  final Event? event;
  final double? width;
  final bool isCollapsed;

  const EventWidget(
      {super.key, this.width, this.isCollapsed = false, this.event});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  double get _width => widget.width ?? 100.w;

  double get _process {
    if (widget.event?.progress != null && widget.event?.target != null) {
      return widget.event!.progress! / widget.event!.target!;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    EventImageProvider provider = EventImageProvider(event: widget.event!);
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
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(10)),
                          image: DecorationImage(
                            image: provider.coverProvider,
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
                                        style: AppTypology.titleSmall,
                                      ),
                                      TextSpan(
                                          text:
                                              '${NumberFormat.decimalPattern().format(widget.event?.progress ?? 0)} VNĐ',
                                          style: AppTypology.labelMedium
                                              .copyWith(
                                                  color: context
                                                      .appTheme.primaryColor)),
                                    ],
                                  ),
                                ),
                                Text(
                                  NumberFormat.decimalPercentPattern(decimalDigits: 1)
                                      .format(widget.event!.process),
                                  style: AppTypology.labelSmall,
                                )
                              ],
                            ),
                            LinearProgressIndicator(
                              value: widget.event!.process,
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
              WidgetSpan(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                    radius: 18,
                    backgroundImage:
                    AssetImage(AppImages.defaultUserAvatar),
                  ),
              ),
              ),
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
            ].sublist(0, (fanpage?.status == FanpageStatus.VERIFIED) ? 3 : 2);
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
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(10)),
                            image: DecorationImage(
                              colorFilter: const ColorFilter.linearToSrgbGamma(),
                              image: provider.coverProvider,
                              fit: BoxFit.fitWidth,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text.rich(TextSpan(children: name, style: AppTypology.titleMedium), softWrap: true,),
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
                                style: AppTypology.titleSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Đã đạt được ',
                                        style: AppTypology.labelSmall,
                                      ),
                                      TextSpan(
                                          text:
                                              "${NumberFormat.decimalPattern().format(widget.event?.progress ?? 0)}đ",
                                          style: AppTypology.labelMedium
                                              .copyWith(
                                                  color: context
                                                      .appTheme.primaryColor)),
                                    ],
                                  ),
                                ),
                                Text(
                                  NumberFormat.decimalPercentPattern(decimalDigits: 1).format(widget.event!.process),
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
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("QR ủng hộ"),
      content: CachedNetworkImage(
        imageUrl: widget.event?.qrCode(CurrentInfo.user!.id!) ?? "",
      ),
      actions: [
        TextButton(onPressed: () {
          context.pop();
          context.pop();
        }, child: const Text("Thoát"))
      ],
    ));
  }
}
