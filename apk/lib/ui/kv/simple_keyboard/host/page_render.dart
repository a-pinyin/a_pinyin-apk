import 'package:flutter/material.dart';
import '../../../c/strict_column.dart';
import '../../../c/strict_flex.dart';
import '../../../c/todo_placeholder.dart';
import '../../config.dart';
import '../t.dart';
import '../top_1/top.dart';
import '../kb_tool/kb.dart';
import '../kb_letter/kb.dart';
import '../kb_number/kb.dart';
import '../kb_symbol/kb.dart';
import '../kb_pinyin/kb.dart';
import '../kb_symbol2/kb.dart';
import './keyboard_state.dart';

// 主键盘界面 (绘制部分)
class PageRender extends StatelessWidget {
  const PageRender({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;

  // 返回下方区域组件
  Widget getKb() {
    switch (state.currentTop) {
      case TopType.tool:
        return KbTool(state: state);
      case TopType.letter:
        return KbLetter(state: state);
      case TopType.number:
        return KbNumber(state: state);
      case TopType.symbol:
        return KbSymbol(state: state);
      case TopType.pinyin:
        return KbPinyin(state: state);
      case TopType.symbol2:
        return KbSymbol2(state: state);
      default:
        return const TodoPlaceholder();
    }
  }

  // 隐藏键盘模式
  Widget getDown() {
    if (state.kbHideMode) {
      return Container();
    }

    return StrictFlex(
      // 下方 4 行标准高度
      flex: kbKbHeight,
      child: getKb(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StrictColumn(
      children: [
        // 顶栏: 功能切换, 拼音输入 (拼音+候选项)
        StrictFlex(
          // 顶栏相对高度
          flex: kbTopHeight,
          child: Top1(state: state),
        ),
        // 下方键盘区域
        getDown(),
      ],
    );
  }
}
