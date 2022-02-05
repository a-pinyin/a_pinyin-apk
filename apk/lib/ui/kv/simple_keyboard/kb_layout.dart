// 内置键盘布局
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import './t.dart';

// 键盘布局名称
const layoutAbcd7109Name = "abcd7109";

// 内置键盘布局: abcd7109
// 3 行
const KbLayoutT layoutAbcd7109 = IListConst([
  IListConst([
    LayoutKeyItem.noText(LayoutKeyType.special),
    LayoutKeyItem.text('a', 'A'),
    LayoutKeyItem.text('b', 'B'),
    LayoutKeyItem.text('c', 'C'),
    LayoutKeyItem.text('d', 'D'),
    LayoutKeyItem.text('e', 'E'),
    LayoutKeyItem.text('f', 'F'),
    LayoutKeyItem.text('g', 'G'),
    LayoutKeyItem.noText(LayoutKeyType.backspace),
  ]),
  IListConst([
    LayoutKeyItem.text('h', 'H'),
    LayoutKeyItem.text('i', 'I'),
    LayoutKeyItem.text('j', 'J'),
    LayoutKeyItem.text('k', 'K'),
    LayoutKeyItem.text('l', 'L'),
    LayoutKeyItem.text('m', 'M'),
    LayoutKeyItem.text('n', 'N'),
    LayoutKeyItem.text('o', 'O'),
    LayoutKeyItem.text('p', 'P'),
    LayoutKeyItem.text('q', 'Q'),
  ]),
  IListConst([
    LayoutKeyItem.noText(LayoutKeyType.white),
    LayoutKeyItem.text('r', 'R'),
    LayoutKeyItem.text('s', 'S'),
    LayoutKeyItem.text('t', 'T'),
    LayoutKeyItem.text('u', 'U'),
    LayoutKeyItem.text('v', 'V'),
    LayoutKeyItem.text('w', 'W'),
    LayoutKeyItem.text('x', 'X'),
    LayoutKeyItem.text('y', 'Y'),
    LayoutKeyItem.text('z', 'Z'),
    LayoutKeyItem.noText(LayoutKeyType.white),
  ]),
]);

// 键盘布局名称
const layoutQwertyName = "qwerty";

// 内置键盘布局: qwerty
const KbLayoutT layoutQwerty = IListConst([
  IListConst([
    LayoutKeyItem.text('q', 'Q'),
    LayoutKeyItem.text('w', 'W'),
    LayoutKeyItem.text('e', 'E'),
    LayoutKeyItem.text('r', 'R'),
    LayoutKeyItem.text('t', 'T'),
    LayoutKeyItem.text('y', 'Y'),
    LayoutKeyItem.text('u', 'U'),
    LayoutKeyItem.text('i', 'I'),
    LayoutKeyItem.text('o', 'O'),
    LayoutKeyItem.text('p', 'P'),
  ]),
  IListConst([
    LayoutKeyItem.noText(LayoutKeyType.white),
    LayoutKeyItem.text('a', 'A'),
    LayoutKeyItem.text('s', 'S'),
    LayoutKeyItem.text('d', 'D'),
    LayoutKeyItem.text('f', 'F'),
    LayoutKeyItem.text('g', 'G'),
    LayoutKeyItem.text('h', 'H'),
    LayoutKeyItem.text('j', 'J'),
    LayoutKeyItem.text('k', 'K'),
    LayoutKeyItem.text('l', 'L'),
    LayoutKeyItem.noText(LayoutKeyType.white),
  ]),
  IListConst([
    LayoutKeyItem.noText(LayoutKeyType.special),
    LayoutKeyItem.text('z', 'Z'),
    LayoutKeyItem.text('x', 'X'),
    LayoutKeyItem.text('c', 'C'),
    LayoutKeyItem.text('v', 'V'),
    LayoutKeyItem.text('b', 'B'),
    LayoutKeyItem.text('n', 'N'),
    LayoutKeyItem.text('m', 'M'),
    LayoutKeyItem.noText(LayoutKeyType.backspace),
  ]),
]);

// 键盘布局名称列表
const layoutNameList = [
  layoutQwertyName,
  layoutAbcd7109Name,
];

// TODO 更多内置键盘布局
