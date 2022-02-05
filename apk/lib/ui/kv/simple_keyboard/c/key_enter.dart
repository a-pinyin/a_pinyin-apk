import 'package:flutter/material.dart';
import './btn_icon.dart';

// Enter (回车) 键
class KeyEnter extends StatelessWidget {
  const KeyEnter({Key? key, this.click}) : super(key: key);

  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return BtnIcon(
      click: click,
      icon: Icons.keyboard_return_rounded,
    );
  }
}
