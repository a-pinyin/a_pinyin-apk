import 'package:flutter/material.dart';
import './keyboard_host.dart';
import './keyboard_state.dart';
import './page_render.dart';

// 主键盘界面 (控制部分)
class SimpleKeyboard extends StatefulWidget {
  const SimpleKeyboard({Key? key}) : super(key: key);

  @override
  _SimpleKeyboardState createState() => _SimpleKeyboardState();
}

class _SimpleKeyboardState extends State<SimpleKeyboard> {
  KeyboardHost host = KeyboardHost();
  // 键盘总状态
  KeyboardState state = KeyboardHost.getDefaultState();

  void updateKeyboardState(KeyboardState s) {
    setState(() {
      state = s;
    });
  }

  @override
  void initState() {
    super.initState();
    host.initState(updateKeyboardState);
  }

  @override
  void dispose() {
    super.dispose();
    host.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageRender(
        state: state,
      ),
    );
  }
}
