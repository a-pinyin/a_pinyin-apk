import 'package:flutter/material.dart';
import './si.dart';

// 用于初始化 SuperBus 的顶级组件
class InitSb extends StatefulWidget {
  const InitSb({
    Key? key,
    required this.name,
    required this.child,
  }) : super(key: key);

  final String name;
  final Widget child;

  @override
  _InitSbState createState() => _InitSbState();
}

class _InitSbState extends State<InitSb> {
  @override
  void initState() {
    super.initState();

    getSb(name: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
