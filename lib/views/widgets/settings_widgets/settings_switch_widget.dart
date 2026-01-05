import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data/app_themes.dart';

import '../../data/app_text_styles.dart';
import '../../data_classes/settings/settings_switch_data.dart';

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
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppThemes.darkThemeColors.cardsColor,
        border: BoxBorder.all(
          color: AppThemes.darkThemeColors.dividerColor,
          width: 0.5,
        ),
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
                          child: Text(
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
                              child: Text(
                                widget.data.label,
                                style:
                                    AppTextStyles.settingsCardsButtonsTextStyle,
                              ),
                            ),

                            if (widget.data.helpText != null)
                              Padding(
                                padding: EdgeInsetsGeometry.only(left: 12),
                                child: Text(
                                  widget.data.helpText!,
                                  style: AppTextStyles.hintTextStyle,
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
                  Container(
                    height: 0.5,
                    color: AppThemes.darkThemeColors.dividerColor,
                  ),
              ],
            ),
          ),

          CupertinoSwitch(
            value: isOn,
            onChanged: (bool value) {
              setState(() {
                isOn = value;
              });

              widget.data.onChanged?.call(value);
            },
          ),
        ],
      ),
    );
  }
}
