import 'dart:async';
import 'package:flutter/material.dart';
import '../../bridge/bridge.dart';
import '../../kv/simple_keyboard/kb_layout.dart';

// 设置项: 键盘布局
class ConfigKbLayout extends StatelessWidget {
  const ConfigKbLayout({
    Key? key,
    required this.uch,
    required this.value,
    required this.onUpdate,
  }) : super(key: key);

  final String value;
  final Future<void> Function() onUpdate;
  final UiConfigHost uch;

  Future<void> onChange(String v) async {
    await uch.setKbLayout(v);
    await onUpdate();
  }

  // 选择键盘布局的对话框
  Widget selectDialog(BuildContext context) {
    void closeDialog() {
      Navigator.of(context, rootNavigator: true).pop();
    }

    return SimpleDialog(
      title: const Text('请选择键盘布局'),
      children: layoutNameList
          .map((name) => SimpleDialogOption(
                child: Text(name),
                onPressed: () {
                  onChange(name);
                  closeDialog();
                },
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('键盘布局'),
      subtitle: Text('当前键盘布局名称: ' + value),
      trailing: IconButton(
        icon: const Icon(Icons.edit_rounded),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => selectDialog(context),
          );
        },
      ),
    );
  }
}
