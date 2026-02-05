import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/custom_text_controller.dart';
import '../../../themes_system/app_theme.dart';
import '../../../utils/text_utils.dart';
import '../../data/app_text_styles.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    this.hintText = 'Search',
    this.sideWidget,
    required this.disableSet,
  });

  final ValueNotifier<bool> disableSet;
  final String hintText;
  final Widget? sideWidget;

  @override
  State<SearchBarWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  late FocusNode focusNode;
  late CustomTextController controller;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = CustomTextController();
    controller.addListener(onTextChanged);
    // Listen to keyboard visibility changes
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((
      visible,
    ) {
      if (!visible && focusNode.hasFocus) {
        focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    controller.removeListener(onTextChanged);
    keyboardSubscription.cancel();
    controller.dispose();
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
        children: [
          SvgPicture.asset(
            'assets/icons/search.svg',
            colorFilter: ColorFilter.mode(colors.hintColor, BlendMode.srcIn),
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.disableSet,
              builder: (context, value, child) {
                return TextField(
                  controller: controller,
                  enabled: !value,
                  textDirection: TextUtils.getTextDirection(controller.text),
                  textCapitalization: TextCapitalization.sentences,
                  strutStyle: const StrutStyle(fontSize: 20, height: 1),
                  focusNode: focusNode,
                  onTapOutside: (event) {
                    focusNode.unfocus();
                  },
                  style: TextStyle(color: colors.primaryColor),

                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hintText,
                    hintStyle: AppTextStyles.hintTextStyle(colors),
                    border: InputBorder.none,
                  ),
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
