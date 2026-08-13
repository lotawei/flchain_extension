import 'package:flutter/material.dart';
import 'dart:async'; // 添加必要的导入
import 'memory_leak_fixes.dart'; // 导入修复页面
import 'package:leak_tracker/leak_tracker.dart'; // 导入leak_tracker

// 1. 常见内存泄漏示例页面
class MemoryLeakExamples extends StatelessWidget {
  static final akey = GlobalKey(); // 用于页面跳转的Key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('内存泄漏常见示例')),
      body: ListView(
        children: [
          ListTile(
            title: Text('1. 错误的全局引用'),
            subtitle: Text('全局Key未释放'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => GlobalKeyLeakPage())),
          ),
          ListTile(
            title: Text('修复：全局Key泄漏'),
            subtitle: Text('使用非静态Key'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => GlobalKeyLeakFixPage())),
          ),
          ListTile(
            title: Text('修复：Stream订阅泄漏'),
            subtitle: Text('在dispose中取消订阅'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => StreamSubscriptionLeakFixPage())),
          ),
          ListTile(
            title: Text('2. 未取消的订阅'),
            subtitle: Text('Stream未取消订阅'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => StreamSubscriptionLeakPage())),
          ),
          ListTile(
            title: Text('修复：定时器泄漏'),
            subtitle: Text('在dispose中取消定时器'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TimerLeakFixPage())),
          ),
          ListTile(
            title: Text('3. 静态资源泄漏'),
            subtitle: Text('静态变量持有上下文'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => StaticContextLeakPage())),
          ),
          ListTile(
            title: Text('修复：静态上下文泄漏'),
            subtitle: Text('不保存静态BuildContext'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => StaticContextLeakFixPage())),
          ),
          ListTile(
            title: Text('4. 定时器泄漏'),
            subtitle: Text('未取消的定时器'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TimerLeakPage())),
          ),
          ListTile(
            title: Text('修复：ScrollController泄漏'),
            subtitle: Text('在dispose中释放控制器'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ScrollControllerLeakFixPage())),
          ),
          ListTile(
            title: Text('5. 混合控制器泄漏'),
            subtitle: Text('未释放的ScrollController'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ScrollControllerLeakPage())),
          ),
        ],
      ),
    );
  }
}

// 1. 全局Key泄漏页面
class GlobalKeyLeakPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> akey = GlobalKey();

  @override
  State<GlobalKeyLeakPage> createState() => _GlobalKeyLeakPageState();
}

class _GlobalKeyLeakPageState extends State<GlobalKeyLeakPage> {
  @override
  void initState() {
    super.initState();
    LeakTracking.dispatchObjectCreated(
      library: 'example.memory_leak',
      className: 'GlobalKeyLeakPage',
      object: this,
      context: {'description': '全局ScaffoldKey未释放示例页面'},
    );
  }

  @override
  void dispose() {
    LeakTracking.dispatchObjectDisposed(
      object: this,
      context: {'description': 'GlobalKeyLeakPage被释放'},
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.akey,
      appBar: AppBar(title: Text('全局Key泄漏')),
      body: Center(child: Text('错误：全局ScaffoldKey未释放')),
    );
  }
}

// 2. Stream订阅泄漏页面
class StreamSubscriptionLeakPage extends StatefulWidget {
  @override
  _StreamSubscriptionLeakPageState createState() =>
      _StreamSubscriptionLeakPageState();
}

class _StreamSubscriptionLeakPageState
    extends State<StreamSubscriptionLeakPage> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    // 创建一个永不结束的Stream
    _subscription = Stream.periodic(Duration(seconds: 1)).listen((event) {
      // 即使页面关闭也继续运行
      print('仍在运行：$event');
    });

    LeakTracking.dispatchObjectCreated(
      library: 'example.memory_leak',
      className: 'StreamSubscriptionLeakPage',
      object: this,
      context: {'description': 'Stream订阅未取消示例页面'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream订阅泄漏')),
      body: Center(child: Text('错误：未取消的Stream订阅')),
    );
  }

  @override
  void dispose() {
    // 错误：忘记取消订阅
    // _subscription.cancel();
    super.dispose();
  }
}

// 3. 静态上下文泄漏页面
class StaticContextLeakPage extends StatefulWidget {
  static BuildContext? _context;

  @override
  State<StaticContextLeakPage> createState() => _StaticContextLeakPageState();
}

class _StaticContextLeakPageState extends State<StaticContextLeakPage> {
  @override
  void initState() {
    super.initState();
    LeakTracking.dispatchObjectCreated(
      library: 'example.memory_leak',
      className: 'StaticContextLeakPage',
      object: this,
      context: {'description': '静态上下文持有示例页面'},
    );
  }

  @override
  void dispose() {
    LeakTracking.dispatchObjectDisposed(
      object: this,
      context: {'description': 'StaticContextLeakPage被释放'},
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StaticContextLeakPage._context = context; // 错误：静态变量持有上下文
    return Scaffold(
      appBar: AppBar(title: Text('静态上下文泄漏')),
      body: Center(child: Text('错误：静态变量持有BuildContext')),
    );
  }
}

// 4. 定时器泄漏页面
class TimerLeakPage extends StatefulWidget {
  @override
  _TimerLeakPageState createState() => _TimerLeakPageState();
}

class _TimerLeakPageState extends State<TimerLeakPage> {
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
      appBar: AppBar(title: Text('定时器泄漏')),
      body: Center(child: Text('错误：未取消的定时器')),
    );
  }

  @override
  void dispose() {
    // 错误：忘记取消定时器
    // _timer.cancel();
    super.dispose();
  }
}

// 5. ScrollController泄漏页面
class ScrollControllerLeakPage extends StatefulWidget {
  final ScrollController _controller = ScrollController();

  @override
  State<ScrollControllerLeakPage> createState() =>
      _ScrollControllerLeakPageState();
}

class _ScrollControllerLeakPageState extends State<ScrollControllerLeakPage> {
  @override
  void initState() {
    super.initState();
    LeakTracking.dispatchObjectCreated(
      library: 'example.memory_leak',
      className: 'ScrollControllerLeakPage',
      object: this,
      context: {'description': 'ScrollController未取消示例页面'},
    );
  }

  @override
  void dispose() {
    LeakTracking.dispatchObjectDisposed(
      object: this,
      context: {'description': 'ScrollControllerLeakPage被释放'},
    );
    widget._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScrollController泄漏')),
      body: ListView.builder(
        controller: widget._controller, // 使用实例变量
        itemCount: 100,
        itemBuilder: (context, index) => Text('Item $index'),
      ),
    );
  }
}
