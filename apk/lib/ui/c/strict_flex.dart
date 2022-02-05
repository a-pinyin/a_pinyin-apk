import 'package:flutter/material.dart';

// 严格 flex 项目
class StrictFlex extends StatelessWidget {
  const StrictFlex({
    Key? key,
    required this.child,
    this.flex = 1,
  }) : super(key: key);

  final Widget child;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      fit: FlexFit.tight,
      child: child,
    );
  }
}
