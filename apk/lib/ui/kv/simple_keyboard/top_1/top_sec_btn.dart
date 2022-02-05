import 'package:flutter/material.dart';
import '../t.dart';
import './top_sec.dart';
import './top_text.dart';

// 封装: 带有激活处理的小文本按钮
class TopSecBtn extends StatelessWidget {
  const TopSecBtn(
    this.text,
    this.thisType, {
    Key? key,
    required this.active,
    this.click,
  }) : super(key: key);

  final String text;
  final TopType active;
  final TopType thisType;

  final void Function(TopType t)? click;

  @override
  Widget build(BuildContext context) {
    return TopSec(
      click: () {
        click?.call(thisType);
      },
      child: TopText(text, active == thisType),
    );
  }
}
