import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'memory_leak_examples.dart'; // 导入内存泄漏示例页面
import 'package:leak_tracker/leak_tracker.dart';

import 'package:flutter_performance_optimizer/flutter_performance_optimizer.dart';

class ManagerInstance {
  final VoidCallback callback;
  ManagerInstance(this.callback);
}

void main() {
  LeakTracking.start();
  // Dispatch memory events from the Flutter engine to LeakTracking.
  FlutterMemoryAllocations.instance.addListener(
    (ObjectEvent event) => LeakTracking.dispatchObjectEvent(event.toMap()),
  );
  runApp(MemeryPage());
}

class MemeryCheckHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('内存泄漏示例')),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MemoryLeakExamples(),
              ),
            );
          },
          child: Text('查看内存泄漏示例'),
        ),
      ),
    );
  }
}

class MemeryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MemeryCheckHomePage() // 修改为新的首页
        );
  }
}

class Mermerycheck extends StatefulWidget {
  static final akey = GlobalKey();
  Mermerycheck({super.key});

  @override
  State<Mermerycheck> createState() => _MermerycheckState();
}

class _MermerycheckState extends State<Mermerycheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('你好呀'),
        ),
        body: Container(
          key: Mermerycheck.akey,
          child: TextButton(
              onPressed: () {
                ManagerInstance(() => print('你好'));
              },
              child: Text('点击')),
        ));
  }
}
