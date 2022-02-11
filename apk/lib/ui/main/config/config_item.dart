import 'dart:async';
import 'package:flutter/material.dart';
import '../../bridge/bridge.dart';

// 抽象封装的配置项
class ConfigItem extends StatefulWidget {
  const ConfigItem({
    Key? key,
    required this.data,
    required this.impl,
    required this.onUpdate,
  }) : super(key: key);

  final ConfigItemData data;
  final ConfigItemImpl impl;
  // 配置变更之后
  final void Function() onUpdate;

  @override
  _ConfigItemState createState() => _ConfigItemState();
}

class ConfigItemData {
  const ConfigItemData({
    required this.uch,
    required this.onMount,
    required this.onLoad,
  });

  final UiConfigHost uch;
  // 刚刚挂载完成
  final void Function() onMount;
  // 初始化加载完成
  final void Function() onLoad;
}

class _ConfigItemState extends State<ConfigItem> {
  late ConfigItemHost h;

  Future<void> onUpdate({bool first = false}) async {
    // 重新加载配置
    await widget.impl.loadConfig(h);
    if (first) {
      widget.data.onLoad();
    } else {
      // 通知变更
      widget.onUpdate();
    }
    // 刷新
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    h = ConfigItemHost(
      uch: widget.data.uch,
      onUpdate: onUpdate,
    );

    widget.data.onMount();
    onUpdate(first: true);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.impl.title),
      subtitle: Text(widget.impl.text),
      trailing: widget.impl.build(context, h),
    );
  }
}

// 具体实现的配置项可调用的部分
class ConfigItemHost {
  const ConfigItemHost({
    required this.uch,
    required this.onUpdate,
  });

  final UiConfigHost uch;

  // 通知更改
  final void Function() onUpdate;
}

// 实现具体的配置项
abstract class ConfigItemImpl {
  const ConfigItemImpl({
    required this.title,
    String? text,
  }) : _text = text;

  // 标题
  final String title;
  // 描述
  final String? _text;

  String get text {
    var t = _text;
    if (t != null) {
      return t;
    }
    return '';
  }

  // 加载配置
  Future<void> loadConfig(ConfigItemHost ci);

  // 生成右侧的交互组件
  Widget build(BuildContext context, ConfigItemHost ci);
}
