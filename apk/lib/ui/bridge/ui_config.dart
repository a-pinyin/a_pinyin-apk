import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// config key

// 键盘布局 (名称)
const ckUiKbLayout = 'ui.kv.kb_layout';

// 在 kv_tool 下方显示 EditorInfo
const ckUiShowEditorInfo = 'ui.kv.show_editor_info';

// UI 配置保存工具
class UiConfigHost {
  const UiConfigHost();

  Future<SharedPreferences> p() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> reload() async {
    await (await p()).reload();
  }

  // 键盘布局
  Future<String?> getKbLayout() async {
    return (await p()).getString(ckUiKbLayout);
  }

  Future<void> setKbLayout(String name) async {
    await (await p()).setString(ckUiKbLayout, name);
  }

  // 显示 EditorInfo
  Future<bool> getShowEditorInfo() async {
    var value = (await p()).getBool(ckUiShowEditorInfo);
    if (value != null && value) {
      return true;
    }
    return false;
  }

  Future<void> setShowEditorInfo(bool show) async {
    await (await p()).setBool(ckUiShowEditorInfo, show);
  }
}
