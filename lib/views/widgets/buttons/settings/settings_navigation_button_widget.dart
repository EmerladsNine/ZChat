import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';

import '../../../data_classes/settings/settings_navigation_button_data.dart';

class SettingsNavigationButtonWidget extends SettingsBaseButtonWidget {
  const SettingsNavigationButtonWidget({
    super.key,
    super.drawBorder = true,
    required SettingsNavigationButtonData data,
  }) : super(data: data);

  @override
  void onTap(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return (data as SettingsNavigationButtonData).goToPage;
        },
      ),
    );
  }
}
