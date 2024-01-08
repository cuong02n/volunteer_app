part of 'child_page.dart';

class ChildPageStatusList extends StatefulWidget {
  const ChildPageStatusList({super.key});

  @override
  State<ChildPageStatusList> createState() => _ChildPageStatusListState();
}

class _ChildPageStatusListState extends State<ChildPageStatusList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) => setState(() {}),
      bloc: context.read<EventListBloc>(),
      builder: (context, List<Event> state) {
        return ListView(
            shrinkWrap: true,
            children: state.map((e) => EventWidget(event: e)).toList());
      }
    );
  }
}