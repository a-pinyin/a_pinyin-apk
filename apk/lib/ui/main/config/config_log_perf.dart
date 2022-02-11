import 'dart:async';
import '../../bridge/bridge.dart';
import './config_item_switch.dart';

// 启用性能日志
class ConfigLogPerf extends ConfigItemSwitch {
  ConfigLogPerf()
      : super(
          title: '性能日志',
          text: '用于分析性能及调试等',
        );

  @override
  Future<bool> load(UiConfigHost uch) async {
    return await uch.getLogPerf();
  }

  @override
  Future<void> save(UiConfigHost uch, bool v) async {
    await uch.setLogPerf(v);
  }
}
