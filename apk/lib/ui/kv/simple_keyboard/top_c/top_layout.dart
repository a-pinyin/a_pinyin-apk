import 'package:flutter/material.dart';
import '../../../c/strict_row.dart';
import '../c/apy_logo.dart';
import './top_big.dart';

// 顶栏主体布局
class TopLayout extends StatelessWidget {
  const TopLayout({
    Key? key,
    required this.lmode,
    required this.ricon,
    required this.center,
    this.clickL,
    this.clickR,
  }) : super(key: key);

  // 左侧大按钮模式
  final bool lmode;
  // 右侧大按钮图标
  final IconData ricon;
  // 中部区域
  final Widget center;
  // 点击左侧按钮
  final void Function()? clickL;
  // 点击右侧按钮
  final void Function()? clickR;

  @override
  Widget build(BuildContext context) {
    return StrictRow(children: [
      // 左侧
      TopBig(
        child: const ApyLogo(),
        click: clickL,
      ),
      // 中部
      Flexible(
        child: Container(
          color: Colors.lightGreen.shade50,
          child: center,
        ),
      ),
      // 右侧
      TopBig(
        child: Icon(
          ricon,
          color: Colors.green,
          size: 24,
        ),
        click: clickR,
      ),
    ]);
  }
}
