import 'package:flutter/material.dart';

import '../../themes_system/enums/message_bubble_color.dart';
import '../../themes_system/data_classes/mode_color.dart';

abstract final class AppMessageBubbleColors {
  static const Map<MessageBubbleColor, ModeColor> palette = {
    MessageBubbleColor.main: ModeColor(
      light: Color(0xFFA4ECFC),
      dark: Color(0xFF043f90), //old one 0xFF043f70
    ),
    MessageBubbleColor.bland: ModeColor(
      light: Color(0xFFECECEC),
      dark: Color(0xFF191919),
    ),
    MessageBubbleColor.mint: ModeColor(
      light: Color(0xFFD9FBE5),
      dark: Color(0xFF1F4D36),
    ),
    MessageBubbleColor.sage: ModeColor(
      light: Color(0xFFE6F4EA),
      dark: Color(0xFF2F4F3A),
    ),
    MessageBubbleColor.forest: ModeColor(
      light: Color(0xFFCDE8D5),
      dark: Color(0xFF1B3A2B),
    ),
    MessageBubbleColor.lime: ModeColor(
      light: Color(0xFFF0F9D8),
      dark: Color(0xFF3F4F1F),
    ),

    MessageBubbleColor.sky: ModeColor(
      light: Color(0xFFDFF1FF),
      dark: Color(0xFF1C3F5E),
    ),
    MessageBubbleColor.ocean: ModeColor(
      light: Color(0xFFD6EFFF),
      dark: Color(0xFF163B57),
    ),
    MessageBubbleColor.denim: ModeColor(
      light: Color(0xFFE2ECF9),
      dark: Color(0xFF1E2F4D),
    ),
    MessageBubbleColor.navy: ModeColor(
      light: Color(0xFFDDE4F0),
      dark: Color(0xFF1A2638),
    ),

    MessageBubbleColor.lavender: ModeColor(
      light: Color(0xFFF0E6FF),
      dark: Color(0xFF3A2A4D),
    ),
    MessageBubbleColor.lilac: ModeColor(
      light: Color(0xFFEAD9FF),
      dark: Color(0xFF35254A),
    ),
    MessageBubbleColor.orchid: ModeColor(
      light: Color(0xFFF5D9F7),
      dark: Color(0xFF4A2A4D),
    ),
    MessageBubbleColor.plum: ModeColor(
      light: Color(0xFFE8D0E8),
      dark: Color(0xFF3B223B),
    ),

    MessageBubbleColor.rose: ModeColor(
      light: Color(0xFFFFE1E6),
      dark: Color(0xFF4D232C),
    ),
    MessageBubbleColor.coral: ModeColor(
      light: Color(0xFFFFDAD4),
      dark: Color(0xFF4D2A22),
    ),
    MessageBubbleColor.peach: ModeColor(
      light: Color(0xFFFFE8D6),
      dark: Color(0xFF4D3325),
    ),
    MessageBubbleColor.apricot: ModeColor(
      light: Color(0xFFFFF0DB),
      dark: Color(0xFF4D3822),
    ),

    MessageBubbleColor.sand: ModeColor(
      light: Color(0xFFF5ECD9),
      dark: Color(0xFF4A3E2A),
    ),
    MessageBubbleColor.caramel: ModeColor(
      light: Color(0xFFEBD7C3),
      dark: Color(0xFF3E2E1F),
    ),
    MessageBubbleColor.cocoa: ModeColor(
      light: Color(0xFFE2CFC3),
      dark: Color(0xFF332621),
    ),
    MessageBubbleColor.mocha: ModeColor(
      light: Color(0xFFD7C2B5),
      dark: Color(0xFF2C201C),
    ),
    MessageBubbleColor.steel: ModeColor(
      light: Color(0xFFDDE3EA),
      dark: Color(0xFF2A3036),
    ),
    MessageBubbleColor.smoke: ModeColor(
      light: Color(0xFFEDEFF2),
      dark: Color(0xFF30363C),
    ),
    MessageBubbleColor.lemon: ModeColor(
      light: Color(0xFFFFF7CC),
      dark: Color(0xFF4A4720),
    ),
    MessageBubbleColor.sunflower: ModeColor(
      light: Color(0xFFFFEEB3),
      dark: Color(0xFF4A3E1F),
    ),
    MessageBubbleColor.amber: ModeColor(
      light: Color(0xFFFFE0B2),
      dark: Color(0xFF4A321F),
    ),
    MessageBubbleColor.honey: ModeColor(
      light: Color(0xFFFFF1C1),
      dark: Color(0xFF4A3D21),
    ),

    MessageBubbleColor.ice: ModeColor(
      light: Color(0xFFE6FBFF),
      dark: Color(0xFF1E3B40),
    ),
    MessageBubbleColor.frost: ModeColor(
      light: Color(0xFFDFF7FA),
      dark: Color(0xFF1F3A3F),
    ),
  };

  static Color get(MessageBubbleColor color, bool isDarkMode) {
    final dual = palette[color]!;
    return isDarkMode ? dual.dark : dual.light;
  }
}
