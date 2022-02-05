package org.fm_elpac.a_pinyin.ui

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup.LayoutParams
import android.view.inputmethod.EditorInfo
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// flutter channel bridge
// 处理 flutter 相关的事情
class FcBridge(val service: ImService) : SuperBi {
    private var engine: FlutterEngine? = null
    private var fview: FlutterView? = null
    private var sbBmh: SuperBusBmh? = null
    // 保存 onStartInputView() 的 EditorInfo 信息
    private var session_editorInfo: EditorInfo? = null
    private var session_restarting: Boolean = false
    // 监听剪切板
    private var clipListener: ClipListener = ClipListener()

    // 生命周期函数
    fun onCreate() {
        val fe = FlutterEngine(service)
        // SuperBus
        sbBmh = sbConfigEngine(fe, "FcBridge")
        setMethodChannel(fe)
        // 初始化 FlutterEngine (执行 dart 代码)
        setupFlutterEngine(fe)
        engine = fe

        // SuperBus im
        SB.send(SBM_IM_ON_CREATE)
        // 开始监听剪切板
        getClipboardManager().addPrimaryClipChangedListener(clipListener)
    }

    fun setMethodChannel(engine: FlutterEngine) {
        // MethodChannel
        MethodChannel(engine.dartExecutor.binaryMessenger, IM_CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "im_addText" -> {
                    val text = call.argument<String>("text")
                    if (text != null) {
                        service.im_addText(text)
                        result.success(null)
                    } else {
                        result.error("1", "no argument text", text)
                    }
                }

                "im_sendKeyDown" -> {
                    val keycode = call.argument<Int>("keycode")
                    if (keycode != null) {
                        im_sendKeyDown(keycode)
                        result.success(null)
                    } else {
                        result.error("1", "no argument keycode", keycode)
                    }
                }

                "im_sendKeyUp" -> {
                    val keycode = call.argument<Int>("keycode")
                    if (keycode != null) {
                        im_sendKeyUp(keycode)
                        result.success(null)
                    } else {
                        result.error("1", "no argument keycode", keycode)
                    }
                }

                "im_sendKeyClick" -> {
                    val keycode = call.argument<Int>("keycode")
                    if (keycode != null) {
                        im_sendKeyClick(keycode)
                        result.success(null)
                    } else {
                        result.error("1", "no argument keycode", keycode)
                    }
                }

                "im_sendKey_backspace" -> {
                    im_sendKey_backspace()
                    result.success(null)
                }

                "im_sendKey_delete" -> {
                    im_sendKey_delete()
                    result.success(null)
                }

                "im_sendKey_home" -> {
                    im_sendKey_home()
                    result.success(null)
                }

                "im_sendKey_end" -> {
                    im_sendKey_end()
                    result.success(null)
                }

                "im_sendKey_pageup" -> {
                    im_sendKey_pageup()
                    result.success(null)
                }

                "im_sendKey_pagedown" -> {
                    im_sendKey_pagedown()
                    result.success(null)
                }

                "im_sendKey_enter" -> {
                    im_sendKey_enter()
                    result.success(null)
                }

                "im_sendKey_up" -> {
                    im_sendKey_up()
                    result.success(null)
                }

                "im_sendKey_down" -> {
                    im_sendKey_down()
                    result.success(null)
                }

                "im_sendKey_left" -> {
                    im_sendKey_left()
                    result.success(null)
                }

                "im_sendKey_right" -> {
                    im_sendKey_right()
                    result.success(null)
                }

                "im_getEditorInfo" -> {
                    result.success(im_getEditorInfo())
                }

                "im_sendDefaultEditorAction" -> {
                    val fromEnterKey = call.argument<Boolean>("fromEnterKey")
                    val value = if (fromEnterKey != null && fromEnterKey) true else false
                    service.im_sendDefaultEditorAction(value)
                    result.success(null)
                }

                "im_getSelectedText" -> {
                    result.success(service.im_getSelectedText())
                }

                "im_setSelection" -> {
                    val start = call.argument<Int>("start")
                    val end = call.argument<Int>("end")
                    if (start != null && end != null) {
                        service.im_setSelection(start, end)
                        result.success(null)
                    } else {
                        result.error("1", "no argument start or end", "" + start + " " + end)
                    }
                }

                "im_selectAll" -> {
                    im_selectAll()
                    result.success(null)
                }

                "im_undo" -> {
                    im_undo()
                    result.success(null)
                }

                "im_redo" -> {
                    im_redo()
                    result.success(null)
                }

                "im_clipboardGetText" -> {
                    result.success(im_clipboardGetText())
                }

                "im_clipboardSetText" -> {
                    val text = call.argument<String>("text")
                    if (text != null) {
                        im_clipboardSetText(text)
                        result.success(null)
                    } else {
                        result.error("1", "no argument text", text)
                    }
                }

                "im_clipboardClear" -> {
                    im_clipboardClear()
                    result.success(null)
                }

                "im_setHeightDp" -> {
                    val height = call.argument<Float>("height")
                    if (height != null) {
                        im_setHeightDp(height)
                        result.success(null)
                    } else {
                        result.error("1", "no argument height", height)
                    }
                }

                "im_hideKb" -> {
                    service.im_hideKb()
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }

    fun onCreateInputView(): View {
        val v = FlutterView(service)
        setViewHeightDp(v, KV_HEIGHT_DP)

        fview = v
        // SuperBus im
        SB.send(SBM_IM_ON_CREATE_INPUT_VIEW)

        return v
    }

    fun onBindInput() {
        // SuperBus im
        SB.send(SBM_IM_ON_BIND_INPUT)
    }

    fun onUnbindInput() {
        // SuperBus im
        SB.send(SBM_IM_ON_UNBIND_INPUT)
    }

    fun onStartInputView(info: EditorInfo, restarting: Boolean) {
        // 保存信息
        session_editorInfo = info
        session_restarting = restarting

        // 注意: 必须在此处 attach FlutterView 至 FlutterEngine
        // 否则软键盘不能显示 !
        fview!!.attachToFlutterEngine(engine!!)

        engine?.lifecycleChannel?.appIsResumed()
        // SuperBus im
        SB.send(SBM_IM_ON_START_INPUT_VIEW)
    }

    fun onFinishInput() {
        // SuperBus im
        SB.send(SBM_IM_ON_FINISH_INPUT)

        engine?.lifecycleChannel?.appIsPaused()
    }

    fun onDestroy() {
        // 停止监听剪切板
        getClipboardManager().removePrimaryClipChangedListener(clipListener)
        // SuperBus im
        SB.send(SBM_IM_ON_DESTROY)

        engine?.destroy()
    }

    // 输入事件监听
    fun onGenericMotionEvent(event: MotionEvent): Boolean {
        // TODO
        return false
    }

    fun onKeyDown(keycode: Int, event: KeyEvent): Boolean {
        // TODO
        return false
    }

    fun onKeyMultiple(keycode: Int, count: Int, event: KeyEvent): Boolean {
        // TODO
        return false
    }

    fun onKeyUp(keycode: Int, event: KeyEvent): Boolean {
        // TODO
        return false
    }

    // SuperBus
    override fun sbOnRecv(m: String) {
        // DEBUG
        println("a_pinyin.SB FcBridge recv: " + m)
        // send to dart
        sbBmh?.send(m)

        // check m
        if (m == SBM_KV_KB_CLOSE) {
            service.im_hideKb()
        }
    }

    // 设置高度, 单位 dp
    private fun setViewHeightDp(view: View, height: Float) {
        // dp -> px
        val d = service.resources.displayMetrics.density
        val px = height * d + 0.5f
        println("a_pinyin.FcBridge.setViewHeightDp  dp = " + height + "  d = " + d + "  px = " + px)

        view.setLayoutParams(LayoutParams(-1, px.toInt()))
    }

    // [bridge 可调用函数]
    // 设置软键盘高度, 单位 dp
    fun im_setHeightDp(height: Float) {
        if (fview != null) {
            setViewHeightDp(fview!!, height)
        }
    }

    // [bridge 可调用函数]
    // 获取 EditorInfo
    fun im_getEditorInfo(): HashMap<String, String> {
        return formatEditorInfo(session_editorInfo, session_restarting)
    }

    // [bridge 可调用函数]
    // 发送键按下
    fun im_sendKeyDown(keycode: Int, meta: Int = 0) {
        service.sendKeyEvent(createKeyEvent(keycode, KeyEvent.ACTION_DOWN, meta))
    }

    // [bridge 可调用函数]
    // 发送键释放
    fun im_sendKeyUp(keycode: Int, meta: Int = 0) {
        service.sendKeyEvent(createKeyEvent(keycode, KeyEvent.ACTION_UP, meta))
    }

    // [bridge 可调用函数]
    // 发送按下并松开一个按键
    fun im_sendKeyClick(keycode: Int, meta: Int = 0) {
        im_sendKeyDown(keycode, meta)
        im_sendKeyUp(keycode, meta)
    }

    // [bridge 可调用函数]
    // 发送退格 Backspace 键
    fun im_sendKey_backspace() {
        im_sendKeyClick(KeyEvent.KEYCODE_DEL)
    }

    // [bridge 可调用函数]
    // 发送 Delete 键 (编辑键区)
    fun im_sendKey_delete() {
        im_sendKeyClick(KeyEvent.KEYCODE_FORWARD_DEL)
    }

    // [bridge 可调用函数]
    // 发送 Home 键 (编辑键区)
    fun im_sendKey_home() {
        im_sendKeyClick(KeyEvent.KEYCODE_MOVE_HOME)
    }

    // [bridge 可调用函数]
    // 发送 End 键 (编辑键区)
    fun im_sendKey_end() {
        im_sendKeyClick(KeyEvent.KEYCODE_MOVE_END)
    }

    // [bridge 可调用函数]
    // 发送 PageUp 键 (编辑键区)
    fun im_sendKey_pageup() {
        im_sendKeyClick(KeyEvent.KEYCODE_PAGE_UP)
    }

    // [bridge 可调用函数]
    // 发送 PageDown 键 (编辑键区)
    fun im_sendKey_pagedown() {
        im_sendKeyClick(KeyEvent.KEYCODE_PAGE_DOWN)
    }

    // [bridge 可调用函数]
    // 发送回车键
    fun im_sendKey_enter() {
        im_sendKeyClick(KeyEvent.KEYCODE_ENTER)
    }

    // [bridge 可调用函数]
    // 方向键: 上
    fun im_sendKey_up() {
        im_sendKeyClick(KeyEvent.KEYCODE_DPAD_UP)
    }

    // [bridge 可调用函数]
    // 方向键: 下
    fun im_sendKey_down() {
        im_sendKeyClick(KeyEvent.KEYCODE_DPAD_DOWN)
    }

    // [bridge 可调用函数]
    // 方向键: 左
    fun im_sendKey_left() {
        im_sendKeyClick(KeyEvent.KEYCODE_DPAD_LEFT)
    }

    // [bridge 可调用函数]
    // 方向键: 右
    fun im_sendKey_right() {
        im_sendKeyClick(KeyEvent.KEYCODE_DPAD_RIGHT)
    }

    // [bridge 可调用函数]
    // 全选
    fun im_selectAll() {
        // 此 全选 的实现方法来自  FlorisBoard <https://github.com/florisboard/florisboard>
        // Ctrl+A
        im_sendKeyClick(KeyEvent.KEYCODE_A, KeyEvent.META_CTRL_LEFT_ON)
    }

    // [bridge 可调用函数]
    // 撤销
    fun im_undo() {
        // 此 撤销 的实现方法来自  FlorisBoard <https://github.com/florisboard/florisboard>
        // Ctrl+Z
        im_sendKeyClick(KeyEvent.KEYCODE_Z, KeyEvent.META_CTRL_LEFT_ON)
    }

    // [bridge 可调用函数]
    // 重做
    fun im_redo() {
        // 此 重做 的实现方法来自  FlorisBoard <https://github.com/florisboard/florisboard>
        // Ctrl+Shift+Z
        im_sendKeyClick(KeyEvent.KEYCODE_Z, KeyEvent.META_CTRL_LEFT_ON or KeyEvent.META_SHIFT_LEFT_ON)
    }

    // Android 剪切板
    fun getClipboardManager(): ClipboardManager {
        return service.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
    }

    // [bridge 可调用函数]
    // 获取剪切板文本
    fun im_clipboardGetText(): List<String> {
        var data = getClipboardManager().getPrimaryClip()
        if (data != null) {
            return formatClipData(data, service)
        }
        return listOf()
    }

    // [bridge 可调用函数]
    // 设置剪切板文本
    fun im_clipboardSetText(text: String) {
        getClipboardManager().setPrimaryClip(ClipData.newPlainText(text, text))
    }

    // [bridge 可调用函数]
    // 清空剪切板
    fun im_clipboardClear() {
        getClipboardManager().clearPrimaryClip()
    }

    // 监听剪切板变更
    class ClipListener : ClipboardManager.OnPrimaryClipChangedListener {
        override fun onPrimaryClipChanged() {
            // 广播
            SB.send(SBM_IM_CLIP_UPDATE)
        }
    }
}
