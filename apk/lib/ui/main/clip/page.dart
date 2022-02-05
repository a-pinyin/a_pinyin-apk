import 'package:flutter/material.dart';
import '../../c/todo_page.dart';

class PageClip extends StatelessWidget {
  const PageClip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPage(
      title: '剪切板管理器',
    );
  }
}
