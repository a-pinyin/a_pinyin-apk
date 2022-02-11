import 'dart:async';
import 'package:flutter/material.dart';
import '../../bridge/bridge.dart';
import '../../c/simple_page.dart';
import './config_item.dart';
import './config_kb_layout.dart';
import './config_show_editor_info.dart';
import './config_clip_enable.dart';
import './config_clip_log.dart';
import './config_clip_top_noti.dart';
import './config_clip_update_noti.dart';

// 设置页面
class PageConfig extends StatefulWidget {
  const PageConfig({Key? key}) : super(key: key);

  @override
  _PageConfigState createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {
  SuperBus sb = getSb();
  UiConfigHost uch = getUiConfigHost();

  // 刷新配置缓存
  bool afterReload = false;
  // 挂载计数
  int countMount = 0;
  // 初始化加载计数
  int countLoad = 0;

  // 具体配置项

  // 键盘布局
  ConfigItemImpl configKbLayout = ConfigKbLayout();
  // 显示 EditorInfo
  ConfigItemImpl configShowEditorInfo = ConfigShowEditorInfo();
  // 启用剪切板管理器
  ConfigItemImpl configClipEnable = ConfigClipEnable();
  // 启用剪切板日志
  ConfigItemImpl configClipLog = ConfigClipLog();
  // 启用剪切板内容通知
  ConfigItemImpl configClipTopNoti = ConfigClipTopNoti();
  // 启用剪切板变更通知
  ConfigItemImpl configClipUpdateNoti = ConfigClipUpdateNoti();

  late ConfigItemData data;

  Future<void> init() async {
    await uch.reload();
    setState(() {
      afterReload = true;
    });
  }

  @override
  void initState() {
    super.initState();
    data = ConfigItemData(
      uch: uch,
      onMount: () {
        // 注意: 此处不能用 setState()
        countMount += 1;
      },
      onLoad: () {
        setState(() {
          countLoad += 1;
        });
      },
    );

    init();
  }

  // 配置变更之后
  void onUpdate() async {
    sb.send(sbmUiConfigUpdate);
  }

  // 加载中显示
  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // 用于初始化加载
  Widget pageBody(BuildContext context) {
    if (afterReload) {
      var done = countMount > 0 && countLoad >= countMount;

      return Stack(
        children: [
          Offstage(
            offstage: done,
            child: loading(),
          ),
          Offstage(
            offstage: !done,
            child: configBody(context),
          ),
        ],
      );
    }
    return loading();
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '设置',
      // 加载中
      child: pageBody(context),
    );
  }

  // 主要配置界面
  Widget configBody(BuildContext context) {
    return ListView(
      children: [
        // kv 界面
        ConfigItem(
          data: data,
          onUpdate: onUpdate,
          impl: configKbLayout,
        ),
        ConfigItem(
          data: data,
          onUpdate: onUpdate,
          impl: configShowEditorInfo,
        ),
        const Divider(),
        // 剪切板管理器
        ConfigItem(
          data: data,
          onUpdate: onUpdate,
          impl: configClipEnable,
        ),
        ConfigItem(
          data: data,
          onUpdate: onUpdate,
          impl: configClipLog,
        ),
        ConfigItem(
          data: data,
          onUpdate: onUpdate,
          impl: configClipTopNoti,
        ),
        ConfigItem(
          data: data,
          onUpdate: onUpdate,
          impl: configClipUpdateNoti,
        ),
        const Divider(),
      ],
    );
  }
}
