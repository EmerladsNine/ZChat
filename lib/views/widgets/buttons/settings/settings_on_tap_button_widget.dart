import 'package:zchat/views/widgets/buttons/settings/settings_base_button_widget.dart';

import '../../../data_classes/settings/settings_on_tap_button_data.dart';

class SettingsOnTapButtonWidget extends SettingsBaseButtonWidget {
  const SettingsOnTapButtonWidget({
    super.key,
    required super.drawBorder,
    required SettingsOnTapButtonData data,
  }) : super(data: data);

  @override
  void onTap(context) {
    (data as SettingsOnTapButtonData).onTap();
  }
}
