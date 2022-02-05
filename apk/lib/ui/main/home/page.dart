import 'package:flutter/material.dart';
import './fn_item.dart';

// 主界面
class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A拼音 2.0 输入法'),
      ),
      body: ListView(
        children: const [
          FnItem(
            title: '剪切板管理器',
            route: '/clip',
            icon: Icons.copy_rounded,
          ),
          FnItem(
            title: 'Unicode 小工具',
            route: '/utool',
            icon: Icons.construction_rounded,
          ),
          FnItem(
            title: '输入统计',
            route: '/icount',
            icon: Icons.show_chart_rounded,
          ),
          Divider(),
          //
          FnItem(
            title: '自定义输入',
            route: '/userd',
            icon: Icons.edit_rounded,
          ),
          FnItem(
            title: '日志查看',
            route: '/log',
            icon: Icons.history_rounded,
          ),
          FnItem(
            title: '数据库',
            route: '/db',
            icon: Icons.storage_rounded,
          ),
          FnItem(
            title: '多设备同步',
            route: '/dsync',
            icon: Icons.sync_alt_outlined,
          ),
          Divider(),
          //
          FnItem(
            title: '换肤',
            route: '/skin',
            icon: Icons.face_retouching_natural_sharp,
          ),
          FnItem(
            title: '设置',
            route: '/config',
            icon: Icons.tune_rounded,
          ),
          FnItem(
            title: '关于',
            route: '/about',
            icon: Icons.info_outline_rounded,
          ),
          Divider(),
        ],
      ),
    );
  }
}
