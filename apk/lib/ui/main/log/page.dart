import 'package:flutter/material.dart';
import '../../c/todo_page.dart';

class PageLog extends StatelessWidget {
  const PageLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPage(
      title: '日志查看',
    );
  }
}
