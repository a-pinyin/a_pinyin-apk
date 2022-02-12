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
// 监听到剪切板变更
const sbmImClipUpdate = 'im.clip.update';
// kv (dart) 要求关闭软键盘
const sbmKvKbClose = 'kv.kb.close';
// UI (dart-main) 更新了设置 (需要别的组件重新加载配置)
const sbmUiConfigUpdate = 'ui.config.update';

// 日志文件目录
// getExternalStorageDirectory() = /storage/emulated/0/Android/data/org.fm_elpac.a_pinyin.ui/files
// /sdcard/Android/data/org.fm_elpac.a_pinyin.ui/files/log/
const dirLog = 'log';
// 性能日志目录: log/perf/
const dirLogPerf = 'perf';
// 剪切板日志目录: log/clip/
const dirLogClip = 'clip';
// 输入日志目录: log/input/
const dirLogInput = 'input';
// 调试日志目录: log/debug/
const dirLogDebug = 'debug';

// 间隔多久刷写一次日志 (30 秒)
const logFlushTimeMs = 30 * 1000;
// 日志文件后缀
const logFileSuffix = '.log.txt';

// 通知: 最小一次性通知 id
const notiIdOnceMin = 2;
// 常驻通知 id
const notiIdTop = 1;
