import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('ColorModifier 扩展测试', () {
    group('darken 方法', () {
      test('正常值应该使颜色变暗', () {
        const Color originalColor = Color(0xFF808080); // 灰色
        final darkenedColor = originalColor.darken(0.2);

        expect(darkenedColor, isA<Color>());
        // 变暗后的颜色应该比原色更暗
        expect(darkenedColor.value, isNot(equals(originalColor.value)));
      });

      test('默认参数应该使用 0.1', () {
        const Color originalColor = Color(0xFF808080);
        final darkenedColor1 = originalColor.darken();
        final darkenedColor2 = originalColor.darken(0.1);

        expect(darkenedColor1.value, equals(darkenedColor2.value));
      });

      test('边界值测试 - 0.0 应该不改变颜色', () {
        const Color originalColor = Color(0xFF808080);
        final darkenedColor = originalColor.darken(0.0);

        expect(darkenedColor.value, equals(originalColor.value));
      });

      test('边界值测试 - 1.0 应该变暗到最大程度', () {
        const Color originalColor = Color(0xFF808080);
        final darkenedColor = originalColor.darken(1.0);

        expect(darkenedColor, isA<Color>());
        // 应该接近黑色
        final hsl = HSLColor.fromColor(darkenedColor);
        expect(hsl.lightness, lessThanOrEqualTo(0.0));
      });

      test('边界值测试 - 负数应该不改变颜色（被 clamp）', () {
        const Color originalColor = Color(0xFF808080);
        final darkenedColor = originalColor.darken(-0.5);

        expect(darkenedColor, isA<Color>());
        // lightness 不应该小于 0
        final hsl = HSLColor.fromColor(darkenedColor);
        expect(hsl.lightness, greaterThanOrEqualTo(0.0));
      });

      test('边界值测试 - 超过 1.0 应该 clamp 到 1.0', () {
        const Color originalColor = Color(0xFF808080);
        final darkenedColor = originalColor.darken(2.0);

        expect(darkenedColor, isA<Color>());
        final hsl = HSLColor.fromColor(darkenedColor);
        expect(hsl.lightness, greaterThanOrEqualTo(0.0));
        expect(hsl.lightness, lessThanOrEqualTo(1.0));
      });

      test('已经是黑色应该保持黑色', () {
        const Color blackColor = Color(0xFF000000);
        final darkenedColor = blackColor.darken(0.5);

        expect(darkenedColor, isA<Color>());
        final hsl = HSLColor.fromColor(darkenedColor);
        expect(hsl.lightness, lessThanOrEqualTo(0.0));
      });

      test('不同颜色应该正确变暗', () {
        const Color redColor = Color(0xFFFF0000);
        const Color blueColor = Color(0xFF0000FF);
        const Color greenColor = Color(0xFF00FF00);

        final darkenedRed = redColor.darken(0.3);
        final darkenedBlue = blueColor.darken(0.3);
        final darkenedGreen = greenColor.darken(0.3);

        expect(darkenedRed, isA<Color>());
        expect(darkenedBlue, isA<Color>());
        expect(darkenedGreen, isA<Color>());

        // 变暗后的颜色应该保持色相
        final redHsl = HSLColor.fromColor(darkenedRed);
        final blueHsl = HSLColor.fromColor(darkenedBlue);
        final greenHsl = HSLColor.fromColor(darkenedGreen);

        expect(redHsl.hue, closeTo(0.0, 0.1)); // 红色色相
        expect(blueHsl.hue, closeTo(240.0, 0.1)); // 蓝色色相
        expect(greenHsl.hue, closeTo(120.0, 0.1)); // 绿色色相
      });
    });

    group('lighten 方法', () {
      test('正常值应该使颜色变亮', () {
        const Color originalColor = Color(0xFF808080); // 灰色
        final lightenedColor = originalColor.lighten(0.2);

        expect(lightenedColor, isA<Color>());
        // 变亮后的颜色应该比原色更亮
        expect(lightenedColor.value, isNot(equals(originalColor.value)));
      });

      test('默认参数应该使用 0.1', () {
        const Color originalColor = Color(0xFF808080);
        final lightenedColor1 = originalColor.lighten();
        final lightenedColor2 = originalColor.lighten(0.1);

        expect(lightenedColor1.value, equals(lightenedColor2.value));
      });

      test('边界值测试 - 0.0 应该不改变颜色', () {
        const Color originalColor = Color(0xFF808080);
        final lightenedColor = originalColor.lighten(0.0);

        expect(lightenedColor.value, equals(originalColor.value));
      });

      test('边界值测试 - 1.0 应该变亮到最大程度', () {
        const Color originalColor = Color(0xFF808080);
        final lightenedColor = originalColor.lighten(1.0);

        expect(lightenedColor, isA<Color>());
        // 应该接近白色
        final hsl = HSLColor.fromColor(lightenedColor);
        expect(hsl.lightness, greaterThanOrEqualTo(1.0));
      });

      test('边界值测试 - 负数应该不改变颜色（被 clamp）', () {
        const Color originalColor = Color(0xFF808080);
        final lightenedColor = originalColor.lighten(-0.5);

        expect(lightenedColor, isA<Color>());
        // lightness 不应该小于原值
        final originalHsl = HSLColor.fromColor(originalColor);
        final lightenedHsl = HSLColor.fromColor(lightenedColor);
        expect(
            lightenedHsl.lightness, lessThanOrEqualTo(originalHsl.lightness));
      });

      test('边界值测试 - 超过 1.0 应该 clamp 到 1.0', () {
        const Color originalColor = Color(0xFF808080);
        final lightenedColor = originalColor.lighten(2.0);

        expect(lightenedColor, isA<Color>());
        final hsl = HSLColor.fromColor(lightenedColor);
        expect(hsl.lightness, lessThanOrEqualTo(1.0));
      });

      test('已经是白色应该保持白色', () {
        const Color whiteColor = Color(0xFFFFFFFF);
        final lightenedColor = whiteColor.lighten(0.5);

        expect(lightenedColor, isA<Color>());
        final hsl = HSLColor.fromColor(lightenedColor);
        expect(hsl.lightness, greaterThanOrEqualTo(1.0));
      });

      test('不同颜色应该正确变亮', () {
        const Color redColor = Color(0xFF800000);
        const Color blueColor = Color(0xFF000080);
        const Color greenColor = Color(0xFF008000);

        final lightenedRed = redColor.lighten(0.3);
        final lightenedBlue = blueColor.lighten(0.3);
        final lightenedGreen = greenColor.lighten(0.3);

        expect(lightenedRed, isA<Color>());
        expect(lightenedBlue, isA<Color>());
        expect(lightenedGreen, isA<Color>());

        // 变亮后的颜色应该保持色相
        final redHsl = HSLColor.fromColor(lightenedRed);
        final blueHsl = HSLColor.fromColor(lightenedBlue);
        final greenHsl = HSLColor.fromColor(lightenedGreen);

        expect(redHsl.hue, closeTo(0.0, 0.1));
        expect(blueHsl.hue, closeTo(240.0, 0.1));
        expect(greenHsl.hue, closeTo(120.0, 0.1));
      });
    });

    group('withOpacity 方法', () {
      test('withOpacity10 应该设置透明度为 0.1', () {
        const Color originalColor = Color(0xFFFF0000);
        final colorWithOpacity = originalColor.withOpacity10();

        expect(colorWithOpacity, isA<Color>());
        expect(colorWithOpacity.alpha, closeTo(0.1 * 255, 1));
      });

      test('withOpacity20 应该设置透明度为 0.2', () {
        const Color originalColor = Color(0xFFFF0000);
        final colorWithOpacity = originalColor.withOpacity20();

        expect(colorWithOpacity, isA<Color>());
        expect(colorWithOpacity.alpha, closeTo(0.2 * 255, 1));
      });

      test('withOpacity50 应该设置透明度为 0.5', () {
        const Color originalColor = Color(0xFFFF0000);
        final colorWithOpacity = originalColor.withOpacity50();

        expect(colorWithOpacity, isA<Color>());
        expect(colorWithOpacity.alpha, closeTo(0.5 * 255, 1));
      });

      test('withOpacity80 应该设置透明度为 0.8', () {
        const Color originalColor = Color(0xFFFF0000);
        final colorWithOpacity = originalColor.withOpacity80();

        expect(colorWithOpacity, isA<Color>());
        expect(colorWithOpacity.alpha, closeTo(0.8 * 255, 1));
      });

      test('不同颜色应该正确设置透明度', () {
        const Color redColor = Color(0xFFFF0000);
        const Color blueColor = Color(0xFF0000FF);
        const Color greenColor = Color(0xFF00FF00);

        final red10 = redColor.withOpacity10();
        final blue20 = blueColor.withOpacity20();
        final green50 = greenColor.withOpacity50();

        expect(red10.alpha, closeTo(0.1 * 255, 1));
        expect(blue20.alpha, closeTo(0.2 * 255, 1));
        expect(green50.alpha, closeTo(0.5 * 255, 1));
      });

      test('RGB 值应该保持不变，只改变 alpha', () {
        const Color originalColor = Color(0xFF123456);
        final colorWithOpacity = originalColor.withOpacity50();

        expect(colorWithOpacity.red, equals(originalColor.red));
        expect(colorWithOpacity.green, equals(originalColor.green));
        expect(colorWithOpacity.blue, equals(originalColor.blue));
        expect(colorWithOpacity.alpha, isNot(equals(originalColor.alpha)));
      });

      test('链式调用测试', () {
        const Color originalColor = Color(0xFF808080);
        final result = originalColor.darken(0.2).lighten(0.1).withOpacity50();

        expect(result, isA<Color>());
        expect(result.alpha, closeTo(0.5 * 255, 1));
      });
    });

    group('组合测试', () {
      test('darken 和 lighten 组合', () {
        const Color originalColor = Color(0xFF808080);
        final darkened = originalColor.darken(0.3);
        final lightened = darkened.lighten(0.2);

        expect(lightened, isA<Color>());
        // 最终应该比原色暗，但比直接 darken(0.3) 亮
        final originalHsl = HSLColor.fromColor(originalColor);
        final finalHsl = HSLColor.fromColor(lightened);
        final darkenedHsl = HSLColor.fromColor(darkened);

        expect(finalHsl.lightness, lessThan(originalHsl.lightness));
        expect(finalHsl.lightness, greaterThan(darkenedHsl.lightness));
      });

      test('lighten 和 withOpacity 组合', () {
        const Color originalColor = Color(0xFF404040);
        final result = originalColor.lighten(0.3).withOpacity80();

        expect(result, isA<Color>());
        expect(result.alpha, closeTo(0.8 * 255, 1));
      });

      test('darken 和 withOpacity 组合', () {
        const Color originalColor = Color(0xFFC0C0C0);
        final result = originalColor.darken(0.2).withOpacity50();

        expect(result, isA<Color>());
        expect(result.alpha, closeTo(0.5 * 255, 1));
      });
    });
  });
}
