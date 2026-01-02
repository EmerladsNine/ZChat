import 'package:flutter/material.dart';
import 'package:zchat/views/data_classes/settings/settings_base_dialog_button_data.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';

import '../../../data/colors.dart';
import '../../../data/notifiers.dart';
import '../../../data/text_styles.dart';

abstract class SettingsBaseDialogButtonWidget<T> extends StatefulWidget {
  const SettingsBaseDialogButtonWidget({
    super.key,
    required this.data,
    required this.drawBorder,
  });

  final SettingsBaseDialogButtonData data;
  final bool drawBorder;

  Widget buildDialog(BuildContext context);

  @override
  State<SettingsBaseDialogButtonWidget<T>> createState() {
    return SettingsBaseDialogButtonWidgetState();
  }
}

class SettingsBaseDialogButtonWidgetState<T>
    extends State<SettingsBaseDialogButtonWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return RippleEffectButtonWidget(
      disableSet: disableSettingsPageButtons,
      appStateNotifier: isNavigating,
      onTap: () async {
        await showDialog<T>(
          context: context,
          builder: (_) {
            return widget.buildDialog(context);
          },
        );
      },
      child: Container(
        color: cardsColor,
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
                      child: Text(widget.data.icon!),
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
                            style: settingsCardsButtonsTextStyle,
                          ),
                        ),

                        if (widget.data.helpText != null)
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 12),
                            child: Text(
                              widget.data.helpText!,
                              style: hintTextStyle,
                              maxLines: 3,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (widget.drawBorder) Container(height: 0.5, color: dividerColor),
          ],
        ),
      ),
    );
  }
}
