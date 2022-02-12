import 'dart:typed_data';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:wasm/wasm.dart';

// wasmer 简单测试
Future<void> wasmTest() async {
  print('wasmTest()');

  // 只能在 main isolate 中加载 asset
  final data = await loadWasm();
  Isolate.spawn<Uint8List>(runWasmer, data);
}

// 在后台线程运行
Future<void> runWasmer(Uint8List m) async {
  print('runWasmer()');

  final mod = WasmModule(m);
  // DEBUG
  print(mod.describe());

  final i = mod.builder().build();
  final add = i.lookupFunction('add');
  final result = add(1, 2);
  print('add(1, 2) == ' + result.toString());
}

// 从 asset 加载 wasm 二进制数据
Future<Uint8List> loadWasm() async {
  final data = await rootBundle.load('assets/wasm/wasm_test.wasm');
  return data.buffer.asUint8List();
}
