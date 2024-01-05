part of 'child_page.dart';

class ChildPageBody extends StatelessWidget {
  final double _backgroundHeight = 30.h;
  final double _avatarRadius = 100;

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
                text: "Tên Fangage",
                style: AppTypology.titleLarge
              ),
              WidgetSpan(child: Icon(
            Icons.check_circle,
            color: context.appTheme.primaryColor,
          ))
            ]
          )
        ),
        Text("Admin: User"),
        Container(
          height: 20,
          width: 60.w,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide())
          ),
        ),
        Center(child: Text("Giới thiệu tổ chức")),
        SizedBox(height: 20),
        Text("Bài đăng", style: AppTypology.titleSmall),
      ],
    );
  }

  void _takeBackgroundPhoto() {
  }
}