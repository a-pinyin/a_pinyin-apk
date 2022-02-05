import 'package:flutter/material.dart';
import './btn_icon.dart';

// Shift (上档) 键
class KeyShift extends StatelessWidget {
  const KeyShift({Key? key, this.click}) : super(key: key);

  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return BtnIcon(
      click: click,
      icon: Icons.arrow_upward_rounded,
    );
  }
}
