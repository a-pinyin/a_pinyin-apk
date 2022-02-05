import 'package:flutter/material.dart';

// 严格 flex 容器 (拉伸)
class StrictRow extends StatelessWidget {
  const StrictRow({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
