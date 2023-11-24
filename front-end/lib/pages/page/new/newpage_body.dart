part of 'newpage_page.dart';

class NewPageBody extends StatelessWidget {
  const NewPageBody({super.key});

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
                Text("Tạo fanpage",
                    style: AppTypology.titleMedium),
                Container(
                  height: 10,
                  width: 40.w,
                  decoration:
                      const BoxDecoration(border: Border(top: BorderSide())),
                ),
                NewPageForm(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
