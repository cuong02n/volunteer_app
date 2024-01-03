part of 'otp_page.dart';

class OtpBody extends StatelessWidget {
  const OtpBody({super.key});

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
                Text("Xác thực OTP",
                    style: AppTypology.titleMedium
                        .copyWith(color: context.appTheme.primaryColor)),
                Container(
                  height: 10,
                  width: 60.w,
                  decoration:
                  const BoxDecoration(border: Border(top: BorderSide())),
                ),
                OtpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late final OtpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OtpController(context);
    _controller.init();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller.otpController,
            focusNode: _controller.otpNode,
            onTap: () => _controller.otpNode.requestFocus(),
            onTapOutside: (_) => _controller.otpNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            obscureText: !_controller.isShowOtp,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon((_controller.isShowOtp)? Icons.visibility_off: Icons.visibility),
                    onPressed: _controller.setOtpShow),
               ),
          ),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _controller.confirmOtp,
              child: Center(
                child: Text("Xác nhận"),
              ))
        ],
      ),
    );
  }

}
