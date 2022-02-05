import 'package:flutter/material.dart';
import './simple_page.dart';
import './todo_placeholder.dart';

// 仅带有标题的空白页面, 用于功能页面占位
class TodoPage extends StatelessWidget {
  const TodoPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: title,
      child: const TodoPlaceholder(),
    );
  }
}
