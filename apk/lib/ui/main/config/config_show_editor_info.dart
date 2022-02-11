import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 设置项: 显示 EditorInfo
class ConfigShowEditorInfo extends ConfigItemSwitch {
  ConfigShowEditorInfo()
      : super(
          title: '显示 EditorInfo',
          text: '在键盘小工具页面显示当前输入文本框的 EditorInfo (用于调试)',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getShowEditorInfo();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setShowEditorInfo(v);
  }
}
