import 'package:flutter/material.dart';
import './normal_key.dart';

// 空格键
class KeySpace extends StatelessWidget {
  const KeySpace({Key? key, this.click}) : super(key: key);

  final void Function(String text)? click;

  @override
  Widget build(BuildContext context) {
    return NormalKey(
      click: () {
        // space text
        click?.call(' ');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.lightGreen),
        ),
      ),
    );
  }
}
