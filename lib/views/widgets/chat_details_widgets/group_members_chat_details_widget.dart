import 'package:flutter/material.dart';
import 'package:zchat/messages_system/data_classes/id.dart';
import 'package:zchat/themes_system/data_classes/theme_color_scheme.dart';
import 'package:zchat/views/widgets/chat_details_widgets/group_members_button_widget.dart';

import '../../../themes_system/app_theme.dart';
import '../../data/app_text_styles.dart';
import '../miscellaneous/scaled_text_widget.dart';

class GroupMembersChatDetailsWidget extends StatelessWidget {
  const GroupMembersChatDetailsWidget({super.key, required this.members});

  final List<Id> members;

  @override
  Widget build(BuildContext context) {
    final ThemeColorScheme colors = AppTheme.themeColorsOf(context);

    const double buttonHeight = 71.5;

    final double containerHeight = 1.5 * buttonHeight;
        //min(members.length + 1, AppConstants.maxVisibleMembers) * buttonHeight;

    return (members.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(left: 8, bottom: 0, top: 5),
                child: ScaledTextWidget(
                  'Members',
                  style: AppTextStyles.chatCardNameTextStyle(colors),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 3,),
                child: Container(
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: colors.cardsColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      GroupMembersButtonWidget(
                        id: Id(id: 0, name: 'Add member', isChatId: false),
                        overlayBorderRadius: BorderRadius.zero,
                        icon: Icons.add,
                        color: colors.brandPrimaryColor,
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            return GroupMembersButtonWidget(
                              id: members[index],
                              overlayBorderRadius: BorderRadius.zero,
                              icon: Icons.person,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
