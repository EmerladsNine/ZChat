import 'package:flutter/material.dart';
import 'package:zchat/views/data/text_styles.dart';
import 'package:zchat/views/widgets/settings_widgets/profile_info_card_widget.dart';

import '../../data/colors.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryBackgroundColor,
          elevation: 0,
          title: Text('Profile', style: appBarPrimaryTextStyle),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsetsGeometry.all(15),
              margin: EdgeInsetsGeometry.only(top: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10,
              ),
              child: Icon(Icons.person, color: iconDefaultColor, size: 80),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 10),
              child: Text(
                'Ahmad Msheik',
                style: ownProfileNameTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.only(top: 70),
              child: ProfileInfoCardWidget(
                icon: '👤',
                label: 'Display Name',
                text: "Tesla's best friend",
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.only(top: 15),
              child: ProfileInfoCardWidget(
                icon: '✍️',
                label: 'Bio',
                text: "I am Ahmad You are no one.",
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.only(top: 15),
              child: ProfileInfoCardWidget(
                icon: '📞',
                label: 'Phone Number',
                text: '+961 71 527 426',
                displayEditButton: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
