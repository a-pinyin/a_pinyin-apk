import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// config key

// 键盘布局 (名称)
const ckUiKbLayout = 'ui.kv.kb_layout';
// 显示 EditorInfo
const ckUiShowEditorInfo = 'ui.kv.show_editor_info';

// 启用剪切板管理器
const ckUiClipEnable = 'ui.clip.enable';
// 启用剪切板日志
const ckUiClipLog = 'ui.clip.log';
// 启用剪切板内容通知
const ckUiClipTopNoti = 'ui.clip.top_noti';
// 启用剪切板变更通知
const ckUiClipUpdateNoti = 'ui.clip.update_noti';

// 启用性能日志
const ckUiLogPerf = 'ui.log.perf';
// 启用输入日志
const ckUiLogInput = 'ui.log.input';

// UI 配置保存工具
class UiConfigHost {
  const UiConfigHost();

  Future<SharedPreferences> p() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> reload() async {
    await (await p()).reload();
  }

  // 通用值方法
  Future<String?> getString(String k) async {
    return (await p()).getString(k);
  }

  Future<void> setString(String k, String value) async {
    await (await p()).setString(k, value);
  }

  Future<bool> getBool(String k) async {
    var value = (await p()).getBool(k);
    if (value != null && value) {
      return true;
    }
    return false;
  }

  Future<void> setBool(String k, bool value) async {
    await (await p()).setBool(k, value);
  }

  // 键盘布局
  Future<String?> getKbLayout() async {
    return await getString(ckUiKbLayout);
  }

  Future<void> setKbLayout(String name) async {
    await setString(ckUiKbLayout, name);
  }

  // 显示 EditorInfo
  Future<bool> getShowEditorInfo() async {
    return await getBool(ckUiShowEditorInfo);
  }

  Future<void> setShowEditorInfo(bool show) async {
    await setBool(ckUiShowEditorInfo, show);
  }

  // 启用剪切板管理
  Future<bool> getClipEnable() async {
    return await getBool(ckUiClipEnable);
  }

  Future<void> setClipEnable(bool enable) async {
    await setBool(ckUiClipEnable, enable);
  }

  // 启用剪切板日志
  Future<bool> getClipLog() async {
    return await getBool(ckUiClipLog);
  }

  Future<void> setClipLog(bool enable) async {
    await setBool(ckUiClipLog, enable);
  }

  // 启用剪切板内容通知
  Future<bool> getClipTopNoti() async {
    return await getBool(ckUiClipTopNoti);
  }

  Future<void> setClipTopNoti(bool enable) async {
    await setBool(ckUiClipTopNoti, enable);
  }

  // 启用剪切板变更通知
  Future<bool> getClipUpdateNoti() async {
    return await getBool(ckUiClipUpdateNoti);
  }

  Future<void> setClipUpdateNoti(bool enable) async {
    await setBool(ckUiClipUpdateNoti, enable);
  }

  // 启用性能日志
  Future<bool> getLogPerf() async {
    return await getBool(ckUiLogPerf);
  }

  Future<void> setLogPerf(bool enable) async {
    await setBool(ckUiLogPerf, enable);
  }

  // 启用输入日志
  Future<bool> getLogInput() async {
    return await getBool(ckUiLogInput);
  }

  Future<void> setLogInput(bool enable) async {
    await setBool(ckUiLogInput, enable);
  }
}
