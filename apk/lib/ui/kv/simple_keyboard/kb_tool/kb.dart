import 'package:flutter/material.dart';
import '../host/keyboard_state.dart';
import './no_log_mode.dart';
import './edit_tool.dart';
import './info.dart';

// 小工具界面
class KbTool extends StatelessWidget {
  const KbTool({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 无痕模式
        NoLogMode(state: state),
        // 编辑工具
        EditTool(input: state.input),
        // EditorInfo
        state.config.toolShowEditorInfo
            ? Info(info: state.editorInfo)
            : Container(),
      ],
    );
  }
}
