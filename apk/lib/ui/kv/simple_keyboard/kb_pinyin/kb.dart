import 'package:flutter/material.dart';
import '../../../c/todo_placeholder.dart';
import '../host/keyboard_state.dart';

// 拼音输入键盘
class KbPinyin extends StatelessWidget {
  const KbPinyin({
    Key? key,
    required KeyboardState state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPlaceholder();
  }
}
