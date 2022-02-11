import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 启用剪切板管理器
class ConfigClipEnable extends ConfigItemSwitch {
  ConfigClipEnable()
      : super(
          title: '剪切板管理器',
          text: 'TODO 启用剪切板管理器 (不影响下面几个选项)',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getClipEnable();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setClipEnable(v);
  }
}
