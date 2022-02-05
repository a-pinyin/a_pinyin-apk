import 'package:flutter/material.dart';
import '../../../c/strict_row.dart';
import '../../../c/strict_column.dart';
import '../../../c/strict_flex.dart';
import '../t.dart';
import '../host/keyboard_state.dart';
import '../top_c/top_layout.dart';
import './top_sec_btn.dart';

// 顶栏: 输入功能切换
class Top1 extends StatelessWidget {
  const Top1({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;

  void click(TopType t) {
    state.onTopClick(t);
  }

  @override
  Widget build(BuildContext context) {
    return TopLayout(
      lmode: false,
      ricon: Icons.arrow_downward_rounded,
      clickL: () => click(TopType.tool),
      clickR: () => click(TopType.rbtn),
      // 中部
      center: StrictColumn(
        children: [
          StrictFlex(
            child: StrictRow(
              children: [
                TopSecBtn('A', TopType.letter,
                    active: state.currentTop, click: click),
                TopSecBtn('2', TopType.number,
                    active: state.currentTop, click: click),
                TopSecBtn('@', TopType.symbol,
                    active: state.currentTop, click: click),
              ],
            ),
          ),
          StrictFlex(
            child: StrictRow(
              children: [
                TopSecBtn('拼', TopType.pinyin,
                    active: state.currentTop, click: click),
                TopSecBtn('。', TopType.symbol2,
                    active: state.currentTop, click: click),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
