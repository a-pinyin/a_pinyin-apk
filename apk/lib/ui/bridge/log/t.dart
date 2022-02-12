import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 't.g.dart';

// 一条日志的一般结构
@JsonSerializable()
class LogItem {
  const LogItem({
    required this.time,
    required this.code,
    this.text,
    this.data,
  });

  factory LogItem.fromJson(String json) => _$LogItemFromJson(jsonDecode(json));
  String toJson() => jsonEncode(_$LogItemToJson(this));

  // 时间戳
  final String time;
  // 类型
  final String code;
  // 任意文本
  final String? text;
  // 附加数据
  final Map<String, String>? data;
}

// 性能日志 code 定义
const perfCodeInitLogHost = 'init.log_host';
const perfCodeInitClip = 'init.clip';
// 主界面初始化
const perfCodeInitUi = 'init.ui';
// Im 生命周期回调
const perfCodeImOn = 'im.on';

// 剪切板日志 code 定义
const clipCodeInit = 'clip.init';
const clipCodeUpdate = 'clip.update';
