part of 'user_page.dart';

class UserPageStatusList extends StatefulWidget {
  final List<Event> events;
  const UserPageStatusList({super.key, required this.events});

  @override
  State<UserPageStatusList> createState() => _UserPageStatusListState();
}

class _UserPageStatusListState extends State<UserPageStatusList> {
  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
        initialItemCount: widget.events.length,
        itemBuilder: (context, index, animation) => EventWidget(event: widget.events[index],)
    );
  }
}