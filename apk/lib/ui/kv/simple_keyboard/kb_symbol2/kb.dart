import 'package:flutter/material.dart';
import '../../../c/todo_placeholder.dart';
import '../host/keyboard_state.dart';

// 扩展符号输入
class KbSymbol2 extends StatelessWidget {
  const KbSymbol2({
    Key? key,
    required KeyboardState state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPlaceholder();
  }
}
