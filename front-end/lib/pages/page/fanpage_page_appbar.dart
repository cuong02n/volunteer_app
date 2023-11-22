part of 'fanpage_page.dart';

class FanpagePageAppBar extends SliverAppBar {
  FanpagePageAppBar({super.key})
      : super(
          pinned: true,
          title: Builder(builder: (context) {
            return Container(
              padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: context.appTheme.primaryColor, width: 1))),
              child: const Text(
                'Trang của bạn',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            );
          }),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FilledButton(
                      onPressed: _newPage(context),
                      child: Container(
                        width: 90.w,
                        alignment: Alignment.center,
                        child: const Text(
                          "Tạo Fanpage",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                );
              }
            ),
          ),
        );

  static VoidCallback _newPage(BuildContext context) {
    return () {

    };
  }
}
