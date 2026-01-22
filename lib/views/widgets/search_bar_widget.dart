import 'package:flutter/material.dart';

import '../../controllers/custom_text_controller.dart';
import '../../themes_system/app_theme.dart';
import '../../utils/text_field_utils.dart';
import '../data/app_text_styles.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, this.hintText = 's', this.sideWidget});

  final String hintText;
  final Widget? sideWidget;

  @override
  State<SearchBarWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  late FocusNode focusNode;
  late CustomTextController controller;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = CustomTextController();
    controller.addListener(onTextChanged);
  }

  @override
  void dispose() {
    controller.removeListener(onTextChanged);
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colors.cardsColor,
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colors.hintColor),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textDirection: TextFieldUtils.getTextDirection(controller.text),
              strutStyle: const StrutStyle(fontSize: 20, height: 1.2),
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
            ),
          ),
          if (widget.sideWidget != null) widget.sideWidget!,
        ],
      ),
    );
  }
}
