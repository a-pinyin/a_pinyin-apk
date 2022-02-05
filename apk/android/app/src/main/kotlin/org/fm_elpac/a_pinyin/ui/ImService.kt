package org.fm_elpac.a_pinyin.ui

import android.inputmethodservice.InputMethodService
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.LinearLayout

// Android 输入法服务, 仅关注面向 Android 系统的接口部分
class ImService : InputMethodService(), SuperBi {
    private var bridge: FcBridge = FcBridge(this)

    override fun sbOnRecv(m: String) {
        bridge.sbOnRecv(m)
    }

    // 生命周期函数
    override fun onCreate() {
        super.onCreate()
        // 用于调试 (服务生命周期), 下同
        println("a_pinyin.ImService.onCreate()")
        // SuperBus
        SB.onAdd(this)

        bridge.onCreate()
    }

    // 解决软键盘不显示 (0 高度) 的问题
    private fun wrapHeight(view: View): View {
        val l = LinearLayout(this)
        l.addView(view)
        return l
    }

    override fun onCreateInputView(): View {
        println("a_pinyin.ImService.onCreateInputView()")

        val view = bridge.onCreateInputView()
        return wrapHeight(view)
    }

    override fun onBindInput() {
        super.onBindInput()
        println("a_pinyin.ImService.onBindInput()")
        bridge.onBindInput()
    }
    override fun onUnbindInput() {
        super.onUnbindInput()
        println("a_pinyin.ImService.onUnbindInput()")
        bridge.onUnbindInput()
    }

    // 软键盘显示
    override fun onStartInputView(info: EditorInfo, restarting: Boolean) {
        println("a_pinyin.ImService.onStartInputView()")
        bridge.onStartInputView(info, restarting)
    }

    // 软键盘隐藏
    override fun onFinishInput() {
        println("a_pinyin.ImService.onFinishInput()")
        bridge.onFinishInput()
    }

    override fun onDestroy() {
        super.onDestroy()
        println("a_pinyin.ImService.onDestroy()")
        bridge.onDestroy()
        // SuperBus
        SB.onRm(this)
    }

    // 通用输入事件
    override fun onGenericMotionEvent(event: MotionEvent): Boolean {
        return bridge.onGenericMotionEvent(event)
    }

    // 键按下
    override fun onKeyDown(keycode: Int, event: KeyEvent): Boolean {
        return bridge.onKeyDown(keycode, event)
    }

    // 键重复
    override fun onKeyMultiple(keycode: Int, count: Int, event: KeyEvent): Boolean {
        return bridge.onKeyMultiple(keycode, count, event)
    }

    // 键释放
    override fun onKeyUp(keycode: Int, event: KeyEvent): Boolean {
        return bridge.onKeyUp(keycode, event)
    }

    // [bridge 可调用函数]
    // 关闭软键盘
    fun im_hideKb() {
        // run on ui thread
        hideWindow()
    }

    // [bridge 可调用函数]
    // 输入文本
    fun im_addText(text: String) {
        currentInputConnection.commitText(text, 1)
    }

    fun sendKeyEvent(event: KeyEvent) {
        currentInputConnection.sendKeyEvent(event)
    }

    // [bridge 可调用函数]
    // 发送编辑器默认动作 (比如: 搜索)
    fun im_sendDefaultEditorAction(fromEnterKey: Boolean) {
        sendDefaultEditorAction(fromEnterKey)
    }

    // [bridge 可调用函数]
    // 发送字符
    fun im_sendKeyChar(code: Char) {
        sendKeyChar(code)
    }

    // [bridge 可调用函数]
    // 获取选择的文本 (复制)
    fun im_getSelectedText(): String? {
        return currentInputConnection.getSelectedText(0)?.toString()
    }

    // [bridge 可调用函数]
    // 设置选择的文本 (比如: 全选)
    fun im_setSelection(start: Int, end: Int) {
        currentInputConnection.setSelection(start, end)
    }
}
