import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

import '../pages/home/page_detail.dart';

class StatusWidget extends StatefulWidget {
  final double? width;
  final bool isCollapsed;

  const StatusWidget({super.key, this.width, this.isCollapsed = false});

  @override
  State<StatusWidget> createState() {
    if (isCollapsed) {
      return _StatusWidgetCollapseState();
    } else {
      return _StatusWidgetExpandedState();
    }
  }
}

class _StatusWidgetExpandedState extends State<StatusWidget> {
  double get _width => widget.width ?? 100.w;

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {},
        child: Container(
        margin: EdgeInsets.fromLTRB(0.02 * _width, 10, 0.02 * _width, 10),
        width: _width,
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 2.0),
                  child: CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.account_circle),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'User name',
                        style: AppTypology.titleMedium,
                      ),
                      WidgetSpan(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Icon(Icons.check_circle,
                          color: context.appTheme.primaryColor, size: 16),
                      )),
                      const TextSpan(
                          text: 'đang kêu gọi ủng hộ',
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(AppImages.background),
                    fit: BoxFit.fitWidth,
                  )
              ),
            ),
            Container(
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10)),
                  color: AppColor.lightGrey
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tên chiến dịch", style: AppTypology.titleMedium),
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
                                  text: '10.000.000 VNĐ',
                                  style: AppTypology.labelMedium.copyWith(color: context.appTheme.primaryColor)),
                            ],
                          ),
                        ),
                        const Text("34%", style: AppTypology.labelSmall,)
                      ],
                    ),
                    LinearProgressIndicator(
                      value: 0.34,
                      backgroundColor: context.appTheme.colorScheme.onPrimary,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          context.appTheme.primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                            onPressed: _join, child: const Text("Tham gia")),
                        OutlinedButton(
                            onPressed: _donate, child: const Text("Ủng hộ"))
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
  }

  void _join() {
  }

  void _donate() {
  }
}

class _StatusWidgetCollapseState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PageDetail(
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
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(AppImages.background),
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Row(
                children: [
                  const Icon(Icons.account_circle),
                  const Text(
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
              decoration: const BoxDecoration(
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
                    const Text("Tên chiến dịch",
                        style: TextStyle(fontSize: 10)),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
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
                        const Text(
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
                            child: const Text(
                              "Tham gia",
                              style: TextStyle(fontSize: 10),
                            )),
                        OutlinedButton(
                            onPressed: () {},
                            child: const Text("Ủng hộ",
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
  }
}