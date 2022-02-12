import 'dart:async';
import 'package:flutter/material.dart';
import '../../../c/strict_column.dart';
import '../../../c/strict_row.dart';
import '../../../c/strict_flex.dart';
import '../host/keyboard_state.dart';
import '../c/btn_text.dart';
import '../c/key_backspace.dart';
import '../c/key_enter.dart';
import '../c/key_space.dart';

// 数字输入
class KbNumber extends StatelessWidget {
  const KbNumber({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;
  // TODO 动态左侧 8 个符号 (从 symbol 键盘取 ?)

  Future<void> click(String text) async {
    await state.input.addText(text);
  }

  @override
  Widget build(BuildContext context) {
    // 4x6 键盘
    final raw = <List<Widget>>[
      // 1
      [
        BtnText(
          text: '=',
          click: click,
        ),
        BtnText(
          text: '#',
          click: click,
        ),
        BtnText(
          text: '7',
          click: click,
        ),
        BtnText(
          text: '8',
          click: click,
        ),
        BtnText(
          text: '9',
          click: click,
        ),
        KeyBackspace(
          click: state.input.backspace,
        ),
      ],
      // 2
      [
        BtnText(
          text: '_',
          click: click,
        ),
        BtnText(
          text: ':',
          click: click,
        ),
        BtnText(
          text: '4',
          click: click,
        ),
        BtnText(
          text: '5',
          click: click,
        ),
        BtnText(
          text: '6',
          click: click,
        ),
        BtnText(
          text: '-',
          click: click,
        ),
      ],
      // 3
      [
        BtnText(
          text: '/',
          click: click,
        ),
        BtnText(
          text: '*',
          click: click,
        ),
        BtnText(
          text: '1',
          click: click,
        ),
        BtnText(
          text: '2',
          click: click,
        ),
        BtnText(
          text: '3',
          click: click,
        ),
        BtnText(
          text: '+',
          click: click,
        ),
      ],
      // 4
      [
        BtnText(
          text: '%',
          click: click,
        ),
        BtnText(
          text: ',',
          click: click,
        ),
        BtnText(
          text: '0',
          click: click,
        ),
        KeySpace(
          click: click,
        ),
        BtnText(
          text: '.',
          click: click,
        ),
        KeyEnter(
          click: state.input.enter,
        ),
      ],
    ];

    return StrictColumn(
      // 4x6 键盘
      children: raw
          .map(
            (line) => StrictFlex(
                child: StrictRow(
              children: line
                  .map((child) => StrictFlex(
                        child: child,
                      ))
                  .toList(),
            )),
          )
          .toList(),
    );
  }
}
