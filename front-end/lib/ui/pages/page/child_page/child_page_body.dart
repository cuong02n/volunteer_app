part of 'child_page.dart';

class ChildPageBody extends StatelessWidget {
  final double _backgroundHeight = 30.h;
  final double _avatarRadius = 100;
  final Fanpage fanpage;

  ChildPageBody({super.key, required this.fanpage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            //BackgroundImage(),
            Center(
              child: Column(
                children: [
                  SizedBox(height: _backgroundHeight - _avatarRadius),
                  Avatar(
                    width: _avatarRadius * 2,
                    height: _avatarRadius * 2,
                  ),
                  SizedBox(height: 15,)
                ],
              ),
            )
          ],
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: fanpage.fanpageName ?? "Fanpage không có tên",
                style: AppTypology.titleLarge
              ),
              WidgetSpan(child: Icon(
            Icons.check_circle,
            color: context.appTheme.primaryColor,
          ))
            ].sublist(0, (fanpage.status == FanpageStatus.VERIFIED) ? 2: 1)
          )
        ),
        FutureBuilder(
          future: UserServerRepository.getUser(fanpage.leaderId!),
          builder: (context, snapshot) {
            return Text("Admin: ${(snapshot.hasData) ? snapshot.requireData.name ?? "Không xác định": ""}");
          }
        ),
        Container(
          height: 20,
          width: 60.w,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide())
          ),
        ),
        Center(child: Text("Giới thiệu tổ chức")),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text("Không có mô tả"),
        ),
        SizedBox(height: 20),
        Text("Bài đăng", style: AppTypology.titleSmall),
        (fanpage.leaderId == CurrentInfo.user?.id)? Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
          child: FilledButton(onPressed: _createEvent(context), child: Center(child: Text("Tạo chiến dịch mới"),)),
        ) : const SizedBox()
      ],
    );
  }

  VoidCallback _createEvent(BuildContext context) {
    return () async {
      Event? event = await context.pushNamed(RouteName.newEvent, pathParameters: {'pageID': fanpage.id.toString()});
      if (event != null && context.mounted) {context.read<EventListBloc>().addEvent(event);}
    };
  }
}