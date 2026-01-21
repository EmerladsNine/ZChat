import 'package:flutter/material.dart';

import '../../../themes_system/app_theme.dart';

class CameraButtonWidget extends StatelessWidget {
  const CameraButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.camera_alt_outlined,
          color: colors.primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
