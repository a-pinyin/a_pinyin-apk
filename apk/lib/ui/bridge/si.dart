// 集中单例定义
import './super_bus.dart';
import './im_channel.dart';
import './ui_config.dart';

// SuperBus 单例
SuperBus? siSb;

SuperBus getSb({String? name}) {
  // 创建单例
  siSb ??= SuperBus(name ?? '()');
  return siSb!;
}

// ImChannel 单例
ImChannel siIm = const ImChannel();

ImChannel getImChannel() {
  return siIm;
}

// UiConfigHost 单例
UiConfigHost siUch = const UiConfigHost();

UiConfigHost getUiConfigHost() {
  return siUch;
}
