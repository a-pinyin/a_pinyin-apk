import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:channel/channel.dart';
import '../config.dart';

// 写日志文件的底层工具
//
// 日志文件组织方式 (栗子):
//
// + perf/  日志根目录
//   + 202202/  年月目录
//     - 20220212.log.txt  每天一个日志文件 (仅追加)
class LogWriter {
  LogWriter(this.rootDir, this.name);

  // 日志根目录
  final String rootDir;
  // 区分后缀, 避免日志写冲突
  final String? name;

  // 获取一条日志对应的目录
  String _getLogDir(String time) {
    // 年月日 切分: ['2022', '02', '12']
    final t = time.split('T')[0].split('-');
    return p.join(rootDir, t.sublist(0, 2).join(''));
  }

  // 获取一条日志对应的文件名
  String _getFilename(String time) {
    // 20220212
    final d = time.split('T')[0].split('-').join('');
    if (name != null) {
      final n = '-' + name!;
      return d + n + logFileSuffix;
    }
    return d + logFileSuffix;
  }

  // 写一条日志
  // time: 时间戳 ISO 格式: 2022-02-12T02:46:10.913Z
  // text: 日志内容 (单行文本 JSON)
  Future<void> write(String time, String text) async {
    // 根据时间戳生成日志文件路径
    final dir = _getLogDir(time);
    final filename = _getFilename(time);
    _channel.send(_FileOp(
      op: _fileOp.write,
      dir: dir,
      filename: filename,
      // 不要忘记 text
      text: text,
    ));
  }

  // 清理旧日志
  // day: 日志保留的天数
  Future<void> clean(int day) async {
    // TODO
  }
}

// 串行处理文件操作, 避免异步错误
// E/flutter ( 9994): [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: FileSystemException: An async operation is currently pending, path =
enum _fileOp {
  write,
  flush,
}

class _FileOp {
  const _FileOp({
    required this.op,
    required this.dir,
    required this.filename,
    this.text,
  });

  final _fileOp op;
  final String dir;
  final String filename;
  final String? text;
}

// 用于序列化异步操作
final _channel = Channel<_FileOp>();
// 日志文件缓存
final Map<String, RandomAccessFile> _cache = {};

// 查询缓存, 返回所需日志文件
Future<RandomAccessFile> _getFile(String dir, String filename) async {
  final k = p.join(dir, filename);
  // 查询缓存
  if (!_cache.containsKey(k)) {
    // 创建目录
    await Directory(dir).create(recursive: true);
    // 创建文件
    final f = await File(k).open(mode: FileMode.append);
    _cache[k] = f;
  }
  return _cache[k]!;
}

// 处理一个操作
Future<void> _doOp(_FileOp op) async {
  switch (op.op) {
    case _fileOp.flush:
      for (var i in _cache.values) {
        await i.flush();
      }
      // 全部 flush 成功之后再 close 文件
      for (var i in _cache.values) {
        await i.close();
      }
      // 清空 cache
      _cache.clear();
      break;
    case _fileOp.write:
      if (op.text != null) {
        final f = await _getFile(op.dir, op.filename);
        // 写入一行
        await f.writeString(op.text! + '\n');
      }
      break;
  }
}

// 启动写日志主循环
Future<void> writerLoop() async {
  while (true) {
    final ev = await _channel.receive();
    if (ev.isClosed) {
      break;
    }
    final op = ev.data;
    if (op != null) {
      try {
        await _doOp(op);
      } catch (e) {
        // 忽略单个操作错误
        print(e);
      }
    }
  }
}

// 停止循环
void closeWriterLoop() {
  _channel.close();
}

// 刷写全部日志文件
void writerFlush() {
  _channel.send(const _FileOp(
    op: _fileOp.flush,
    dir: '',
    filename: '',
  ));
}
