import 'package:flutter/material.dart';

// A拼音 图标 (拼20)
class ApyLogo extends StatefulWidget {
  const ApyLogo({Key? key}) : super(key: key);

  @override
  _ApyLogoState createState() => _ApyLogoState();
}

// 拼20 图标 标题
const p20 = '拼20: 方圆之间, 刺破命运';

class _ApyLogoState extends State<ApyLogo> {
  // 彩蛋: 点击切换 1/2 风格图标
  bool show2 = false;

  void _click() {
    setState(() {
      show2 = !show2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: p20,
      child: GestureDetector(
        onTap: _click,
        child: Stack(
          children: [
            Offstage(
              offstage: show2,
              child: const Image(
                image: AssetImage('assets/logo/拼20-1-1024.png'),
                fit: BoxFit.scaleDown,
                filterQuality: FilterQuality.medium,
                semanticLabel: p20,
              ),
            ),
            Offstage(
              offstage: !show2,
              child: const Image(
                image: AssetImage('assets/logo/拼20-2-1024.png'),
                fit: BoxFit.scaleDown,
                filterQuality: FilterQuality.medium,
                semanticLabel: p20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
