import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/navigation_button.dart';
import 'package:thien_nguyen_app/widgets/star_picker.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent, title: Text("Trợ giúp", style: AppTypology.titleSmall,)),
        extendBody: true,
        body: HelpPageBody());
  }
}

class HelpPageBody extends StatelessWidget {
  const HelpPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Image.asset(AppImages.help),
            SizedBox(
              width: 52.w,
              child: const Text(
                "Đánh giá của người dùng giúp chúng tôi không ngừng nâng cao chất lượng.",
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            const StarPicker(color: AppColor.orange),
            NavigationButton(title: "Phản hồi đến nhà phát triển", onPressed: _toDev,),
            NavigationButton(title: "Câu hỏi thường gặp", onPressed: _toDev,),
            NavigationButton(title: "Liên hệ", onPressed: _toDev,),
          ],
        ),
      ),
    );
  }

  void _toDev() {
  }
}
