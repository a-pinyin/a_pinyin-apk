// 集中类型定义
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

// 顶部激活类型
enum TopType {
  // 小工具界面
  tool,
  // 右侧按钮点击
  rbtn,

  // 字母输入 (A)
  letter,
  // 拼音输入 (拼)
  pinyin,
  // 数字输入 (2)
  number,
  // ASCII 符号输入 (@)
  symbol,
  // 更多符号输入 (。)
  symbol2,
}

// 输入信息
typedef EditorInfo = IMap<String, String>;

// 开始: 键盘布局 的类型

// 用于自定义键盘布局的 键 (元素) 类型
enum LayoutKeyType {
  // 普通文本按键 (宽度: 1)
  text,
  // 小空白 (宽度: 0.5), 用于键盘布局 (对齐)
  white,
  // 退格键 (宽度: 1.5)
  backspace,
  // 特殊键 (宽度: 1.5), shift/reset
  special,
}

class LayoutKeyItem {
  const LayoutKeyItem(this.type, this.text, this.text2);
  const LayoutKeyItem.noText(this.type)
      : text = null,
        text2 = null;
  const LayoutKeyItem.text(this.text, this.text2) : type = LayoutKeyType.text;

  final LayoutKeyType type;
  final String? text;
  final String? text2; // shift
}

// 一个键盘布局 (immutable)
typedef KbLayoutT = IList<IList<LayoutKeyItem>>;

// 结束: 键盘布局 的类型
