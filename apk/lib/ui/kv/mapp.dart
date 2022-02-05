import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './simple_keyboard/host/page.dart';

// 软键盘 (keyboard view)
class KvApp extends StatelessWidget {
  const KvApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A拼音输入键盘',
      // theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      // home
      home: const SimpleKeyboard(),
    );
  }
}
