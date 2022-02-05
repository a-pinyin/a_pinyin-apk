import 'package:flutter/material.dart';
import '../../../c/strict_column.dart';
import '../host/keyboard_state.dart';

// 无痕模式
class NoLogMode extends StatefulWidget {
  const NoLogMode({
    Key? key,
    required this.state,
  }) : super(key: key);

  final KeyboardState state;

  @override
  _NoLogModeState createState() => _NoLogModeState();
}

class _NoLogModeState extends State<NoLogMode> {
  // 无痕模式状态
  bool noLogMode = false;

  void click(bool v) {
    // TODO 实现无痕模式
    setState(() {
      noLogMode = v;
    });
  }

  // 无痕模式提示
  Widget noLogNotice() {
    if (noLogMode) {
      return const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text(
          '无痕模式开启: 输入法不会记录任何用户输入.',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return StrictColumn(
      children: [
        // 无痕模式 (开关)
        ListTile(
          title: const Text('无痕模式'),
          trailing: Switch(
            value: noLogMode,
            onChanged: click,
          ),
        ),
        // 无痕模式提示文本
        noLogNotice(),
        const Divider(),
      ],
    );
  }
}
