import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './config.dart';

// 发送通知功能
class NotiHost {
  final p = AndroidFlutterLocalNotificationsPlugin();

  bool _afterInit = false;

  Future<void> init() async {
    await p.initialize(const AndroidInitializationSettings('ic_noti'));

    _afterInit = true;
  }

  // 发送一次性通知
  Future<void> sendOnceNoti({
    // 通知标题
    required String title,
    // 通知内容
    required String text,
    // 通道 id
    required String channelId,
    // 通道名称
    required String channelName,
    // 通道描述
    required String channelDesc,
    // 通道重要性
    Importance channelImportance = Importance.high,
    // 通道优先级
    Priority channelPriority = Priority.defaultPriority,
    // 可见性
    NotificationVisibility channelVisibility = NotificationVisibility.private,
  }) async {
    if (!_afterInit) {
      await init();
    }

    final androidChannel = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      importance: channelImportance,
      priority: channelPriority,
      visibility: channelVisibility,
    );
    // 获取当前最大通知 id
    var maxId = notiIdOnceMin;
    // id = 1 保留给常驻通知
    final notiList = await p.getActiveNotifications();
    if (notiList != null && notiList.isNotEmpty) {
      // BUG: id = 2147483647
      final n = notiList.map((x) => x.id).where((x) => x < 2147483647).toList();
      // 注意 Android 系统会限制一个应用最多可显示的通知条数
      final m = n.reduce((a, b) => a > b ? a : b);
      if (m > maxId) {
        maxId = m;
      }
    }
    // 显示通知
    await p.show(
      maxId + 1,
      title,
      text,
      notificationDetails: androidChannel,
    );
  }

  // 开启/更新常驻通知
  Future<void> startTopNoti({
    // 通知标题
    required String title,
    // 通知内容
    required String text,
    // 通道 id
    required String channelId,
    // 通道名称
    required String channelName,
    // 通道描述
    required String channelDesc,
    // 通道重要性
    Importance channelImportance = Importance.high,
    // 通道优先级
    Priority channelPriority = Priority.defaultPriority,
    // 可见性
    NotificationVisibility channelVisibility = NotificationVisibility.private,
  }) async {
    if (!_afterInit) {
      await init();
    }

    final androidChannel = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      importance: channelImportance,
      priority: channelPriority,
      visibility: channelVisibility,
    );

    await p.startForegroundService(
      notiIdTop,
      title,
      text,
      notificationDetails: androidChannel,
    );
  }

  // 停止常驻通知
  Future<void> stopTopNoti() async {
    await p.stopForegroundService();
  }
}
