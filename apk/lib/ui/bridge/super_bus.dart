import 'dart:async';
import 'package:flutter/services.dart';
import 'package:event_bus/event_bus.dart';
import './config.dart';

// 超级总线: 整个 app 广播 (包括 dart / kotlin)
class SuperBus {
  SuperBus(this.name) {
    Future<String> h(String? m) async {
      // DEBUG
      print('a_pinyin.SB recv dart-' + name + ': ' + (m ?? ''));

      // EventBus 广播 (dart)
      bus.fire(m);

      return '';
    }

    channel.setMessageHandler(h);
  }

  final BasicMessageChannel<String> channel = const BasicMessageChannel(
    sbChannel,
    StringCodec(),
  );

  final String name;
  final EventBus bus = EventBus();

  void send(String m) {
    channel.send(m);
  }

  StreamSubscription listen(void Function(String m) onRecv) {
    return bus.on<String>().listen(onRecv);
  }
}
