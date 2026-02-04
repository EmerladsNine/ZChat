import 'package:flutter/cupertino.dart';

import '../miscellaneous/scaled_text_widget.dart';
import '../../../themes_system/app_theme.dart';
import '../../data/app_text_styles.dart';
import '../../data_classes/pages/settings/settings_switch_data.dart';

class SettingsSwitchWidget extends StatefulWidget {
  const SettingsSwitchWidget({
    super.key,
    required this.data,
    this.drawBorder = true,
  });

  final SettingsSwitchData data;
  final bool drawBorder;

  @override
  State<SettingsSwitchWidget> createState() {
    return SettingsSwitchWidgetState();
  }
}

class SettingsSwitchWidgetState extends State<SettingsSwitchWidget> {
  late final ValueNotifier<bool> isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.data.value ?? ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    if (widget.data.value == null) {
      isOn.dispose(); // prevent memory leak
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.cardsColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.data.icon != null)
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: ScaledTextWidget(
                            widget.data.icon!,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                left: 8,
                                bottom: 3,
                                top: 3,
                              ),
                              child: ScaledTextWidget(
                                widget.data.label,
                                style:
                                    AppTextStyles.settingsCardsButtonsTextStyle(
                                      colors,
                                    ),
                              ),
                            ),

                            if (widget.data.helpText != null)
                              Padding(
                                padding: EdgeInsetsGeometry.only(left: 12),
                                child: ScaledTextWidget(
                                  widget.data.helpText!,
                                  style: AppTextStyles.hintTextStyle(colors),
                                  maxLines: 3,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (widget.drawBorder)
                  Container(height: 0.5, color: colors.dividerColor),
              ],
            ),
          ),

          CupertinoSwitch(
            value: isOn.value,
            onChanged: (bool value) {
              setState(() {
                isOn.value = value;
              });

              widget.data.onChanged?.call(value);
            },
          ),
        ],
      ),
    );
  }
}
