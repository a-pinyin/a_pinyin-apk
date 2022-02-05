import 'package:flutter/material.dart';

// 普通按键
class NormalKey extends StatelessWidget {
  const NormalKey({
    Key? key,
    required this.child,
    this.click,
  }) : super(key: key);

  final Widget child;
  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        click?.call();
      },
      child: Center(
        child: child,
      ),
    );
  }
}
