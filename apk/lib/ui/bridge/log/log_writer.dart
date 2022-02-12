import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;

// 写日志文件的底层工具
//
// 日志文件组织方式 (栗子):
//
// + perf/  日志根目录
//   + 202202/  年月目录
//     - 20220212.log.txt  每天一个日志文件 (仅追加)
class LogWriter {
  LogWriter(this.rootDir);

  // 日志根目录
  final String rootDir;

  // 日志文件缓存
  final Map<String, RandomAccessFile> _cache = {};

  // 获取一条日志对应的目录
  String _getLogDir(String time) {
    // 年月日 切分: ['2022', '02', '12']
    var t = time.split('T')[0].split('-');
    return p.join(rootDir, t.sublist(0, 2).join(''));
  }

  // 获取一条日志对应的文件名
  String _getFilename(String time) {
    // 20220212
    var d = time.split('T')[0].split('-').join('');
    return d + '.log.txt';
  }

  // 查询缓存, 返回所需日志文件
  Future<RandomAccessFile> _getFile(String time) async {
    // 根据时间戳生成日志文件路径
    var d = _getLogDir(time);
    var filename = _getFilename(time);
    var k = p.join(d, filename);
    // 查询缓存
    if (!_cache.containsKey(k)) {
      // 创建目录
      await Directory(d).create(recursive: true);
      // 创建文件
      var f = await File(k).open(mode: FileMode.append);
      _cache[k] = f;
    }
    return _cache[k]!;
  }

  // 写一条日志
  // time: 时间戳 ISO 格式: 2022-02-12T02:46:10.913Z
  // text: 日志内容 (单行文本 JSON)
  Future<void> write(String time, String text) async {
    var f = await _getFile(time);
    // 写入一行
    await f.writeString(text + '\n');
  }

  // 刷写日志
  Future<void> flush() async {
    for (var i in _cache.values) {
      await i.flush();
      // TODO 刷写和写入日志的异步竞态处理
      //await i.close();
    }
  }

  // 清理旧日志
  // day: 日志保留的天数
  Future<void> clean(int day) async {
    // TODO
  }
}
