package org.fm_elpac.a_pinyin.ui
// 集中常量定义

// FlutterEngine: dart 执行入口: 软键盘界面 (keyboard view)
const val DART_ENTRY_FN = "kvMain"
// FlutterEngine: dart 执行入口的库
const val DART_ENTRY_LIB = "package:a_pinyin/main.dart"

// flutter: im channel 名称
const val IM_CHANNEL = "org.fm_elpac.a_pinyin.ui/im"
// flutter: SuperBus channel 名称
const val SB_CHANNEL = "org.fm_elpac.a_pinyin.ui/sb"

// 软键盘的默认高度, 单位 dp
const val KV_HEIGHT_DP = 280.0f

// SuperBus 共享消息定义
// ImService (kotlin) 广播的 (生命周期) 消息
const val SBM_IM_ON_CREATE = "im.on.create"
const val SBM_IM_ON_CREATE_INPUT_VIEW = "im.on.create_input_view"
const val SBM_IM_ON_BIND_INPUT = "im.on.bind_input"
const val SBM_IM_ON_UNBIND_INPUT = "im.on.unbind_input"
const val SBM_IM_ON_START_INPUT_VIEW = "im.on.start_input_view"
const val SBM_IM_ON_FINISH_INPUT = "im.on.finish_input"
const val SBM_IM_ON_DESTROY = "im.on.destroy"
// 监听到剪切板变更
const val SBM_IM_CLIP_UPDATE = "im.clip.update"
// kv (dart) 要求关闭软键盘
const val SBM_KV_KB_CLOSE = "kv.kb.close"

// flutter_local_notifications
const val CLIP_FOREGROUND_SERVICE_NAME = "com.dexterous.flutterlocalnotifications.ForegroundService"
