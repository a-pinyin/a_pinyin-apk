import 'package:flutter/material.dart';

// 一个功能项, 点击跳转
class FnItem extends StatelessWidget {
  const FnItem({
    Key? key,
    required this.title,
    required this.route,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(Icons.navigate_next_rounded),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
