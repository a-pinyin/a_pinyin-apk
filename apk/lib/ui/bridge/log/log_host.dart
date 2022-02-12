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
    final d = await getExternalStorageDirectory();
    if (d != null) {
      return p.join(d.path, dirLog);
    }
    throw Exception('getExternalStorageDirectory() = null');
  }

  // 性能日志目录
  Future<String> getDirPerf() async {
    final d = await getDir();
    return p.join(d, dirLogPerf);
  }

  // 剪切板日志目录
  Future<String> getDirClip() async {
    final d = await getDir();
    return p.join(d, dirLogClip);
  }

  // 输入日志目录
  Future<String> getDirInput() async {
    final d = await getDir();
    return p.join(d, dirLogInput);
  }

  // 调试日志目录
  Future<String> getDirDebug() async {
    final d = await getDir();
    return p.join(d, dirLogDebug);
  }

  // 取日志时间戳 ISO 格式: 2022-02-12T02:46:10.913Z
  String getTime() {
    return DateTime.now().toUtc().toIso8601String();
  }

  // 初始化
  Future<void> init({String? name}) async {
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
    _wPerf = LogWriter(dirPerf, name);
    _wClip = LogWriter(dirClip, name);
    _wInput = LogWriter(dirInput, name);
    _wDebug = LogWriter(dirDebug, name);

    // 启动写循环
    writerLoop();

    // 写一条 LogHost 初始化日志
    final time = getTime();
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
    await flush();
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

  // 刷写全部日志文件
  Future<void> flush() async {
    writerFlush();
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

  // 监听全局广播
  Future<void> sbRecv(String m) async {
    // 写性能日志
    if (m.startsWith('im.on.')) {
      final time = getTime();
      await logPerf(
        time,
        LogItem(
          time: time,
          code: perfCodeImOn,
          data: {
            'm': m,
          },
        ).toJson(),
      );
    }
    // 刷写日志
    if (m == 'im.on.finish_input') {
      await flush();
    }
  }
}
