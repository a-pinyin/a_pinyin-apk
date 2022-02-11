import 'package:flutter/material.dart';
import './wasm_test.dart';

// 打开关于页面后执行的测试 (DEBUG)
class AboutTest extends StatefulWidget {
  const AboutTest({Key? key}) : super(key: key);

  @override
  _AboutTestState createState() => _AboutTestState();
}

class _AboutTestState extends State<AboutTest> {
  @override
  void initState() {
    super.initState();

    // run test
    wasmTest();
  }

  @override
  Widget build(BuildContext context) {
    // 空白占位符
    return const SizedBox.shrink();
  }
}
