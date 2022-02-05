import 'package:flutter/material.dart';
import '../host/keyboard_state.dart';
import '../c/kb_26_layout.dart';
import '../c/key_shift.dart';

// 英文字母输入 (26 键)
class KbLetter extends StatefulWidget {
  const KbLetter({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;

  @override
  _KbLetterState createState() => _KbLetterState();
}

class _KbLetterState extends State<KbLetter> {
  // 键盘 shift 状态
  bool shift = false;

  void clickShift() {
    setState(() {
      shift = !shift;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Kb26Layout(
      layout: widget.state.config.kbLayout,
      shift: shift,
      // shift 键
      special: KeyShift(
        click: clickShift,
      ),
      clickText: widget.state.input.addText,
      clickBackspace: widget.state.input.backspace,
      clickEnter: widget.state.input.enter,
    );
  }
}
