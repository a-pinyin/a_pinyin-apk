import 'package:flutter/material.dart';
import './normal_key.dart';

// 图标按键
class BtnIcon extends StatelessWidget {
  const BtnIcon({
    Key? key,
    required this.icon,
    this.click,
  }) : super(key: key);

  final IconData icon;
  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return NormalKey(
      click: click,
      child: Icon(
        icon,
        size: 24,
        color: Colors.lightGreen,
      ),
    );
  }
}
