import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 启用剪切板内容通知
class ConfigClipTopNoti extends ConfigItemSwitch {
  ConfigClipTopNoti()
      : super(
          title: '剪切板内容通知',
          text: '显示当前剪切板内容的常驻通知',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getClipTopNoti();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setClipTopNoti(v);
  }
}
