import 'dart:async';
import 'package:flutter/material.dart';
import '../../bridge/bridge.dart';

// 设置项: 显示 EditorInfo
class ConfigShowEditorInfo extends StatelessWidget {
  const ConfigShowEditorInfo({
    Key? key,
    required this.uch,
    required this.value,
    required this.onUpdate,
  }) : super(key: key);

  // 当前设置值
  final bool value;
  // 设置更新后
  final Future<void> Function() onUpdate;

  final UiConfigHost uch;

  Future<void> onChanged(bool v) async {
    await uch.setShowEditorInfo(v);
    await onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('显示 EditorInfo'),
      subtitle: const Text('在键盘小工具页面显示当前输入文本框的 EditorInfo (用于调试)'),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
