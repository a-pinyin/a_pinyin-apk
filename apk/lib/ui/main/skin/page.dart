import 'package:flutter/material.dart';
import '../../c/todo_page.dart';

class PageSkin extends StatelessWidget {
  const PageSkin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodoPage(
      title: '换肤',
    );
  }
}
