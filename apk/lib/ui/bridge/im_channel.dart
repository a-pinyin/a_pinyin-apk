import 'dart:async';
import 'package:flutter/services.dart';
import './config.dart';

// 用于调用 kotlin (ImService/FcBridge) 侧的方法
class ImChannel {
  const ImChannel();
  final MethodChannel ch = const MethodChannel(imChannel);

  // 关闭软键盘 (一般不用)
  Future<void> hideKb() async {
    await ch.invokeMethod<void>('im_hideKb');
  }

  // 输入文本
  Future<void> addText(String text) async {
    await ch.invokeMethod<void>('im_addText', {
      'text': text,
    });
  }

  // 发送键按下
  Future<void> sendKeyDown(int keycode) async {
    await ch.invokeMethod<void>('im_sendKeyDown', {
      'keycode': keycode,
    });
  }

  // 发送键释放
  Future<void> sendKeyUp(int keycode) async {
    await ch.invokeMethod<void>('im_sendKeyUp', {
      'keycode': keycode,
    });
  }

  // 设置软键盘高度
  Future<void> setHeightDp(double height) async {
    await ch.invokeMethod<void>('im_setHeightDp', {
      'height': height,
    });
  }

  // 获取 EditorInfo
  Future<Map<String, String>?> getEditorInfo() async {
    return await ch.invokeMapMethod<String, String>('im_getEditorInfo');
  }

  // 发送按下并松开一个按键
  Future<void> sendKeyClick(int keycode) async {
    await ch.invokeMethod<void>('im_sendKeyClick', {
      'keycode': keycode,
    });
  }

  // 发送退格 Backspace 键
  // fuck dart: sendKey_backspace -> sendKeyAbackspace
  Future<void> sendKeyAbackspace() async {
    await ch.invokeMethod<void>('im_sendKey_backspace');
  }

  // 发送 Delete 键 (编辑键区)
  Future<void> sendKeyAdelete() async {
    await ch.invokeMethod<void>('im_sendKey_delete');
  }

  // 发送 Home 键
  Future<void> sendKeyAhome() async {
    await ch.invokeMethod<void>('im_sendKey_home');
  }

  // 发送 End 键
  Future<void> sendKeyAend() async {
    await ch.invokeMethod<void>('im_sendKey_end');
  }

  // 发送 PageUp 键
  Future<void> sendKeyApageup() async {
    await ch.invokeMethod<void>('im_sendKey_pageup');
  }

  // 发送 PageDown 键
  Future<void> sendKeyApagedown() async {
    await ch.invokeMethod<void>('im_sendKey_pagedown');
  }

  // 发送回车键
  Future<void> sendKeyAenter() async {
    await ch.invokeMethod<void>('im_sendKey_enter');
  }

  // 方向键: 上
  Future<void> sendKeyAup() async {
    await ch.invokeMethod<void>('im_sendKey_up');
  }

  // 方向键: 下
  Future<void> sendKeyAdown() async {
    await ch.invokeMethod<void>('im_sendKey_down');
  }

  // 方向键: 左
  Future<void> sendKeyAleft() async {
    await ch.invokeMethod<void>('im_sendKey_left');
  }

  // 方向键: 右
  Future<void> sendKeyAright() async {
    await ch.invokeMethod<void>('im_sendKey_right');
  }

  // 发送编辑器默认动作
  Future<void> sendDefaultEditorAction({bool fromEnterKey = false}) async {
    await ch.invokeMethod<void>('im_sendDefaultEditorAction', {
      'fromEnterKey': fromEnterKey,
    });
  }

  // 获取选择的文本
  Future<String?> getSelectedText() async {
    return await ch.invokeMethod<String>('im_getSelectedText');
  }

  // 设置选择区域
  Future<void> setSelection(int start, int end) async {
    await ch.invokeMethod<void>('im_setSelection', {
      'start': start,
      'end': end,
    });
  }

  // 全选
  Future<void> selectAll() async {
    await ch.invokeMethod<void>('im_selectAll');
  }

  // 撤销
  Future<void> undo() async {
    await ch.invokeMethod<void>('im_undo');
  }

  // 重做
  Future<void> redo() async {
    await ch.invokeMethod<void>('im_redo');
  }

  // 剪切板获取文本
  Future<List<String>?> clipboardGetText() async {
    return await ch.invokeListMethod<String>('im_clipboardGetText');
  }

  // 剪切板设置文本
  Future<void> clipboardSetText(String text) async {
    await ch.invokeMethod<void>('im_clipboardSetText', {
      'text': text,
    });
  }

  // 剪切板清空
  Future<void> clipboardClear() async {
    await ch.invokeMethod<void>('im_clipboardClear');
  }
}
