import 'package:flutter/material.dart';
import '../../../c/todo_placeholder.dart';
import '../host/keyboard_state.dart';

// 顶栏: 拼音输入时, 显示拼音和候选项
class TopPinyin extends StatelessWidget {
  const TopPinyin({
    Key? key,
    required KeyboardState state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPlaceholder();
  }
}
