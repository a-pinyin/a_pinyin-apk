package org.fm_elpac.a_pinyin.ui

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity(), SuperBi {
    private var sbBmh: SuperBusBmh? = null

    override fun sbOnRecv(m: String) {
        // DEBUG
        println("a_pinyin.SB MainActivity recv: " + m)
        // send to dart
        sbBmh?.send(m)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // DEBUG
        println("a_pinyin.MainActivity.onCreate()")
        // SuperBus
        SB.onAdd(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        println("a_pinyin.MainActivity.onDestroy()")
        // SuperBus
        SB.onRm(this)
    }

    override fun configureFlutterEngine(engine: FlutterEngine) {
        super.configureFlutterEngine(engine)

        // SuperBus
        sbBmh = sbConfigEngine(engine, "MainActivity")
    }
}
