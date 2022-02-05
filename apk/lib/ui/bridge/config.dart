// 集中常量定义

// SuperBus channel 名称
const sbChannel = 'org.fm_elpac.a_pinyin.ui/sb';
// im channel 名称
const imChannel = 'org.fm_elpac.a_pinyin.ui/im';

// SuperBus 共享消息定义
// ImService (kotlin) 广播的 (生命周期) 消息
const sbmImOnCreate = 'im.on.create';
const sbmImOnCreateInputView = 'im.on.create_input_view';
const sbmImOnBindInput = 'im.on.bind_input';
const sbmImOnUnbindInput = 'im.on.unbind_input';
const sbmImOnStartInputView = 'im.on.start_input_view';
const sbmImOnFinishInput = 'im.on.finish_input';
const sbmImOnDestroy = 'im.on.destroy';
// kv (dart) 要求关闭软键盘
const sbmKvKbClose = 'kv.kb.close';
// UI (dart-main) 更新了设置 (需要别的组件重新加载配置)
const sbmUiConfigUpdate = 'ui.config.update';
