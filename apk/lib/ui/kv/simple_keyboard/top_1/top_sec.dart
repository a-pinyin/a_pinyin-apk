import 'package:flutter/material.dart';
import '../top_c/top_btn.dart';

// 顶部小按钮
class TopSec extends StatelessWidget {
  const TopSec({
    Key? key,
    required this.child,
    this.click,
  }) : super(key: key);

  final Widget child;
  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 48.0),
      child: TopBtn(
        child: child,
        click: click,
      ),
    );
  }
}
