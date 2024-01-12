part of 'new_event_page.dart';

class NewEventBody extends StatelessWidget {
  const NewEventBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 10,
            offset: const Offset(5, 5),
          )
        ]),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Tạo sự kiện", style: AppTypology.titleMedium),
                Container(
                  height: 10,
                  width: 40.w,
                  decoration:
                      const BoxDecoration(border: Border(top: BorderSide())),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80.h),
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: SingleChildScrollView(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: NewEventForm(),
                        )))),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
