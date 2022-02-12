import 'dart:async';
import 'package:meta/meta.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import '../../../bridge/bridge.dart';
import '../t.dart';
import './keyboard_input.dart';
import './config_state.dart';
import './pinyin_state.dart';

// 键盘状态 (总状态)
@immutable
class KeyboardState {
  const KeyboardState({
    LoadCallback? callback,
    required this.input,
    required this.config,
    required this.pinyin,
    required this.kbHideMode,
    required this.pinyinMode,
    required this.editorInfo,
    required this.currentTop,
  }) : _callback = callback;
  const KeyboardState.createDefault()
      : _callback = null,
        input = const KeyboardInput(),
        config = const ConfigState.createDefault(),
        pinyin = const PinyinState.createDefault(),
        kbHideMode = false,
        pinyinMode = false,
        editorInfo = const IMapConst({}),
        currentTop = TopType.pinyin;

  // 用于更新状态
  final LoadCallback? _callback;

  final KeyboardInput input;
  final ConfigState config;
  final PinyinState pinyin;

  // 键盘整体状态

  // 隐藏下方键盘区域模式 (比如硬件键盘, 语音输入等)
  final bool kbHideMode;
  // 当前处于拼音输入模式
  final bool pinyinMode;
  // 输入信息
  final EditorInfo editorInfo;

  // 当前顶部激活类型
  final TopType currentTop;

  KeyboardState copy({
    KeyboardInput? input,
    ConfigState? config,
    PinyinState? pinyin,
    bool? kbHideMode,
    bool? pinyinMode,
    EditorInfo? editorInfo,
    TopType? currentTop,
  }) {
    return KeyboardState(
      callback: _callback,
      input: input ?? this.input,
      config: config ?? this.config,
      pinyin: pinyin ?? this.pinyin,
      kbHideMode: kbHideMode ?? this.kbHideMode,
      pinyinMode: pinyinMode ?? this.pinyinMode,
      editorInfo: editorInfo ?? this.editorInfo,
      currentTop: currentTop ?? this.currentTop,
    );
  }

  KeyboardState setCallback(LoadCallback? callback) {
    return KeyboardState(
      callback: callback,
      input: input,
      config: config,
      pinyin: pinyin,
      kbHideMode: kbHideMode,
      pinyinMode: pinyinMode,
      editorInfo: editorInfo,
      currentTop: currentTop,
    );
  }

  // 加载 UI 配置
  Future<void> loadUiConfig(UiConfigHost uch, {bool first = false}) async {
    // DEBUG
    print('kv.SimpleKeyboard  loadUiConfig()  first = ' + first.toString());

    final c = await config.loadUiConfig(uch);
    // 同步合并状态
    final cb = _callback;
    if (cb != null) {
      cb.setState(cb.getState().copy(
            config: c,
          ));
    }

    // 设置 LogHost
    final log = getLogHost();
    log.setEnablePerf(c.logPerf);
    log.setEnableInput(c.logInput);
    // 设置 clip
    await getClipHost().setConfig(c, init: first);
  }

  // 获取 EditorInfo
  // async callback
  Future<void> loadEditorInfo(ImChannel im) async {
    final info = await im.getEditorInfo();
    // TODO 更多处理 ?  比如自动切换到数字键盘

    // 同步合并状态
    final cb = _callback;
    if (cb != null && info != null) {
      // 处理 info 的 null 值
      for (var i in info.keys) {
        if (info[i] == null) {
          info[i] = '';
        }
      }

      cb.setState(cb.getState().copy(
            editorInfo: IMap(info),
          ));
    }
  }

  // 初始化加载
  void initLoad({
    required UiConfigHost uch,
    required ImChannel im,
  }) {
    loadUiConfig(uch, first: true);
    loadEditorInfo(im);
  }

  // 顶部点击
  void onTopClick(TopType t) {
    // TODO 更多状态处理
    if (t == TopType.rbtn) {
      input.closeKb();
    } else {
      _callback?.setState(copy(
        currentTop: t,
      ));
    }
  }
}

// 解决异步加载的数据丢失问题 (同步合并)
class LoadCallback {
  const LoadCallback({
    required this.getState,
    required this.setState,
  });

  final KeyboardState Function() getState;
  final void Function(KeyboardState state) setState;
}
