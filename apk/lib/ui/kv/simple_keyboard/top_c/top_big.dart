import 'package:flutter/material.dart';
import './top_btn.dart';

// 顶部大按钮
class TopBig extends StatelessWidget {
  const TopBig({
    Key? key,
    required this.child,
    this.click,
  }) : super(key: key);

  final Widget child;
  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 60, minWidth: 60),
      child: TopBtn(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: child,
          ),
        ),
        click: click,
      ),
    );
  }
}
