import 'dart:async';
import 'package:meta/meta.dart';
//import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import '../../../bridge/bridge.dart';
import '../t.dart';
import '../config.dart';
import '../kb_layout.dart';

// 配置状态
@immutable
class ConfigState {
  const ConfigState({
    required this.kbLayout,
    required this.toolShowEditorInfo,
    required this.clipEnable,
    required this.clipLog,
    required this.clipTopNoti,
    required this.clipUpdateNoti,
    required this.logPerf,
    required this.logInput,
    required this.corePinyinMode,
  });
  const ConfigState.createDefault()
      : kbLayout = layoutQwerty,
        toolShowEditorInfo = false,
        clipEnable = false,
        clipLog = false,
        clipTopNoti = false,
        clipUpdateNoti = false,
        logPerf = true,
        logInput = false,
        corePinyinMode = cvCorePinyinModeSpZirjma;

  // 键盘布局 (26 键)
  final KbLayoutT kbLayout;
  // 小工具界面下方显示 EditorInfo
  final bool toolShowEditorInfo;

  // 启用剪切板管理器
  final bool clipEnable;
  // 启用剪切板日志
  final bool clipLog;
  // 启用剪切板内容通知
  final bool clipTopNoti;
  // 启用剪切板变更通知
  final bool clipUpdateNoti;

  // 启用性能日志
  final bool logPerf;
  // 启用输入日志
  final bool logInput;

  // 拼音模式
  final String corePinyinMode;

  ConfigState copy({
    KbLayoutT? kbLayout,
    bool? toolShowEditorInfo,
    bool? clipEnable,
    bool? clipLog,
    bool? clipTopNoti,
    bool? clipUpdateNoti,
    bool? logPerf,
    bool? logInput,
    String? corePinyinMode,
  }) {
    return ConfigState(
      kbLayout: kbLayout ?? this.kbLayout,
      toolShowEditorInfo: toolShowEditorInfo ?? this.toolShowEditorInfo,
      clipEnable: clipEnable ?? this.clipEnable,
      clipLog: clipLog ?? this.clipLog,
      clipTopNoti: clipTopNoti ?? this.clipTopNoti,
      clipUpdateNoti: clipUpdateNoti ?? this.clipUpdateNoti,
      logPerf: logPerf ?? this.logPerf,
      logInput: logInput ?? this.logInput,
      corePinyinMode: corePinyinMode ?? this.corePinyinMode,
    );
  }

  // 根据名称设置键盘布局
  ConfigState setKbLayout(String? name) {
    // 默认布局
    var layout = layoutQwerty;
    switch (name) {
      case layoutAbcd7109Name:
        layout = layoutAbcd7109;
        break;
      //case layoutQwertyName:
    }
    return copy(
      kbLayout: layout,
    );
  }

  // 加载 UI 配置
  Future<ConfigState> loadUiConfig(UiConfigHost uch) async {
    // 清空 shared_preferences 插件的缓存
    await uch.reload();
    // 键盘布局
    var layout = await uch.getKbLayout();
    layout ??= kbLayoutDefault;
    // 显示 EditorInfo
    var showEditorInfo = await uch.getShowEditorInfo();

    // 启用剪切板管理器
    var clipEnable = await uch.getClipEnable();
    // 启用剪切板日志
    var clipLog = await uch.getClipLog();
    // 启用剪切板内容通知
    var clipTopNoti = await uch.getClipTopNoti();
    // 启用剪切板变更通知
    var clipUpdateNoti = await uch.getClipUpdateNoti();

    // 启用性能日志
    var logPerf = await uch.getLogPerf();
    // 启用输入日志
    var logInput = await uch.getLogInput();

    // 拼音模式
    var corePinyinMode = await uch.getCorePinyinMode();

    return setKbLayout(layout).copy(
      toolShowEditorInfo: showEditorInfo,
      clipEnable: clipEnable,
      clipLog: clipLog,
      clipTopNoti: clipTopNoti,
      clipUpdateNoti: clipUpdateNoti,
      logPerf: logPerf,
      logInput: logInput,
      corePinyinMode: corePinyinMode,
    );
  }
}
