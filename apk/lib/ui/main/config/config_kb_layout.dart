import 'dart:async';
import 'package:flutter/material.dart';
import '../../kv/simple_keyboard/config.dart';
import '../../kv/simple_keyboard/kb_layout.dart';
import './config_item.dart';

// 设置项: 键盘布局
class ConfigKbLayout extends ConfigItemImpl {
  ConfigKbLayout() : super(title: '键盘布局');

  String value = kbLayoutDefault;

  @override
  String get text {
    return '当前键盘布局名称: ' + value;
  }

  @override
  Future<void> loadConfig(ConfigItemHost ci) async {
    var v = await ci.uch.getKbLayout();
    if (v != null) {
      value = v;
    }
  }

  Future<void> change(ConfigItemHost ci, String v) async {
    await ci.uch.setKbLayout(v);
    ci.onUpdate();
  }

  // 选择键盘布局的对话框
  Widget selectDialog(BuildContext context, ConfigItemHost ci) {
    void closeDialog() {
      Navigator.of(context, rootNavigator: true).pop();
    }

    return SimpleDialog(
      title: const Text('请选择键盘布局'),
      children: layoutNameList
          .map((name) => SimpleDialogOption(
                child: Text(name),
                onPressed: () {
                  change(ci, name);
                  closeDialog();
                },
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context, ConfigItemHost ci) {
    return IconButton(
      icon: const Icon(Icons.edit_rounded),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => selectDialog(context, ci),
        );
      },
    );
  }
}
