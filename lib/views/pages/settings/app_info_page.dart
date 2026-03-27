import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/app_text_styles.dart';
import 'base_settings_page.dart';
import '../../../themes_system/app_theme.dart';
import '../../widgets/miscellaneous/scaled_text_widget.dart';

const String _appName = 'Zchat';
const String _appVersion = '1.01.2';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);
    return Container(
      color: colors.primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colors.primaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: colors.primaryBackgroundColor,
            elevation: 0,
            title: ScaledTextWidget(
              "App Info",
              style: AppTextStyles.appBarPrimaryTextStyle(colors),
            ),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/background.svg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 8),
                      child: Icon(
                        Icons.bubble_chart_rounded,
                        color: colors.primaryColor,
                        size: 96,
                      ),
                    ),
                    ScaledTextWidget(
                      _appName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: colors.brandPrimaryColor,
                      ),
                    ),
                    ScaledTextWidget(
                      'Version $_appVersion',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: colors.hintColor,
                      ),
                    ),
                    ScaledTextWidget(
                      'Made with ❤️',
                      style: TextStyle(fontSize: 12, color: colors.hintColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
