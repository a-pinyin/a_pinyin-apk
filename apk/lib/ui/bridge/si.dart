// 集中单例定义
import './super_bus.dart';
import './im_channel.dart';
import './ui_config.dart';
import './log/log_host.dart';
import './noti.dart';
import './clip.dart';

// SuperBus 单例
SuperBus? _siSb;

SuperBus getSb({String? name}) {
  // 创建单例
  _siSb ??= SuperBus(name ?? '()');
  return _siSb!;
}

// ImChannel 单例
ImChannel _siIm = const ImChannel();

ImChannel getImChannel() {
  return _siIm;
}

// UiConfigHost 单例
UiConfigHost _siUch = const UiConfigHost();

UiConfigHost getUiConfigHost() {
  return _siUch;
}

// LogHost 单例
LogHost _siLh = LogHost();

LogHost getLogHost() {
  return _siLh;
}

// NotiHost 单例
NotiHost _siNh = NotiHost();

NotiHost getNotiHost() {
  return _siNh;
}

// ClipHost 单例
ClipHost _siCh = ClipHost();

ClipHost getClipHost() {
  return _siCh;
}
