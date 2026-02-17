import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';
import 'package:zchat/views/widgets/miscellaneous/sliding_animation_page_route.dart';

import '../../../data_classes/pages/settings/settings_navigation_button_data.dart';

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
      SlidingAnimationPageRoute(page: (data as SettingsNavigationButtonData).goToPage)
    );
  }
}
