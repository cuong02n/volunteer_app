part of 'newpage_page.dart';

class NewPageBody extends StatelessWidget {
  final Fanpage? fanpage;
  const NewPageBody({super.key, this.fanpage});

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
                Text(fanpage != null ? "Sửa fanpage": "Tạo fanpage", style: AppTypology.titleMedium),
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
                          child: NewPageForm(fanpage: fanpage),
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
