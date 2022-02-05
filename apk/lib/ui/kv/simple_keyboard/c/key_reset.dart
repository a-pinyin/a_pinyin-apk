import 'package:flutter/material.dart';
import './btn_icon.dart';

// 重输键
class KeyReset extends StatelessWidget {
  const KeyReset({Key? key, this.click}) : super(key: key);

  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return BtnIcon(
      click: click,
      icon: Icons.clear_rounded,
    );
  }
}
