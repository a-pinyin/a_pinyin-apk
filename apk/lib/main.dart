import 'package:flutter/material.dart';
import './ui/bridge/init_sb.dart';
import './ui/main/mapp.dart';
import './ui/kv/mapp.dart';

// app 主界面执行入口 (比如设置/关于)
void main() {
  runApp(const InitSb(child: MApp(), name: 'main'));
}

// kv (keyboard view): 软键盘界面执行入口, 必须添加 vm:entry-point 标注
// 否则 release 编译时会因为 tree-shaking 导致此部分代码没有被包含
@pragma('vm:entry-point')
void kvMain() {
  runApp(const InitSb(child: KvApp(), name: 'kv'));
}
