import 'package:flutter/material.dart';
import '../../version.dart';

// 项目 URL
const pUrl = 'https://github.com/fm-elpac/a_pinyin';

// 关于: 版本号 部分
class AboutVersion extends StatelessWidget {
  const AboutVersion({Key? key}) : super(key: key);

  // 应用名称 + 版本号
  String getVersion() {
    return 'A拼音 ' + pVersion + ' ' + pVersionTest;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            getVersion(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SelectableText(pUrl),
          ),
        ],
      ),
    );
  }
}
