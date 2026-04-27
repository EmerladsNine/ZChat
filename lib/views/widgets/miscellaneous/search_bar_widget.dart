import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zchat/keyboard_management_system/keyboard_controller.dart';

import '../../controllers/custom_text_controller.dart';
import '../../../themes_system/app_theme.dart';
import '../../utils/text_utils.dart';
import '../../data/app_text_styles.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    this.hintText = 'Search',
    this.sideWidget,
    required this.disableSet,
    this.controller
  });

  final ValueNotifier<bool> disableSet;
  final String hintText;
  final Widget? sideWidget;
  final CustomTextController? controller;

  @override
  State<SearchBarWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  late FocusNode focusNode;
  late CustomTextController controller;
  bool showHint = true;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = widget.controller ?? CustomTextController();
    controller.addListener(onTextChanged);
    controller.addListener((){
      setState(() {
        showHint = controller.text.isEmpty;
      });
    });
    KeyboardController.addStateListener((isFullyOpen) {
      if (!isFullyOpen && focusNode.hasFocus) {
        focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    controller.removeListener(onTextChanged);
    controller.dispose();
    KeyboardController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.themeColorsOf(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 3, 0),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colors.cardsColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.search,color: colors.hintColor,size: 23,),
          const SizedBox(width: 4),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.disableSet,
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextField(
                      controller: controller,
                      enabled: !value,
                      textDirection: TextUtils.getTextDirection(controller.text),
                      textCapitalization: TextCapitalization.sentences,
                      focusNode: focusNode,
                      onTapOutside: (event) {
                        focusNode.unfocus();
                      },
                      style: TextStyle(
                        color: colors.primaryColor,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        hintText: "",
                        border: InputBorder.none,
                      ),
                    ),
                    if (showHint)
                      IgnorePointer(
                        child: Text(
                          widget.hintText,
                          style: AppTextStyles.hintTextStyle(colors).copyWith(
                            fontSize: 16,
                            height: 1.2,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          if (widget.sideWidget != null) widget.sideWidget!,
        ],
      ),
    );
  }

  void onTextChanged() {
    setState(() {});
  }
}
