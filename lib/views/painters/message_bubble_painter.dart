/*
This file is based on the chat_bubbles package (MIT License)
Original copyright (c) 2020 Prabhanu Gunaweera
Source: https://github.com/prahack/chat_bubbles

Modifications by Emeralds Nine Organization (2026)

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_constants.dart';

///custom painter use to create the shape of the chat bubble
class MessageBubblePainter extends CustomPainter {
  MessageBubblePainter({
    required this.color,
    required this.alignment,
    required this.tail,
    required this.draw,
    required this.shadowColor,
  });

  final Color color;
  final Color shadowColor;
  final Alignment alignment;
  final bool tail;
  final bool draw;

  final double _radius = 10.0;
  final double _x = AppConstants.messageTailSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (!draw) {
      return;
    }

    var path = Path();

    if (alignment == Alignment.topRight) {
      path.addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          size.width - _x,
          size.height,
          topLeft: Radius.circular(_radius),
          topRight: tail ? Radius.zero : Radius.circular(_radius),
          bottomLeft: Radius.circular(_radius),
          bottomRight: Radius.circular(_radius),
        ),
      );

      if (tail) {
        path.moveTo(size.width - _x, 0);
        path.lineTo(size.width - _x, 10);
        path.lineTo(size.width, 0);
        path.close();
      }
    } else {
      path.addRRect(
        RRect.fromLTRBAndCorners(
          _x,
          0,
          size.width,
          size.height,
          topLeft: tail ? Radius.zero : Radius.circular(_radius),
          topRight: Radius.circular(_radius),
          bottomLeft: Radius.circular(_radius),
          bottomRight: Radius.circular(_radius),
        ),
      );

      if (tail) {
        path.moveTo(_x, 0);
        path.lineTo(_x, 10);
        path.lineTo(0, 0);
        path.close();
      }
    }

    canvas.drawShadow(
      path,
      shadowColor.withAlpha(130), // shadow color
      1, // blur/elevation
      true, // allow transparent shape
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
