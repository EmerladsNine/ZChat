import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class NotificationPermissionBanner extends StatelessWidget {
  const NotificationPermissionBanner({super.key, required this.showPermissionBanner});

  final ValueNotifier<bool> showPermissionBanner;
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: colors.cardsColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(Icons.notification_add),
            Expanded(
              child: Text(
                "Enable notifications to never miss messages",
                style: TextStyle(
                  color: colors.primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final settings =
                await FirebaseMessaging.instance.requestPermission();

                if (settings.authorizationStatus ==
                    AuthorizationStatus.authorized) {
                  showPermissionBanner.value = false;
                }
              },
              child: Text("Enable",style: TextStyle(color: colors.brandPrimaryColor),),
            )
          ],
        ),
      );
  }
}
