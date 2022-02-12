import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../config.dart';
import '../config.dart';
import './t.dart';
import './log_writer.dart';

// 日志功能
class LogHost {
  // 启用性能日志
  bool _enablePerf = true;
  // 启用输入日志
  bool _enableInput = false;
  // 启用调试日志
  bool _enableDebug = false;

  // 日志目录
  late String dir;
  late String dirPerf;
  late String dirClip;
  late String dirInput;
  late String dirDebug;

  // 性能日志写入器
  late LogWriter _wPerf;
  // 剪切板日志写入器
  late LogWriter _wClip;
  // 输入日志写入器
  late LogWriter _wInput;
  // 调试日志写入器
  late LogWriter _wDebug;

  void setEnablePerf(bool enable) {
    _enablePerf = enable;
  }

  void setEnableInput(bool enable) {
    _enableInput = enable;
  }

  void setEnableDebug(bool enable) {
    _enableDebug = false;
  }

  // 获取日志目录
  Future<String> getDir() async {
    var d = await getExternalStorageDirectory();
    if (d != null) {
      return p.join(d.path, dirLog);
    }
    throw Exception('getExternalStorageDirectory() = null');
  }

  // 性能日志目录
  Future<String> getDirPerf() async {
    var d = await getDir();
    return p.join(d, dirLogPerf);
  }

  // 剪切板日志目录
  Future<String> getDirClip() async {
    var d = await getDir();
    return p.join(d, dirLogClip);
  }

  // 输入日志目录
  Future<String> getDirInput() async {
    var d = await getDir();
    return p.join(d, dirLogInput);
  }

  // 调试日志目录
  Future<String> getDirDebug() async {
    var d = await getDir();
    return p.join(d, dirLogDebug);
  }

  // 取日志时间戳 ISO 格式: 2022-02-12T02:46:10.913Z
  String getTime() {
    return DateTime.now().toUtc().toIso8601String();
  }

  // 初始化
  Future<void> init() async {
    // 日志文件目录
    dir = await getDir();
    // DEBUG
    print('LogHost dir = ' + dir);

    dirPerf = await getDirPerf();
    print('LogHost dir_perf = ' + dirPerf);

    dirClip = await getDirClip();
    print('LogHost dir_clip = ' + dirClip);

    dirInput = await getDirInput();
    print('LogHost dir_input = ' + dirInput);

    dirDebug = await getDirDebug();
    print('LogHost dir_debug = ' + dirDebug);

    // LogWriter
    _wPerf = LogWriter(dirPerf);
    _wClip = LogWriter(dirClip);
    _wInput = LogWriter(dirInput);
    _wDebug = LogWriter(dirDebug);

    // 写一条 LogHost 初始化日志
    var time = getTime();
    await logPerf(
      time,
      LogItem(
        time: time,
        code: perfCodeInitLogHost,
        data: {
          'dir_log': dir,
          'dir_perf': dirPerf,
          'dir_clip': dirClip,
          'dir_input': dirInput,
          'dir_debug': dirDebug,
        },
      ).toJson(),
    );
    await flushPerf();
  }

  // 启动周期刷写日志
  void initFlush() {
    Timer.periodic(
      const Duration(milliseconds: logFlushTimeMs),
      (Timer t) {
        flush();
      },
    );
  }

  // 清理日志
  Future<void> clean() async {
    await _wInput.clean(logKeepDayInput);
    await _wPerf.clean(logKeepDayPerf);
    await _wClip.clean(logKeepDayClip);
    await _wDebug.clean(logKeepDayDebug);
  }

  // 刷写性能日志
  Future<void> flushPerf() async {
    await _wPerf.flush();
  }

  // 刷写输入日志
  Future<void> flushInput() async {
    await _wInput.flush();
  }

  // 刷写剪切板日志
  Future<void> flushClip() async {
    await _wClip.flush();
  }

  // 刷写调试日志
  Future<void> flushDebug() async {
    await _wDebug.flush();
  }

  // 刷写日志
  Future<void> flush() async {
    await flushClip();
    await flushPerf();
    await flushInput();
    await flushDebug();
  }

  // 写性能日志
  Future<void> logPerf(String time, String text) async {
    if (_enablePerf) {
      await _wPerf.write(time, text);
    }
  }

  // 写输入日志
  Future<void> logInput(String time, String text) async {
    if (_enableInput) {
      await _wInput.write(time, text);
    }
  }

  // 写剪切板日志
  Future<void> logClip(String time, String text) async {
    await _wClip.write(time, text);
  }

  // 写调试日志
  Future<void> logDebug(String time, String text) async {
    if (_enableDebug) {
      await _wDebug.write(time, text);
    }
  }
}
