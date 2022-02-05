import 'package:flutter/material.dart';
import './btn_icon.dart';

// Backspace (退格) 键
class KeyBackspace extends StatelessWidget {
  const KeyBackspace({Key? key, this.click}) : super(key: key);

  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return BtnIcon(
      click: click,
      icon: Icons.backspace_outlined,
    );
  }
}
