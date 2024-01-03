part of 'child_page.dart';

class ChildPageStatusList extends StatefulWidget {
  const ChildPageStatusList({super.key});

  @override
  State<ChildPageStatusList> createState() => _ChildPageStatusListState();
}

class _ChildPageStatusListState extends State<ChildPageStatusList> {
  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
        initialItemCount: 10,
        itemBuilder: (context, index, animation) => StatusWidget()
    );
  }
}