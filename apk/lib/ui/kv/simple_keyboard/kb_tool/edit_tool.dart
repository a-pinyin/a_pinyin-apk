import 'package:flutter/material.dart';
import '../../../c/strict_row.dart';
import '../../../c/strict_flex.dart';
import '../host/keyboard_input.dart';
import '../c/key_backspace.dart';
import '../c/key_enter.dart';

// 编辑工具
class EditTool extends StatelessWidget {
  const EditTool({
    Key? key,
    required this.input,
  }) : super(key: key);

  final KeyboardInput input;

  Widget buildColumn(Widget a, Widget b) {
    return StrictFlex(
      child: Column(
        children: [
          StrictFlex(
            child: Center(
              child: a,
            ),
          ),
          StrictFlex(
            child: Center(
              child: b,
            ),
          ),
        ],
      ),
    );
  }

  Widget textBtn(String text, void Function() click) {
    return InkWell(
      onTap: click,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget arrowBtn(IconData icon, String tooltip, void Function() click) {
    return InkWell(
      onTap: click,
      child: Tooltip(
        message: tooltip,
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 编辑工具布局:
    //
    // 撤销 全选 复制 上 粘贴 删除
    // 重做 剪切  左  下  右  回车
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 120),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: StrictRow(
          children: [
            buildColumn(
              textBtn('撤销', input.undo),
              textBtn('重做', input.redo),
            ),
            buildColumn(
              textBtn('全选', input.selectAll),
              textBtn('剪切', input.cut),
            ),
            buildColumn(
              textBtn('复制', input.copy),
              arrowBtn(Icons.arrow_back_rounded, '光标左移', input.left),
            ),
            buildColumn(
              arrowBtn(Icons.arrow_upward_rounded, '光标上移', input.up),
              arrowBtn(Icons.arrow_downward_rounded, '光标下移', input.down),
            ),
            buildColumn(
              textBtn('粘贴', input.paste),
              arrowBtn(Icons.arrow_forward_rounded, '光标右移', input.right),
            ),
            buildColumn(
              KeyBackspace(click: input.backspace),
              KeyEnter(click: input.enter),
            ),
          ],
        ),
      ),
    );
  }
}
