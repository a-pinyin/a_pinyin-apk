import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 启用剪切板日志
class ConfigClipLog extends ConfigItemSwitch {
  ConfigClipLog()
      : super(
          title: '剪切板日志',
          text: '记录剪切板内容的历史',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getClipLog();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setClipLog(v);
  }
}
