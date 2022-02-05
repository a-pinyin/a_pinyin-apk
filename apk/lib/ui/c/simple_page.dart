import 'package:flutter/material.dart';

// 带有返回按钮标题的简单页面
class SimplePage extends StatelessWidget {
  const SimplePage({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: const BackButton(),
      ),
      body: child,
    );
  }
}
