import 'package:flutter/material.dart';
import '../t.dart';

// 输入信息 EditorInfo
class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.info,
  }) : super(key: key);

  final EditorInfo info;

  String infoText() {
    // 生成文本
    List<String> text = [
      'EditorInfo',
      '',
    ];
    for (var i in info.keys) {
      if (i == 'dump') {
        continue;
      }
      text.add(i + ' = ' + (info[i] ?? ''));
    }
    // 最后显示 dump
    text.add('');
    text.add('dump =');
    text.add(info['dump'] ?? '');

    return text.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.lightGreen.shade100,
      child: SelectableText(infoText()),
    );
  }
}
