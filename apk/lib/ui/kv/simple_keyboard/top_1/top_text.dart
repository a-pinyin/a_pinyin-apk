import 'package:flutter/material.dart';

// 顶部文本按钮的文本
class TopText extends StatelessWidget {
  const TopText(this.text, this.active, {Key? key}) : super(key: key);

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (active) {
      return Container(
        color: Colors.lightGreen.shade700,
        child: TopTextIn(
          text: text,
          color: Colors.lightGreen.shade50,
        ),
      );
    }

    return TopTextIn(
      text: text,
      color: Colors.lightGreen.shade300,
    );
  }
}

class TopTextIn extends StatelessWidget {
  const TopTextIn({Key? key, required this.text, required this.color})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0, color: color),
        ),
      ),
    );
  }
}
