package org.fm_elpac.a_pinyin.ui

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.BinaryMessenger.BinaryMessageHandler
import io.flutter.plugin.common.BinaryMessenger.BinaryReply
import io.flutter.plugin.common.StringCodec
import java.nio.ByteBuffer

// 超级总线: 整个 app 广播 (包括 dart / kotlin)
class SuperBus {
    val s: MutableSet<SuperBi> = mutableSetOf()

    // 将自己加入接收队列
    fun onAdd(i: SuperBi) {
        s.add(i)
    }

    // 将自己移出接收队列
    fun onRm(i: SuperBi) {
        s.remove(i)
    }

    // 发送广播消息
    fun send(m: String) {
        for (i in s) {
            i.sbOnRecv(m)
        }
    }
}

// SuperBus 接口
interface SuperBi {
    fun sbOnRecv(m: String)
}

// recv msg
class SuperBusBmh(val bm: BinaryMessenger, val name: String) : BinaryMessageHandler {
    override fun onMessage(message: ByteBuffer?, reply: BinaryReply) {
        // 直接忽略不能解码的消息
        if (message != null) {
            var m = StringCodec.INSTANCE.decodeMessage(message)
            if (m != null) {
                onRecv(m)
            }
        }
    }

    private fun onRecv(m: String) {
        // 广播
        SB.send(m)
    }

    fun send(m: String) {
        bm.send(SB_CHANNEL, StringCodec.INSTANCE.encodeMessage(m))
    }
}

// 配置 FlutterEngine
fun sbConfigEngine(engine: FlutterEngine, name: String): SuperBusBmh {
    var bm = engine.dartExecutor.binaryMessenger
    var bmh = SuperBusBmh(bm, name)
    bm.setMessageHandler(SB_CHANNEL, bmh)
    return bmh
}
