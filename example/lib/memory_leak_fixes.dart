import 'package:flutter/material.dart';
import 'dart:async';

// 1. 全局Key泄漏修复页面
class GlobalKeyLeakFixPage extends StatelessWidget {
  // 不使用静态Key
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(title: Text('全局Key泄漏修复')),
      body: Center(child: Text('修复：不使用静态GlobalKey')),
    );
  }
}

// 2. Stream订阅泄漏修复页面
class StreamSubscriptionLeakFixPage extends StatefulWidget {
  @override
  _StreamSubscriptionLeakFixPageState createState() =>
      _StreamSubscriptionLeakFixPageState();
}

class _StreamSubscriptionLeakFixPageState
    extends State<StreamSubscriptionLeakFixPage> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    // 创建一个永不结束的Stream
    _subscription = Stream.periodic(Duration(seconds: 1)).listen((event) {
      // 即使页面关闭也继续运行
      print('仍在运行：$event');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream订阅泄漏修复')),
      body: Center(child: Text('修复：在dispose中取消订阅')),
    );
  }

  @override
  void dispose() {
    // 修复：取消订阅
    _subscription.cancel();
    super.dispose();
  }
}

// 3. 静态上下文泄漏修复页面
class StaticContextLeakFixPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 不保存静态上下文
    return Scaffold(
      appBar: AppBar(title: Text('静态上下文泄漏修复')),
      body: Center(child: Text('修复：不保存静态BuildContext')),
    );
  }
}

// 4. 定时器泄漏修复页面
class TimerLeakFixPage extends StatefulWidget {
  @override
  _TimerLeakFixPageState createState() => _TimerLeakFixPageState();
}

class _TimerLeakFixPageState extends State<TimerLeakFixPage> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    // 创建一个永不触发的定时器
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 即使页面关闭也继续运行
      print('仍在运行：$timer');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('定时器泄漏修复')),
      body: Center(child: Text('修复：在dispose中取消定时器')),
    );
  }

  @override
  void dispose() {
    // 修复：取消定时器
    _timer.cancel();
    super.dispose();
  }
}

// 5. ScrollController泄漏修复页面
class ScrollControllerLeakFixPage extends StatefulWidget {
  @override
  _ScrollControllerLeakFixPageState createState() =>
      _ScrollControllerLeakFixPageState();
}

class _ScrollControllerLeakFixPageState
    extends State<ScrollControllerLeakFixPage> {
  late ScrollController _controller;
  

  @override
  void initState() {
    super.initState();
    // 在initState中创建控制器
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('ScrollController泄漏修复')),
      body: ListView.builder(
        controller: _controller, // 使用非静态控制器
        itemCount: 100,
        itemBuilder: (context, index) => Text('Item $index'),
      ),
    );
  }

  @override
  void dispose() {
    // 修复：释放控制器
    _controller.dispose();
    super.dispose();
  }
}
