part of 'user_page.dart';

class UserPageStatusList extends StatefulWidget {
  const UserPageStatusList({super.key});

  @override
  State<UserPageStatusList> createState() => _UserPageStatusListState();
}

class _UserPageStatusListState extends State<UserPageStatusList> {
  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
        initialItemCount: 10,
        itemBuilder: (context, index, animation) => StatusWidget()
    );
  }
}