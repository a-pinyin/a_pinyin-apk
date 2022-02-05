import 'dart:async';
import '../../../bridge/bridge.dart';

// 提供输入功能 (对底层接口的封装)
class KeyboardInput {
  const KeyboardInput({
    this.im,
    this.sb,
  });

  final ImChannel? im;
  final SuperBus? sb;

  // 关闭软键盘
  void closeKb() {
    sb?.send(sbmKvKbClose);
  }

  // 输入文本
  Future<void> addText(String text) async {
    await im?.addText(text);
  }

  // 退格键
  Future<void> backspace() async {
    await im?.sendKeyAbackspace();
  }

  // Enter 键
  Future<void> enter() async {
    await im?.sendKeyAenter();
  }

  // 复制
  // 返回复制的文本
  Future<String?> copy() async {
    var i = im;
    if (i != null) {
      var text = await i.getSelectedText();
      if (text != null) {
        await i.clipboardSetText(text);
      }
      return text;
    }
  }

  // 剪切
  Future<void> cut() async {
    var text = await copy();
    // 如果有选中的文本, 发送退格键删除它
    if (text != null) {
      await im?.sendKeyAbackspace();
    }
  }

  // 全选
  Future<void> selectAll() async {
    await im?.selectAll();
  }

  // 粘贴
  Future<void> paste() async {
    var i = im;
    if (i != null) {
      var list = await i.clipboardGetText();
      if (list != null && list.isNotEmpty) {
        await i.addText(list.join('\n'));
      }
    }
  }

  // 方向键: 上
  Future<void> up() async {
    await im?.sendKeyAup();
  }

  // 方向键: 下
  Future<void> down() async {
    await im?.sendKeyAdown();
  }

  // 方向键: 左
  Future<void> left() async {
    await im?.sendKeyAleft();
  }

  // 方向键: 右
  Future<void> right() async {
    await im?.sendKeyAright();
  }

  // 撤销
  Future<void> undo() async {
    await im?.undo();
  }

  // 重做
  Future<void> redo() async {
    await im?.redo();
  }
}
