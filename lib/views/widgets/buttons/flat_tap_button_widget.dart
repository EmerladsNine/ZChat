import 'package:flutter/material.dart';
import 'package:zchat/views/widgets/buttons/base_button_widget.dart';

class FlatTapButtonWidget extends BaseButtonWidget {
  FlatTapButtonWidget({
    super.key,
    required super.child,
    super.padding,
    super.onTap,
    super.onTapDown,
    super.onTapCancel,
    super.onPanDown,
    super.disableSet,
    super.appStateNotifier,
    super.width,
    super.height,
  });

  @override
  Widget buildOverlay(
    BuildContext context,
    bool pressed,
    VoidCallback markFillAnimationAsDone,
    VoidCallback markEmptyAnimationAsDone,
  ) {
    pressed ? markFillAnimationAsDone() : markEmptyAnimationAsDone();

    return Positioned.fill(
      child: SizedBox(
        width: pressed ? MediaQuery.of(context).size.width : 0,
        height: double.infinity,
      ),
    );
  }
}
