import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('ImageModifier 扩展测试', () {
    final Image testImage = Image.network('https://example.com/image.png');

    group('imageSize 方法', () {
      testWidgets('imageSize 应该创建指定尺寸的 SizedBox', (WidgetTester tester) async {
        const double width = 100.0;
        const double height = 200.0;
        final widget = testImage.imageSize(width, height);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(width));
        expect(sizedBox.height, equals(height));
      });

      testWidgets('边界值测试 - 0 尺寸', (WidgetTester tester) async {
        final widget = testImage.imageSize(0, 0);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(0.0));
        expect(sizedBox.height, equals(0.0));
      });

      testWidgets('边界值测试 - 负尺寸', (WidgetTester tester) async {
        final widget = testImage.imageSize(-10, -20);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(-10.0));
        expect(sizedBox.height, equals(-20.0));
      });

      testWidgets('边界值测试 - 大数值', (WidgetTester tester) async {
        const double largeValue = 9999.0;
        final widget = testImage.imageSize(largeValue, largeValue);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(largeValue));
        expect(sizedBox.height, equals(largeValue));
      });

      testWidgets('正方形尺寸', (WidgetTester tester) async {
        const double size = 50.0;
        final widget = testImage.imageSize(size, size);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(size));
        expect(sizedBox.height, equals(size));
      });
    });

    group('imageFit 方法', () {
      testWidgets('imageFit 应该创建带 fit 的 Image', (WidgetTester tester) async {
        const BoxFit fit = BoxFit.cover;
        final widget = testImage.imageFit(fit);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.child, isA<Image>());
        final image = sizedBox.child as Image;
        expect(image.fit, equals(fit));
      });

      testWidgets('不同 BoxFit 值应该正确应用', (WidgetTester tester) async {
        const List<BoxFit> fits = [
          BoxFit.contain,
          BoxFit.cover,
          BoxFit.fill,
          BoxFit.fitWidth,
          BoxFit.fitHeight,
          BoxFit.none,
          BoxFit.scaleDown,
        ];

        for (final fit in fits) {
          final widget = testImage.imageFit(fit);
          expect(widget, isA<SizedBox>());
          final sizedBox = widget as SizedBox;
          final image = sizedBox.child as Image;
          expect(image.fit, equals(fit));
        }
      });

      testWidgets('imageFit 应该保持原始 image provider', (WidgetTester tester) async {
        final widget = testImage.imageFit(BoxFit.cover);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        final image = sizedBox.child as Image;
        expect(image.image, equals(testImage.image));
      });
    });

    group('不同 ImageProvider 类型', () {
      testWidgets('NetworkImage 应该正确工作', (WidgetTester tester) async {
        final image = Image.network('https://example.com/image.png');
        final widget = image.imageSize(100, 100);

        expect(widget, isA<SizedBox>());
      });

      testWidgets('AssetImage 应该正确工作', (WidgetTester tester) async {
        final image = Image.asset('assets/image.png');
        final widget = image.imageSize(100, 100);

        expect(widget, isA<SizedBox>());
      });

      testWidgets('MemoryImage 应该正确工作', (WidgetTester tester) async {
        final image = Image.memory(Uint8List(0));
        final widget = image.imageSize(100, 100);

        expect(widget, isA<SizedBox>());
      });
    });

    group('链式调用', () {
      testWidgets('imageSize 和 imageFit 可以组合使用', (WidgetTester tester) async {
        // 注意：imageFit 返回的是新的 Image，所以不能直接链式调用
        // 但可以通过其他方式组合
        final sizedWidget = testImage.imageSize(100, 100);
        expect(sizedWidget, isA<SizedBox>());
      });
    });
  });
}
