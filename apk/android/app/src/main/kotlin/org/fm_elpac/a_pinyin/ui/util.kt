package org.fm_elpac.a_pinyin.ui
// 工具函数

import android.content.ClipData
import android.content.Context
import android.os.SystemClock
import android.text.InputType
import android.util.StringBuilderPrinter
import android.view.KeyEvent
import android.view.inputmethod.EditorInfo
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint

// 初始化配置 FlutterEngine (执行 dart 代码)
fun setupFlutterEngine(engine: FlutterEngine) {
    val de = DartEntrypoint.createDefault()
    // 执行软键盘界面的 dart 代码
    //
    // https://github.com/flutter/flutter/issues/91841
    // 需要使用 Library 限定, 否则 release 模式崩溃
    val ep = DartEntrypoint(de.pathToBundle, DART_ENTRY_LIB, DART_ENTRY_FN)
    // DEBUG
    println("a_pinyin.setupFlutterEngine()  DartEntrypoint.pathToBundle = " + ep.pathToBundle)
    println("a_pinyin.setupFlutterEngine()  DartEntrypoint.dartEntrypointLibrary = " + ep.dartEntrypointLibrary)
    println("a_pinyin.setupFlutterEngine()  DartEntrypoint.dartEntrypointFunctionName = " + ep.dartEntrypointFunctionName)

    engine.dartExecutor.executeDartEntrypoint(ep)
}

// 创建 KeyEvent
// meta: ctrl/shift/alt 等按键状态
fun createKeyEvent(keycode: Int, action: Int, meta: Int = 0): KeyEvent {
    // 标准化 meta
    val m = KeyEvent.normalizeMetaState(meta)

    val time = SystemClock.uptimeMillis()

    val ke = KeyEvent(
        time, // downTime
        time, // eventTime
        action, // action
        keycode, // code
        0, // repeat
        m // metaState
    )

    // 软键盘标志
    return KeyEvent.changeFlags(ke, KeyEvent.FLAG_SOFT_KEYBOARD)
}

// 格式化剪切板内容 (强制转为文本)
fun formatClipData(data: ClipData, context: Context): List<String> {
    val count = data.getItemCount()
    val result: MutableList<String> = mutableListOf()
    for (i in 0..(count - 1)) {
        result.add(data.getItemAt(i).coerceToText(context).toString())
    }
    return result
}

