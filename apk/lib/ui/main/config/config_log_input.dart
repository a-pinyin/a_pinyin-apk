import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 启用输入日志
class ConfigLogInput extends ConfigItemSwitch {
  ConfigLogInput()
      : super(
          title: '输入日志',
          text: '用于输入统计分析',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getLogInput();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setLogInput(v);
  }
}
