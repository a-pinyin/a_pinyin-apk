import 'package:flutter/material.dart';

// 顶部按钮 (一般)
class TopBtn extends StatelessWidget {
  const TopBtn({
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
      child: child,
    );
  }
}
