import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';
import 'package:zchat/views/data/app_notifiers.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key,required this.text,required this.onTap});

  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return RippleEffectButtonWidget(
      appStateNotifier: AppNotifiers.isNavigating,
      disableSet: AppNotifiers.disableButtons,
      overlayBorderRadius: BorderRadius.circular(
        10,
      ),
      onTap:  onTap,
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colors.primaryColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
