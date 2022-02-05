import 'package:flutter/material.dart';
import '../../../c/strict_column.dart';
import '../../../c/strict_row.dart';
import '../../../c/strict_flex.dart';
import '../host/keyboard_state.dart';
import '../c/btn_text.dart';
import '../util.dart';

// ASCII 符号输入
class KbSymbol extends StatelessWidget {
  const KbSymbol({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;

  @override
  Widget build(BuildContext context) {
    return StrictColumn(
      // 4x8 键盘
      children: cutList(aData, 8)
          .map((line) => StrictFlex(
                child: StrictRow(
                  children: line
                      .map((text) => StrictFlex(
                            child: BtnText(
                              text: text,
                              click: state.input.addText,
                            ),
                          ))
                      .toList(),
                ),
              ))
          .toList(),
    );
  }
}

// ASCII 符号列表 (32 个)
const aData = [
  '/',
  '~',
  ':',
  '(',
  ')',
  '?',
  '_',
  '^',
  '"',
  '=',
  '#',
  '-',
  '<',
  '>',
  '*',
  ';',
  '[',
  ']',
  '{',
  '}',
  '!',
  '@',
  '`',
  '\\',
  '%',
  '\$',
  '+',
  ',',
  '\'',
  '|',
  '.',
  '&',
];
