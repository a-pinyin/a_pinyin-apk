import 'package:flutter/material.dart';
import './normal_key.dart';

// 普通文本按键
class BtnText extends StatelessWidget {
  const BtnText({
    Key? key,
    required this.text,
    this.click,
  }) : super(key: key);

  final String text;
  final void Function(String text)? click;

  @override
  Widget build(BuildContext context) {
    return NormalKey(
      click: () {
        click?.call(text);
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
      ),
    );
  }
}
