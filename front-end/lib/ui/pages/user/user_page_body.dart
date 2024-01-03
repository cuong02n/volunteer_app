part of 'user_page.dart';

class UserPageBody extends StatelessWidget {
  final double _backgroundHeight = 30.h;
  final double _avatarRadius = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            BackgroundImage(),
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
        Text("Tên Fangage",
                style: AppTypology.titleLarge
        )
      ],
    );
  }

}