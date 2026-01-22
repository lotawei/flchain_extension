import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('NumSpacingModifier 扩展测试', () {
    group('间距 Widget getter', () {
      testWidgets('hGap 应该创建水平间距 SizedBox', (WidgetTester tester) async {
        const double spacing = 16.0;
        final widget = spacing.hGap;

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(spacing));
        expect(sizedBox.height, isNull);
      });

      testWidgets('vGap 应该创建垂直间距 SizedBox', (WidgetTester tester) async {
        const double spacing = 20.0;
        final widget = spacing.vGap;

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, isNull);
        expect(sizedBox.height, equals(spacing));
      });

      testWidgets('gap 应该创建水平和垂直间距 SizedBox', (WidgetTester tester) async {
        const double spacing = 24.0;
        final widget = spacing.gap;

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(spacing));
        expect(sizedBox.height, equals(spacing));
      });

      testWidgets('边界值测试 - 0 间距', (WidgetTester tester) async {
        final hGap = 0.hGap;
        final vGap = 0.vGap;
        final gap = 0.gap;

        expect((hGap as SizedBox).width, equals(0.0));
        expect((vGap as SizedBox).height, equals(0.0));
        expect((gap as SizedBox).width, equals(0.0));
        expect((gap as SizedBox).height, equals(0.0));
      });

      testWidgets('边界值测试 - 负数间距', (WidgetTester tester) async {
        final hGap = (-10).hGap;
        final vGap = (-10).vGap;
        final gap = (-10).gap;

        expect((hGap as SizedBox).width, equals(-10.0));
        expect((vGap as SizedBox).height, equals(-10.0));
        expect((gap as SizedBox).width, equals(-10.0));
        expect((gap as SizedBox).height, equals(-10.0));
      });

      testWidgets('边界值测试 - 大数值间距', (WidgetTester tester) async {
        const double largeValue = 999999.0;
        final hGap = largeValue.hGap;
        final vGap = largeValue.vGap;
        final gap = largeValue.gap;

        expect((hGap as SizedBox).width, equals(largeValue));
        expect((vGap as SizedBox).height, equals(largeValue));
        expect((gap as SizedBox).width, equals(largeValue));
        expect((gap as SizedBox).height, equals(largeValue));
      });

      testWidgets('int 类型支持', (WidgetTester tester) async {
        final hGap = 16.hGap;
        final vGap = 16.vGap;
        final gap = 16.gap;

        expect((hGap as SizedBox).width, equals(16.0));
        expect((vGap as SizedBox).height, equals(16.0));
        expect((gap as SizedBox).width, equals(16.0));
        expect((gap as SizedBox).height, equals(16.0));
      });
    });

    group('EdgeInsets getter', () {
      test('all 应该创建所有方向相同的 EdgeInsets', () {
        const double value = 16.0;
        final edgeInsets = value.all;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(value));
        expect(edgeInsets.right, equals(value));
        expect(edgeInsets.top, equals(value));
        expect(edgeInsets.bottom, equals(value));
      });

      test('horizontal 应该创建水平方向的 EdgeInsets', () {
        const double value = 20.0;
        final edgeInsets = value.horizontal;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(value));
        expect(edgeInsets.right, equals(value));
        expect(edgeInsets.top, equals(0.0));
        expect(edgeInsets.bottom, equals(0.0));
      });

      test('vertical 应该创建垂直方向的 EdgeInsets', () {
        const double value = 24.0;
        final edgeInsets = value.vertical;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(0.0));
        expect(edgeInsets.right, equals(0.0));
        expect(edgeInsets.top, equals(value));
        expect(edgeInsets.bottom, equals(value));
      });

      test('left 应该创建只有左边的 EdgeInsets', () {
        const double value = 10.0;
        final edgeInsets = value.left;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(value));
        expect(edgeInsets.right, equals(0.0));
        expect(edgeInsets.top, equals(0.0));
        expect(edgeInsets.bottom, equals(0.0));
      });

      test('right 应该创建只有右边的 EdgeInsets', () {
        const double value = 12.0;
        final edgeInsets = value.right;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(0.0));
        expect(edgeInsets.right, equals(value));
        expect(edgeInsets.top, equals(0.0));
        expect(edgeInsets.bottom, equals(0.0));
      });

      test('top 应该创建只有上边的 EdgeInsets', () {
        const double value = 14.0;
        final edgeInsets = value.top;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(0.0));
        expect(edgeInsets.right, equals(0.0));
        expect(edgeInsets.top, equals(value));
        expect(edgeInsets.bottom, equals(0.0));
      });

      test('bottom 应该创建只有下边的 EdgeInsets', () {
        const double value = 18.0;
        final edgeInsets = value.bottom;

        expect(edgeInsets, isA<EdgeInsets>());
        expect(edgeInsets.left, equals(0.0));
        expect(edgeInsets.right, equals(0.0));
        expect(edgeInsets.top, equals(0.0));
        expect(edgeInsets.bottom, equals(value));
      });

      test('边界值测试 - 0 值', () {
        final edgeInsets = 0.all;
        expect(edgeInsets.left, equals(0.0));
        expect(edgeInsets.right, equals(0.0));
        expect(edgeInsets.top, equals(0.0));
        expect(edgeInsets.bottom, equals(0.0));
      });

      test('边界值测试 - 负数', () {
        final edgeInsets = (-5).all;
        expect(edgeInsets.left, equals(-5.0));
        expect(edgeInsets.right, equals(-5.0));
        expect(edgeInsets.top, equals(-5.0));
        expect(edgeInsets.bottom, equals(-5.0));
      });

      test('边界值测试 - 大数值', () {
        const double largeValue = 999999.0;
        final edgeInsets = largeValue.all;
        expect(edgeInsets.left, equals(largeValue));
        expect(edgeInsets.right, equals(largeValue));
        expect(edgeInsets.top, equals(largeValue));
        expect(edgeInsets.bottom, equals(largeValue));
      });
    });

    group('BorderRadius getter', () {
      test('circular 应该创建圆形 BorderRadius', () {
        const double radius = 8.0;
        final borderRadius = radius.circular;

        expect(borderRadius, isA<BorderRadius>());
        expect(borderRadius.topLeft, equals(Radius.circular(radius)));
        expect(borderRadius.topRight, equals(Radius.circular(radius)));
        expect(borderRadius.bottomLeft, equals(Radius.circular(radius)));
        expect(borderRadius.bottomRight, equals(Radius.circular(radius)));
      });

      test('radius 应该创建 Radius', () {
        const double radius = 10.0;
        final radiusObj = radius.radius;

        expect(radiusObj, isA<Radius>());
        expect(radiusObj.x, equals(radius));
        expect(radiusObj.y, equals(radius));
      });

      test('边界值测试 - 0 半径', () {
        final borderRadius = 0.circular;
        expect(borderRadius.topLeft.x, equals(0.0));
        expect(borderRadius.topRight.x, equals(0.0));
        expect(borderRadius.bottomLeft.x, equals(0.0));
        expect(borderRadius.bottomRight.x, equals(0.0));
      });

      test('边界值测试 - 负数半径', () {
        final borderRadius = (-5).circular;
        expect(borderRadius.topLeft.x, equals(-5.0));
        expect(borderRadius.topRight.x, equals(-5.0));
        expect(borderRadius.bottomLeft.x, equals(-5.0));
        expect(borderRadius.bottomRight.x, equals(-5.0));
      });

      test('边界值测试 - 大数值半径', () {
        const double largeValue = 999999.0;
        final borderRadius = largeValue.circular;
        expect(borderRadius.topLeft.x, equals(largeValue));
        expect(borderRadius.topRight.x, equals(largeValue));
        expect(borderRadius.bottomLeft.x, equals(largeValue));
        expect(borderRadius.bottomRight.x, equals(largeValue));
      });
    });

    group('Duration getter', () {
      test('ms 应该创建毫秒 Duration', () {
        const int milliseconds = 500;
        final duration = milliseconds.ms;

        expect(duration, isA<Duration>());
        expect(duration.inMilliseconds, equals(milliseconds));
      });

      test('seconds 应该创建秒 Duration', () {
        const int seconds = 3;
        final duration = seconds.seconds;

        expect(duration, isA<Duration>());
        expect(duration.inSeconds, equals(seconds));
      });

      test('边界值测试 - 0 毫秒', () {
        final duration = 0.ms;
        expect(duration.inMilliseconds, equals(0));
      });

      test('边界值测试 - 0 秒', () {
        final duration = 0.seconds;
        expect(duration.inSeconds, equals(0));
      });

      test('边界值测试 - 负数毫秒', () {
        final duration = (-100).ms;
        expect(duration.inMilliseconds, equals(-100));
      });

      test('边界值测试 - 负数秒', () {
        final duration = (-5).seconds;
        expect(duration.inSeconds, equals(-5));
      });

      test('边界值测试 - 大数值毫秒', () {
        const int largeValue = 999999;
        final duration = largeValue.ms;
        expect(duration.inMilliseconds, equals(largeValue));
      });

      test('边界值测试 - 大数值秒', () {
        const int largeValue = 999999;
        final duration = largeValue.seconds;
        expect(duration.inSeconds, equals(largeValue));
      });

      test('double 类型转换 - ms', () {
        final duration = 500.5.ms;
        expect(duration.inMilliseconds, equals(500));
      });

      test('double 类型转换 - seconds', () {
        final duration = 3.7.seconds;
        expect(duration.inSeconds, equals(3));
      });
    });
  });
}
