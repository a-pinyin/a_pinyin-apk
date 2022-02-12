import 'dart:async';
import '../kv/simple_keyboard/host/config_state.dart';
import './config.dart';
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

    // 初始化日志
    if (init) {
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

      await writeClipLog(code: clipCodeInit);
    }

    // 处理配置
    if (configUpdate) {
      if (_enableLog) {
        await writeClipLog(code: clipCodeInit);
      }
      // 剪切板内容常驻通知
      if (_enableTopNoti) {
        await showTopNoti();
      } else {
        await closeTopNoti();
      }
    }
  }

  // 获取当前剪切板内容
  Future<String> getClipText() async {
    var text = '';
    final c = await getImChannel().clipboardGetText();
    if (c != null && c.isNotEmpty) {
      text = c.join('\n');
    }
    return text;
  }

  Future<void> writeClipLog({String code = clipCodeUpdate}) async {
    if (!_enableLog) {
      return;
    }
    final log = getLogHost();
    final time = log.getTime();
    await log.logClip(
      time,
      LogItem(
        time: time,
        code: code,
        text: await getClipText(),
      ).toJson(),
    );
    // 剪切板日志立即刷新
    await log.flush();
  }

  // 发送剪切板变更通知
  Future<void> sendClipUpdateNoti() async {
    if (!_enableUpdateNoti) {
      return;
    }
    final text = await getClipText();
    if (text.isNotEmpty) {
      await getNotiHost().sendOnceNoti(
        title: '剪切板变更',
        text: text,
        channelId: 'a_pinyin.clip_update_noti',
        channelName: '剪切板变更',
        channelDesc: '监听到剪切板变更之后发出通知',
      );
    }
  }

  // 显示/更新常驻通知
  Future<void> showTopNoti() async {
    final text = await getClipText();
    await getNotiHost().startTopNoti(
      title: '剪切板内容',
      text: text,
      channelId: 'a_pinyin.clip_top_noti',
      channelName: '剪切板内容',
      channelDesc: '显示当前剪切板内容的常驻通知',
    );
  }

  // 关闭常驻通知
  Future<void> closeTopNoti() async {
    await getNotiHost().stopTopNoti();
  }

  Future<void> sbRecv(String m) async {
    if (m == sbmImClipUpdate) {
      await writeClipLog();
      await sendClipUpdateNoti();
      if (_enableTopNoti) {
        await showTopNoti();
      }
    } else if (m == sbmImOnDestroy) {
      await closeTopNoti();
    }
  }
}
