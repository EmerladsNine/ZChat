import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class SignInPageButton extends StatelessWidget {
  const SignInPageButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final void Function() onTap;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
      onTap: onTap,
      disableSet: AppNotifiers.disableButtons,
      appStateNotifier: AppNotifiers.isNavigating,
      child: Container(
        height: 54,
        width: 240,
        padding: EdgeInsetsGeometry.symmetric(vertical: 13, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color.fromARGB(0xff, 0x8E, 0x91, 0x8F),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            icon,
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
                color: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
