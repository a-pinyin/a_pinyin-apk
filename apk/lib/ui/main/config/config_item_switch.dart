import 'dart:async';
import 'package:flutter/material.dart';
import '../../bridge/bridge.dart';
import './config_item.dart';

// 开关类型的设置项
abstract class ConfigItemSwitch extends ConfigItemImpl {
  ConfigItemSwitch({
    required String title,
    required String text,
  }) : super(title: title, text: text);

  Future<bool> load(UiConfigHost uch);
  Future<void> save(UiConfigHost uch, bool v);

  // 初始化加载
  bool afterLoad = false;
  // 当前设置值
  bool value = false;

  Future<void> change(ConfigItemHost ci, bool v) async {
    await save(ci.uch, v);
    ci.onUpdate();
  }

  @override
  Future<void> loadConfig(ConfigItemHost ci) async {
    value = await load(ci.uch);
    afterLoad = true;
  }

  @override
  Widget build(BuildContext context, ConfigItemHost ci) {
    if (afterLoad) {
      return Switch(
        value: value,
        onChanged: (bool v) {
          change(ci, v);
        },
      );
    }
    // 首次加载之前仅显示占位符
    return const SizedBox.shrink();
  }
}
