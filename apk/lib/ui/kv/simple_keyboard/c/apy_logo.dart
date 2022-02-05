import 'package:flutter/material.dart';

// A拼音 小图标
class ApyLogo extends StatelessWidget {
  const ApyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/logo/拼20-t-128.png'),
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
    );
  }
}
