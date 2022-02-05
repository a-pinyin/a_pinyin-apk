import 'dart:async';
import 'package:flutter/material.dart';
import '../../bridge/bridge.dart';
import '../../c/simple_page.dart';
import '../../kv/simple_keyboard/config.dart';
import './config_show_editor_info.dart';
import './config_kb_layout.dart';

// 设置页面
class PageConfig extends StatefulWidget {
  const PageConfig({Key? key}) : super(key: key);

  @override
  _PageConfigState createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {
  SuperBus sb = getSb();
  UiConfigHost uch = getUiConfigHost();

  bool afterLoadConfig = false;
  // 具体配置项

  // 键盘布局 (名称)
  String configKbLayout = kbLayoutDefault;
  // kv_tool 显示 EditorInfo
  bool configShowEditorInfo = false;

  Future<void> loadConfig({bool reload = false}) async {
    if (reload) {
      await uch.reload();
    }

    var kbLayout = await uch.getKbLayout();
    var showEditorInfo = await uch.getShowEditorInfo();

    setState(() {
      if (kbLayout != null) {
        configKbLayout = kbLayout;
      }
      configShowEditorInfo = showEditorInfo;

      afterLoadConfig = true;
    });
  }

  Future<void> afterConfigUpdate() async {
    await loadConfig();
    sb.send(sbmUiConfigUpdate);
  }

  @override
  void initState() {
    super.initState();

    loadConfig(reload: true);
  }

  // 主要配置界面
  Widget configBody(BuildContext context) {
    return ListView(
      children: [
        ConfigKbLayout(
          uch: uch,
          value: configKbLayout,
          onUpdate: afterConfigUpdate,
        ),
        ConfigShowEditorInfo(
          uch: uch,
          value: configShowEditorInfo,
          onUpdate: afterConfigUpdate,
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '设置',
      // 加载中
      child: afterLoadConfig
          ? configBody(context)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
