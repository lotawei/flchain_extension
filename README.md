# flchain_extension

Flutter 链式调用扩展库，提供简洁优雅的 Widget 修饰器和动画效果。

## 安装

```yaml
dependencies:
  flchain_extension:
    git:
      url: https://github.com/lotawei/flchain_extension.git
```

## 使用

```dart
import 'package:flchain_extension/flchain_extension.dart';
```

## 功能特性

### Widget 修饰器

```dart
// 尺寸
widget.width(100).height(50)
widget.square(100)
widget.fullWidth()

// Padding & Margin
widget.paddingAll(16)
widget.paddingSymmetric(horizontal: 16, vertical: 8)
widget.margin(EdgeInsets.all(8))

// 对齐
widget.center()
widget.alignLeft()
widget.alignRight()

// 背景和装饰
widget.background(Colors.blue)
widget.cornerRadius(8)
widget.circle()
widget.border(color: Colors.red, width: 2)
widget.shadow(blurRadius: 8)
widget.linearGradient(colors: [Colors.blue, Colors.purple])

// 手势
widget.onTap(() => print('tapped'))
widget.onLongPress(() => print('long pressed'))

// 可见性
widget.visible(true)
widget.opacity(0.5)
widget.when(condition)
```

### Text 扩展

```dart
const Text('Hello')
    .fontSize(24)
    .bold()
    .textColor(Colors.blue)
    .underline()
    .italic()
    .shadow()
    .ellipsis()

// String 快速创建
'Hello'.text.fontSize(20).bold()
```

### 动画效果

```dart
// 自动播放动画
widget.animate(Anim.fadeIn())
widget.animate(Anim.slideLeft())
widget.animate(Anim.scale())

// 点击触发动画
widget.animate(Anim.bounce(trigger: AnimTrigger.onTap))
widget.animate(Anim.shake(trigger: AnimTrigger.onTap))
widget.animate(Anim.rotate(trigger: AnimTrigger.onTap))

// 循环动画
widget.animate(Anim.pulse(repeat: true))
widget.animate(Anim.blink(repeat: true))

// 组合动画
widget.animate(Anim.fadeSlide())
```

### 点击动画

```dart
widget.tapScale()      // iOS 风格按压缩放
widget.tapOpacity()    // 透明度变化
widget.tapBounce()     // 弹跳效果
widget.tapRipple()     // Material 涟漪
```

### List<Widget> 扩展

```dart
[widget1, widget2, widget3]
    .toColumn()
    .toRow()
    .toStack()
    .toWrap()
    .withSpacing(8)
```

### IconTextButton 组件

```dart
// 基础用法 - 水平布局
IconTextButtonConfig(
  icon: const Icon(Icons.favorite, color: Colors.white),
  text: const Text('喜欢').textColor(Colors.white).bold(),
  onPressed: () => print('clicked'),
)
  .bg(Colors.red)
  .padAll(16)
  .radius(24)
  .build()

// 链式调用 - 垂直布局
IconTextButtonConfig(
  icon: const Icon(Icons.share, size: 24),
  text: const Text('分享').fontSize(12),
  onPressed: () => print('clicked'),
)
  .vertical()
  .fg(Colors.blue)
  .padAll(16)
  .gap(8)
  .bg(Colors.blue.shade50)
  .radius(12)
  .borderSide(color: Colors.blue, width: 1)
  .build()

// 完整配置
IconTextButtonConfig(
  icon: const Icon(Icons.download),
  text: const Text('下载'),
  onPressed: () => print('clicked'),
  direction: Axis.horizontal,  // 或 Axis.vertical
  padding: EdgeInsets.all(16),
  spacing: 8.0,
)
  .bg(Colors.green)
  .fg(Colors.white)
  .radius(8)
  .shadow(2)
  .build()
```

### 数字扩展

```dart
16.vGap          // 垂直间距
16.hGap          // 水平间距
16.all           // EdgeInsets.all(16)
8.circular       // BorderRadius.circular(8)
300.ms           // Duration(milliseconds: 300)
```

## 示例

```dart
import 'package:flchain_extension/flchain_extension.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return [
      '标题'.text.fontSize(24).bold().textColor(Colors.blue),
      16.vGap,
      const Text('内容描述')
          .fontSize(14)
          .textColor(Colors.grey),
      24.vGap,
      const Text('按钮')
          .textColor(Colors.white)
          .center()
          .height(48)
          .fullWidth()
          .background(Colors.blue)
          .cornerRadius(24)
          .animate(Anim.fadeIn())
          .onTap(() => print('clicked')),
    ]
    .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
    .paddingAll(16)
    .safeArea();
  }
}
```

## License

MIT
