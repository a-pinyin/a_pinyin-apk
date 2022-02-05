import 'package:flutter/material.dart';

// 严格 flex 容器 (拉伸)
class StrictColumn extends StatelessWidget {
  const StrictColumn({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
