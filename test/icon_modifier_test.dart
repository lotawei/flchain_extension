import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('IconModifier 扩展测试', () {
    const IconData testIcon = Icons.favorite;
    const Icon testIconWidget = Icon(testIcon);

    group('iconSize 方法', () {
      testWidgets('iconSize 应该设置图标大小', (WidgetTester tester) async {
        const double size = 32.0;
        final icon = testIconWidget.iconSize(size);

        expect(icon, isA<Icon>());
        expect(icon.size, equals(size));
        expect(icon.icon, equals(testIcon));
        expect(icon.color, equals(testIconWidget.color));
      });

      testWidgets('边界值测试 - 0 大小', (WidgetTester tester) async {
        final icon = testIconWidget.iconSize(0);

        expect(icon.size, equals(0.0));
      });

      testWidgets('边界值测试 - 负大小', (WidgetTester tester) async {
        final icon = testIconWidget.iconSize(-10);

        expect(icon.size, equals(-10.0));
      });

      testWidgets('边界值测试 - 大数值', (WidgetTester tester) async {
        const double largeSize = 999.0;
        final icon = testIconWidget.iconSize(largeSize);

        expect(icon.size, equals(largeSize));
      });

      testWidgets('默认大小应该保持不变', (WidgetTester tester) async {
        const Icon iconWithDefaultSize = Icon(testIcon, size: 24.0);
        final icon = iconWithDefaultSize.iconSize(32.0);

        expect(icon.size, equals(32.0));
      });
    });

    group('iconColor 方法', () {
      testWidgets('iconColor 应该设置图标颜色', (WidgetTester tester) async {
        const Color color = Colors.red;
        final icon = testIconWidget.iconColor(color);

        expect(icon, isA<Icon>());
        expect(icon.color, equals(color));
        expect(icon.icon, equals(testIcon));
        expect(icon.size, equals(testIconWidget.size));
      });

      testWidgets('null 颜色应该保持 null', (WidgetTester tester) async {
        const Icon iconWithNullColor = Icon(testIcon, color: null);
        const Color newColor = Colors.blue;
        final icon = iconWithNullColor.iconColor(newColor);

        expect(icon.color, equals(newColor));
      });

      testWidgets('不同颜色应该正确设置', (WidgetTester tester) async {
        const List<Color> colors = [Colors.red, Colors.blue, Colors.green];
        for (final color in colors) {
          final icon = testIconWidget.iconColor(color);
          expect(icon.color, equals(color));
        }
      });
    });

    group('链式调用', () {
      testWidgets('iconSize 和 iconColor 可以链式调用', (WidgetTester tester) async {
        const double size = 48.0;
        const Color color = Colors.purple;
        final icon = testIconWidget.iconSize(size).iconColor(color);

        expect(icon.size, equals(size));
        expect(icon.color, equals(color));
        expect(icon.icon, equals(testIcon));
      });

      testWidgets('多个修饰器可以链式调用', (WidgetTester tester) async {
        final icon = testIconWidget
            .iconSize(32)
            .iconColor(Colors.blue)
            .iconSize(40) // 再次设置大小
            .iconColor(Colors.red); // 再次设置颜色

        expect(icon.size, equals(40.0));
        expect(icon.color, equals(Colors.red));
      });
    });

    group('null 值处理', () {
      testWidgets('size 为 null 时应该保持 null', (WidgetTester tester) async {
        const Icon iconWithNullSize = Icon(testIcon, size: null);
        final icon = iconWithNullSize.iconSize(32.0);

        expect(icon.size, equals(32.0));
      });

      testWidgets('color 为 null 时可以设置新颜色', (WidgetTester tester) async {
        const Icon iconWithNullColor = Icon(testIcon, color: null);
        final icon = iconWithNullColor.iconColor(Colors.green);

        expect(icon.color, equals(Colors.green));
      });
    });

    group('组合测试', () {
      testWidgets('不同图标应该正确应用修饰器', (WidgetTester tester) async {
        const List<IconData> icons = [
          Icons.home,
          Icons.favorite,
          Icons.settings,
          Icons.person,
        ];

        for (final iconData in icons) {
          final icon = Icon(iconData).iconSize(24).iconColor(Colors.blue);
          expect(icon.icon, equals(iconData));
          expect(icon.size, equals(24.0));
          expect(icon.color, equals(Colors.blue));
        }
      });
    });
  });
}
