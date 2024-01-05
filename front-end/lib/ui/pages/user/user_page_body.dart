part of 'user_page.dart';

class UserPageBody extends StatefulWidget {
  final int id;
  const UserPageBody({super.key, required this.id});

  @override
  State<UserPageBody> createState() => _UserPageBodyState();
}

class _UserPageBodyState extends State<UserPageBody> {
  final double _backgroundHeight = 30.h;

  final double _avatarRadius = 100;

  late final Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = UserServerRepository.getUser(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.requireData;
          IUserAvatar avatarProvider = UserAvatarProvider(user: user);
          IUserCover coverProvider = UserCoverProvider(user: user);
          return Column(
        children: [
          Stack(
            children: [
              BackgroundImage(
                provider: coverProvider,
                canEdit: user.id == CurrentInfo.user?.id,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: _backgroundHeight - _avatarRadius),
                    UserAvatar.collapsed(provider: avatarProvider, radius: _avatarRadius, canEdit: user.id == CurrentInfo.user?.id,),
                    SizedBox(height: 15,)
                  ],
                ),
              )
            ],
          ),
          Text(user.name!,
                  style: AppTypology.titleLarge
          )
        ],
      );
        }
        else if (snapshot.hasError) {
          return const Column(
            children: [
              Icon(Icons.report),
              Center(child: Text("Không thể truy cập vào lúc này"),)
            ],
          );
        }
        else return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}