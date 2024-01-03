import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

class NavigationButton extends StatelessWidget {
  final Widget? icon;
  final String title;
  final void Function()? onPressed;
  final Widget? extra;

  const NavigationButton(
      {super.key, this.icon, required this.title, this.onPressed, this.extra});

  Widget get action {
    List<Widget> list = extra == null ? [] : [extra!];
    return Row(
      children: list + [Icon(Icons.arrow_forward_ios)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          icon != null
              ? Padding(padding: const EdgeInsets.only(right: 10), child: icon)
              : const SizedBox(),
          Expanded(
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(title), action],
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: context.appTheme.colorScheme.secondary,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
