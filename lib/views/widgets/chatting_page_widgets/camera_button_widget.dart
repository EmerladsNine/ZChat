import 'package:flutter/material.dart';

import '../../data/colors.dart';

class CameraButtonWidget extends StatelessWidget{
  const CameraButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.camera_alt_outlined,
          color: primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
