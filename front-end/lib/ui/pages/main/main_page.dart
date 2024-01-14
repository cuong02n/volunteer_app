import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  final List<Widget> pages;
  final StatefulNavigationShell navigationShell;

  const MainPage(
      {super.key, required this.pages, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with
        TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _controller;

  final _items = [
    const NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
    const NavigationDestination(icon: Icon(Icons.notifications), label: "Thông báo"),
    const NavigationDestination(icon: Icon(Icons.tab), label: "Fanpage"),
    const NavigationDestination(icon: Icon(Icons.account_circle), label: "Cá nhân"),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.pages.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _switchTab,
        destinations: _items,
      ),
      body: TabBarView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.pages,
      ),
    );
  }

  void _switchTab(int index) {
    setState(() {
      widget.navigationShell.goBranch(index, initialLocation: false);
      _controller.animateTo(index);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
