import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './home/page.dart';
import './about/page.dart';
import './clip/page.dart';
import './config/page.dart';
import './db/page.dart';
import './dsync/page.dart';
import './icount/page.dart';
import './log/page.dart';
import './skin/page.dart';
import './userd/page.dart';
import './utool/page.dart';

class MApp extends StatelessWidget {
  const MApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A拼音',
      // theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 从右侧滑入的页面切换效果
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      // i18n: zh_CN
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Chinese
        Locale('zh', 'CN'),
      ],
      // route
      initialRoute: '/',
      routes: {
        // 主界面
        '/': (context) => const PageHome(),
        // 关于
        '/about': (context) => const PageAbout(),
        // 剪切板管理器
        '/clip': (context) => const PageClip(),
        // 设置
        '/config': (context) => const PageConfig(),
        // 数据库
        '/db': (context) => const PageDb(),
        // 多设备同步
        '/dsync': (context) => const PageDsync(),
        // 输入统计
        '/icount': (context) => const PageIcount(),
        // 日志查看
        '/log': (context) => const PageLog(),
        // 换肤
        '/skin': (context) => const PageSkin(),
        // 自定义输入
        '/userd': (context) => const PageUserd(),
        // Unicode 小工具
        '/utool': (context) => const PageUtool(),
      },
    );
  }
}
