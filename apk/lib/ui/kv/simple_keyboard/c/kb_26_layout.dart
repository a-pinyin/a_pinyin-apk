import 'package:flutter/material.dart';
import '../../../c/strict_column.dart';
import '../../../c/strict_row.dart';
import '../../../c/strict_flex.dart';
import '../t.dart';
import './btn_text.dart';
import './key_backspace.dart';
import './key_enter.dart';
import './key_space.dart';

// 实现根据配置绘制键盘布局 (26 键)
class Kb26Layout extends StatelessWidget {
  const Kb26Layout({
    Key? key,
    required this.layout,
    required this.special,
    this.shift = false,
    this.clickText,
    this.clickBackspace,
    this.clickEnter,
  }) : super(key: key);

  // 键盘布局数据
  final KbLayoutT layout;
  // shift 状态
  final bool shift;
  // 特殊键 (shift/reset)
  final Widget special;
  // 输入文本
  final void Function(String text)? clickText;
  // backspace 键
  final void Function()? clickBackspace;
  // enter 键
  final void Function()? clickEnter;

  Widget genTextKey(int width, LayoutKeyItem ki) {
    // assert: ki.type == text
    var text = shift ? ki.text2 : ki.text;
    if (text != null) {
      return wrapKey(
        width,
        BtnText(
          text: text,
          click: clickText,
        ),
      );
    }
    // unknown ?
    return wrapKey(
      width,
      const BtnText(
        text: '??',
      ),
    );
  }

  Widget genKey(LayoutKeyItem ki) {
    switch (ki.type) {
      case LayoutKeyType.white:
        return wrapKey(5, const SizedBox.shrink());
      case LayoutKeyType.backspace:
        return wrapKey(
          15,
          KeyBackspace(
            click: clickBackspace,
          ),
        );
      case LayoutKeyType.special:
        return wrapKey(15, special);
      case LayoutKeyType.text:
        return genTextKey(10, ki);
    }
  }

  Widget wrapKey(int width, Widget child) {
    return StrictFlex(
      flex: width,
      child: child,
    );
  }

  Widget wrapLine(List<Widget> children) {
    return StrictFlex(
      child: StrictRow(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StrictColumn(
      // 4 行键盘
      children: [
        // 1, 2, 3: layout
        wrapLine(layout[0].map(genKey).toList()),
        wrapLine(layout[1].map(genKey).toList()),
        wrapLine(layout[2].map(genKey).toList()),
        // 4
        wrapLine([
          genTextKey(15, const LayoutKeyItem.text('\'', '"')),
          genTextKey(10, const LayoutKeyItem.text(',', '<')),
          wrapKey(
            50,
            KeySpace(
              click: clickText,
            ),
          ),
          genTextKey(10, const LayoutKeyItem.text('.', '>')),
          wrapKey(
            15,
            KeyEnter(
              click: clickEnter,
            ),
          ),
        ]),
      ],
    );
  }
}
