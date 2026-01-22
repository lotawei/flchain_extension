import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('TapAnimationModifier 扩展测试', () {
    const Widget testWidget = Text('Test');

    group('tapScale 方法', () {
      testWidgets('tapScale 应该创建 _TapScaleWidget', (WidgetTester tester) async {
        final widget = testWidget.tapScale();

        // 由于 _TapScaleWidget 是私有类，我们只能验证返回的是 Widget
        expect(widget, isA<Widget>());
      });

      testWidgets('tapScale 应该支持自定义 scale', (WidgetTester tester) async {
        const double scale = 0.9;
        final widget = testWidget.tapScale(scale: scale);

        expect(widget, isA<Widget>());
      });

      testWidgets('tapScale 应该支持自定义 duration', (WidgetTester tester) async {
        const Duration duration = Duration(milliseconds: 200);
        final widget = testWidget.tapScale(duration: duration);

        expect(widget, isA<Widget>());
      });

      testWidgets('边界值测试 - 0 scale', (WidgetTester tester) async {
        final widget = testWidget.tapScale(scale: 0);

        expect(widget, isA<Widget>());
      });

      testWidgets('边界值测试 - 大于 1.0 的 scale', (WidgetTester tester) async {
        final widget = testWidget.tapScale(scale: 1.5);

        expect(widget, isA<Widget>());
      });
    });

    group('tapOpacity 方法', () {
      testWidgets('tapOpacity 应该创建 _TapOpacityWidget', (WidgetTester tester) async {
        final widget = testWidget.tapOpacity();

        expect(widget, isA<Widget>());
      });

      testWidgets('tapOpacity 应该支持自定义 opacity', (WidgetTester tester) async {
        const double opacity = 0.5;
        final widget = testWidget.tapOpacity(opacity: opacity);

        expect(widget, isA<Widget>());
      });

      testWidgets('tapOpacity 应该支持自定义 duration', (WidgetTester tester) async {
        const Duration duration = Duration(milliseconds: 150);
        final widget = testWidget.tapOpacity(duration: duration);

        expect(widget, isA<Widget>());
      });

      testWidgets('边界值测试 - 0 opacity', (WidgetTester tester) async {
        final widget = testWidget.tapOpacity(opacity: 0);

        expect(widget, isA<Widget>());
      });

      testWidgets('边界值测试 - 1.0 opacity', (WidgetTester tester) async {
        final widget = testWidget.tapOpacity(opacity: 1.0);

        expect(widget, isA<Widget>());
      });
    });

    group('tapBounce 方法', () {
      testWidgets('tapBounce 应该创建 _TapBounceWidget', (WidgetTester tester) async {
        final widget = testWidget.tapBounce();

        expect(widget, isA<Widget>());
      });

      testWidgets('tapBounce 应该支持自定义 duration', (WidgetTester tester) async {
        const Duration duration = Duration(milliseconds: 200);
        final widget = testWidget.tapBounce(duration: duration);

        expect(widget, isA<Widget>());
      });
    });

    group('tapRipple 方法', () {
      testWidgets('tapRipple 应该创建 Material 和 InkWell', (WidgetTester tester) async {
        final widget = testWidget.tapRipple();

        expect(widget, isA<Material>());
        final material = widget as Material;
        expect(material.color, equals(Colors.transparent));
        expect(material.child, isA<InkWell>());
      });

      testWidgets('tapRipple 应该支持 onTap 回调', (WidgetTester tester) async {
        bool tapped = false;
        final widget = testWidget.tapRipple(onTap: () {
          tapped = true;
        });

        expect(widget, isA<Material>());
        final material = widget as Material;
        final inkWell = material.child as InkWell;
        expect(inkWell.onTap, isNotNull);

        inkWell.onTap?.call();
        expect(tapped, isTrue);
      });

      testWidgets('tapRipple 应该支持自定义颜色', (WidgetTester tester) async {
        const Color color = Colors.blue;
        final widget = testWidget.tapRipple(color: color);

        expect(widget, isA<Material>());
        final material = widget as Material;
        final inkWell = material.child as InkWell;
        expect(inkWell.splashColor, equals(color));
      });

      testWidgets('tapRipple 默认应该使用圆角', (WidgetTester tester) async {
        final widget = testWidget.tapRipple();

        expect(widget, isA<Material>());
        final material = widget as Material;
        final inkWell = material.child as InkWell;
        expect(inkWell.borderRadius, equals(BorderRadius.circular(8)));
      });
    });

    group('链式调用', () {
      testWidgets('可以与其他修饰器链式调用', (WidgetTester tester) async {
        final widget = testWidget
            .tapScale()
            .paddingAll(16)
            .background(Colors.blue);

        expect(widget, isA<Widget>());
      });
    });
  });
}