// 格式化 EditorInfo (用于调试)
fun formatEditorInfo(ei: EditorInfo?, restarting: Boolean): HashMap<String, String> {
    // bool 值转 String ("0" "1")
    fun bool_str(value: Boolean): String {
        if (value) {
            return "1"
        }
        return "0"
    }

    if (ei == null) {
        return hashMapOf(
            "null" to bool_str(true)
        )
    }

    // 列表拼接文本 : 分隔
    fun list_str(value: List<String>): String {
        return value.joinToString(":")
    }
    // bit 标志转 bool
    fun tb_bool(value: Int, flag: Int): String {
        return bool_str((value and flag) != 0)
    }
    // bit 标志检测
    fun tb(out: MutableList<String>, value: Int, flag: Int, name: String) {
        if ((value and flag) != 0) {
            out.add(name)
        }
    }
    // mask 之后比较值
    fun tm(out: MutableList<String>, value: Int, mask: Int, def: Int, name: String) {
        if ((value and mask) == def) {
            out.add(name)
        }
    }

    // inputType
    val inputType: MutableList<String> = mutableListOf()
    val typeClass = ei.inputType and InputType.TYPE_MASK_CLASS
    // inputType: class
    tm(inputType, ei.inputType, InputType.TYPE_MASK_CLASS, InputType.TYPE_CLASS_TEXT, "TYPE_CLASS_TEXT")
    tm(inputType, ei.inputType, InputType.TYPE_MASK_CLASS, InputType.TYPE_CLASS_NUMBER, "TYPE_CLASS_NUMBER")
    tm(inputType, ei.inputType, InputType.TYPE_MASK_CLASS, InputType.TYPE_CLASS_PHONE, "TYPE_CLASS_PHONE")
    tm(inputType, ei.inputType, InputType.TYPE_MASK_CLASS, InputType.TYPE_CLASS_DATETIME, "TYPE_CLASS_DATETIME")
    tm(inputType, ei.inputType, InputType.TYPE_MASK_CLASS, InputType.TYPE_NULL, "TYPE_NULL")
    // inputType: variation
    when (typeClass) {
        InputType.TYPE_CLASS_TEXT -> {
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_NORMAL, "TYPE_TEXT_VARIATION_NORMAL")
            // password
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_PASSWORD, "TYPE_TEXT_VARIATION_PASSWORD")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD, "TYPE_TEXT_VARIATION_VISIBLE_PASSWORD")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_WEB_PASSWORD, "TYPE_TEXT_VARIATION_WEB_PASSWORD")

            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS, "TYPE_TEXT_VARIATION_EMAIL_ADDRESS")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_EMAIL_SUBJECT, "TYPE_TEXT_VARIATION_EMAIL_SUBJECT")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_FILTER, "TYPE_TEXT_VARIATION_FILTER")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_LONG_MESSAGE, "TYPE_TEXT_VARIATION_LONG_MESSAGE")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_PERSON_NAME, "TYPE_TEXT_VARIATION_PERSON_NAME")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_PHONETIC, "TYPE_TEXT_VARIATION_PHONETIC")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_POSTAL_ADDRESS, "TYPE_TEXT_VARIATION_POSTAL_ADDRESS")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_SHORT_MESSAGE, "TYPE_TEXT_VARIATION_SHORT_MESSAGE")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_URI, "TYPE_TEXT_VARIATION_URI")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_WEB_EDIT_TEXT, "TYPE_TEXT_VARIATION_WEB_EDIT_TEXT")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS, "TYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS")
        }
        InputType.TYPE_CLASS_NUMBER -> {
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_NUMBER_VARIATION_NORMAL, "TYPE_NUMBER_VARIATION_NORMAL")
            // password
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_NUMBER_VARIATION_PASSWORD, "TYPE_NUMBER_VARIATION_PASSWORD")
        }
        InputType.TYPE_CLASS_DATETIME -> {
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_DATETIME_VARIATION_NORMAL, "TYPE_DATETIME_VARIATION_NORMAL")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_DATETIME_VARIATION_DATE, "TYPE_DATETIME_VARIATION_DATE")
            tm(inputType, ei.inputType, InputType.TYPE_MASK_VARIATION, InputType.TYPE_DATETIME_VARIATION_TIME, "TYPE_DATETIME_VARIATION_TIME")
        }
    }
    // inputType: flags
    when (typeClass) {
        InputType.TYPE_CLASS_TEXT -> {
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_AUTO_COMPLETE, "TYPE_TEXT_FLAG_AUTO_COMPLETE")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_AUTO_CORRECT, "TYPE_TEXT_FLAG_AUTO_CORRECT")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS, "TYPE_TEXT_FLAG_CAP_CHARACTERS")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_CAP_SENTENCES, "TYPE_TEXT_FLAG_CAP_SENTENCES")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_CAP_WORDS, "TYPE_TEXT_FLAG_CAP_WORDS")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_IME_MULTI_LINE, "TYPE_TEXT_FLAG_IME_MULTI_LINE")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_MULTI_LINE, "TYPE_TEXT_FLAG_MULTI_LINE")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS, "TYPE_TEXT_FLAG_NO_SUGGESTIONS")
        }
        InputType.TYPE_CLASS_NUMBER -> {
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_NUMBER_FLAG_DECIMAL, "TYPE_NUMBER_FLAG_DECIMAL")
            tb(inputType, ei.inputType and InputType.TYPE_MASK_FLAGS, InputType.TYPE_NUMBER_FLAG_SIGNED, "TYPE_NUMBER_FLAG_SIGNED")
        }
    }
    val inputTypeStr = list_str(inputType)
    // password type
    val password = bool_str(inputTypeStr.contains("PASSWORD"))

    // imeOptions
    val imeOptions: MutableList<String> = mutableListOf()
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_DONE, "IME_ACTION_DONE")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_GO, "IME_ACTION_GO")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_NEXT, "IME_ACTION_NEXT")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_NONE, "IME_ACTION_NONE")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_PREVIOUS, "IME_ACTION_PREVIOUS")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_SEARCH, "IME_ACTION_SEARCH")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_SEND, "IME_ACTION_SEND")
    tm(imeOptions, ei.imeOptions, EditorInfo.IME_MASK_ACTION, EditorInfo.IME_ACTION_UNSPECIFIED, "IME_ACTION_UNSPECIFIED")

    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_FORCE_ASCII, "IME_FLAG_FORCE_ASCII")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NAVIGATE_NEXT, "IME_FLAG_NAVIGATE_NEXT")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NAVIGATE_PREVIOUS, "IME_FLAG_NAVIGATE_PREVIOUS")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NO_ACCESSORY_ACTION, "IME_FLAG_NO_ACCESSORY_ACTION")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NO_ENTER_ACTION, "IME_FLAG_NO_ENTER_ACTION")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NO_EXTRACT_UI, "IME_FLAG_NO_EXTRACT_UI")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NO_FULLSCREEN, "IME_FLAG_NO_FULLSCREEN")
    tb(imeOptions, ei.imeOptions, EditorInfo.IME_FLAG_NO_PERSONALIZED_LEARNING, "IME_FLAG_NO_PERSONALIZED_LEARNING")

    // dump
    val dump = StringBuilder()
    ei.dump(StringBuilderPrinter(dump), "")

    return hashMapOf(
        "restarting" to bool_str(restarting),
        "inputType_raw" to ei.inputType.toString(),
        "inputType" to inputTypeStr,
        // 输入类型是密码
        "password" to password,
        // 禁用学习功能标志
        "no_learn" to tb_bool(ei.imeOptions, EditorInfo.IME_FLAG_NO_PERSONALIZED_LEARNING),

        "imeOptions_raw" to ei.imeOptions.toString(),
        "imeOptions" to list_str(imeOptions),
        "privateImeOptions" to ei.privateImeOptions,
        "packageName" to ei.packageName,

        "dump" to dump.toString()
    )
}
