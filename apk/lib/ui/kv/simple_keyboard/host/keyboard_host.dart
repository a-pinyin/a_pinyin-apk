import 'dart:async';
import '../../../bridge/bridge.dart';
import './keyboard_state.dart';
import './keyboard_input.dart';

// 键盘状态总管理
class KeyboardHost {
  KeyboardHost();
  // 更新状态的回调
  void Function(KeyboardState state)? _setStateCallback;

  final ImChannel _im = getImChannel();
  final SuperBus _sb = getSb();
  final LogHost _lh = getLogHost();
  final ClipHost _ch = getClipHost();
  // 监听全局广播
  StreamSubscription? _listener;
  // UI 配置
  final UiConfigHost _uch = getUiConfigHost();

  // 键盘总状态
  KeyboardState _state = getDefaultState();
  // 键盘输入
  KeyboardInput _input = const KeyboardInput();

  // 默认键盘状态
  static KeyboardState getDefaultState() {
    return const KeyboardState.createDefault();
  }

  // 状态更新
  void _updateState(KeyboardState s) {
    _state = s;
    // 回调
    _setStateCallback?.call(_state);
  }

  // 接收全局广播
  void _sbRecv(String m) {
    // DEBUG
    print('kv.SimpleKeyboard SB recv: ' + m);

    if (m == sbmUiConfigUpdate) {
      // 重新加载配置
      _state.loadUiConfig(_uch);
    } else if (m == sbmImOnStartInputView) {
      // 更新 EditorInfo
      _state.loadEditorInfo(_im);
    }
  }

  // 生命周期函数
  void initState(void Function(KeyboardState state) callback) {
    _setStateCallback = callback;
    // 更新键盘输入
    _input = KeyboardInput(im: _im, sb: _sb);
    // 设置状态更新回调, input
    _updateState(_state
        .copy(
          input: _input,
        )
        .setCallback(LoadCallback(
          getState: () => _state,
          setState: _updateState,
        )));

    _init2();
  }

  // 第二阶段初始化
  Future<void> _init2() async {
    // 初始化 LogHost
    await _lh.init();

    // 监听全局广播, 必须在设置状态更新回调之后
    _listener = _sb.listen(_sbRecv);

    // 初始化加载
    _state.initLoad(uch: _uch, im: _im);
  }

  void dispose() {
    // 取消监听
    _listener?.cancel();
  }
}
