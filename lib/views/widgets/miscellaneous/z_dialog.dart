import 'package:flutter/material.dart';
import 'package:zchat/themes_system/app_theme.dart';

class ZDialog extends StatelessWidget {
  const ZDialog({super.key,required this.content,this.title = "Failed"});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: colors.cardsColor,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 100, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)
            ),
            child: Text(
                "Okay",
                style: TextStyle(color: colors.primaryColor,fontSize: 18,fontWeight: FontWeight.w900)),
          ),
        ),
      ],
    );
  }
}
