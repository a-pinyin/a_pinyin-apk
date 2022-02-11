import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 启用剪切板变更通知
class ConfigClipUpdateNoti extends ConfigItemSwitch {
  ConfigClipUpdateNoti()
      : super(
          title: '剪切板变更通知',
          text: '监听到剪切板变更后发出通知',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getClipUpdateNoti();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setClipUpdateNoti(v);
  }
}
