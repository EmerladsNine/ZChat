import 'package:flutter/material.dart';
import 'package:zchat/enums/message_bubble_color.dart';
import 'package:zchat/themes_system/theme_color_scheme.dart';
import 'package:zchat/themes_system/theme_controller.dart';
import 'package:zchat/views/data/app_message_bubble_colors.dart';
import 'package:zchat/views/widgets/buttons/ripple_effect_button_widget.dart';
import '../../../themes_system/app_theme.dart';
import '../../data/app_notifiers.dart';
import 'base_settings_page.dart';

class MessageBubbleColorPage extends StatelessWidget {
  const MessageBubbleColorPage({super.key, required this.isSent});

  final bool isSent;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = AppTheme.controllerOf(context);
    final ThemeColorScheme colors = themeController.colors;
    final List<MessageBubbleColor> messageBubbleColors =
        themeController.messageBubbleColors;

    return BaseSettingsPage(
      title: isSent ? 'Sent' : 'Received',
      pageContent: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 25,
              childAspectRatio: 1,
            ),
            itemCount: AppMessageBubbleColors.palette.length,
            itemBuilder: (context, index) {
              bool isSelected =
                  messageBubbleColors[isSent ? 0 : 1] ==
                  MessageBubbleColor.values[index];

              return RippleEffectButtonWidget(
                disableSet: AppNotifiers.disableButtons,
                animationDuration: Duration(milliseconds: 50),
                appStateNotifier: AppNotifiers.isNavigating,
                overlayCircularRadius: 100,
                onTap: () => themeController.setMessageBubblesColor(
                  MessageBubbleColor.values[index],
                  isSent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppMessageBubbleColors.get(
                      MessageBubbleColor.values[index],
                      themeController.isDarkMode,
                    ),
                    border: isSelected
                        ? Border.all(
                            color: colors.selectedMessageBubbleColor,
                            width: 3,
                          )
                        : null,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
