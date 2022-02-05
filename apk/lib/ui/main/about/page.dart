import 'package:flutter/material.dart';
import '../../c/simple_page.dart';
import './apy_logo.dart';
import './about_version.dart';
import './license.dart';
import './about_test.dart';

// 页面: 关于
class PageAbout extends StatelessWidget {
  const PageAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: '关于',
      child: ListView(
        children: const [
          ApyLogo(),
          // TODO 水平布局

          AboutVersion(),
          License(),
          // test
          AboutTest(),
        ],
      ),
    );
  }
}
