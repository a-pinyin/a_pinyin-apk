import 'dart:async';
import '../kv/simple_keyboard/host/config_state.dart';
import './si.dart';
import './log/t.dart';

// 剪切板基础功能
class ClipHost {
  // 启用剪切板管理器
  bool _enable = false;
  // 启用剪切板日志
  bool _enableLog = false;
  // 启用剪切板内容通知
  bool _enableTopNoti = false;
  // 启用剪切板变更通知
  bool _enableUpdateNoti = false;

  Future<void> setConfig(ConfigState config, {bool init = false}) async {
    // 检测配置变更
    final configUpdate = (_enable != config.clipEnable) ||
        (_enableLog != config.clipLog) ||
        (_enableTopNoti != config.clipTopNoti) ||
        (_enableUpdateNoti != config.clipUpdateNoti);

    // 更新配置
    _enable = config.clipEnable;
    _enableLog = config.clipLog;
    _enableTopNoti = config.clipTopNoti;
    _enableUpdateNoti = config.clipUpdateNoti;

    // 处理配置
    if (configUpdate) {
      // TODO
    }
    // 初始化日志
    if (init) {
      // TODO

      final log = getLogHost();
      final time = log.getTime();
      await log.logPerf(
        time,
        LogItem(
          time: time,
          code: perfCodeInitClip,
          data: {
            'clipEnable': _enable.toString(),
            'clipLog': _enableLog.toString(),
            'clipTopNoti': _enableTopNoti.toString(),
            'clipUpdateNoti': _enableUpdateNoti.toString(),
          },
        ).toJson(),
      );
    }
  }

  // TODO
}
