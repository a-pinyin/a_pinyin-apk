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
  });
  const ConfigState.createDefault()
      : kbLayout = layoutQwerty,
        toolShowEditorInfo = false;

  // 键盘布局 (26 键)
  final KbLayoutT kbLayout;
  // 小工具界面下方显示 EditorInfo
  final bool toolShowEditorInfo;

  ConfigState copy({
    KbLayoutT? kbLayout,
    bool? toolShowEditorInfo,
  }) {
    return ConfigState(
      kbLayout: kbLayout ?? this.kbLayout,
      toolShowEditorInfo: toolShowEditorInfo ?? this.toolShowEditorInfo,
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

    return setKbLayout(layout).copy(
      toolShowEditorInfo: showEditorInfo,
    );
  }
}
