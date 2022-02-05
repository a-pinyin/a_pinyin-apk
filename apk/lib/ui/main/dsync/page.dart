import 'package:flutter/material.dart';
import '../../c/todo_page.dart';

class PageDsync extends StatelessWidget {
  const PageDsync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPage(
      title: '多设备同步',
    );
  }
}
