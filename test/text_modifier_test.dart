import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('TextModifier 扩展测试', () {
    const String testData = 'Hello World';
    final Text testText = const Text(testData);

    group('字体大小和粗细', () {
      testWidgets('fontSize 应该设置字体大小', (WidgetTester tester) async {
        const double fontSize = 24.0;
        final text = testText.fontSize(fontSize);

        expect(text, isA<Text>());
        expect(text.data, equals(testData));
        expect(text.style?.fontSize, equals(fontSize));
      });

      testWidgets('fontWeight 应该设置字体粗细', (WidgetTester tester) async {
        const FontWeight weight = FontWeight.bold;
        final text = testText.fontWeight(weight);

        expect(text, isA<Text>());
        expect(text.style?.fontWeight, equals(weight));
      });

      testWidgets('bold 应该设置字体为粗体', (WidgetTester tester) async {
        final text = testText.bold();

        expect(text, isA<Text>());
        expect(text.style?.fontWeight, equals(FontWeight.bold));
      });

      testWidgets('边界值测试 - 0 字体大小', (WidgetTester tester) async {
        final text = testText.fontSize(0);

        expect(text.style?.fontSize, equals(0.0));
      });

      testWidgets('边界值测试 - 负数字体大小', (WidgetTester tester) async {
        final text = testText.fontSize(-10);

        expect(text.style?.fontSize, equals(-10.0));
      });

      testWidgets('边界值测试 - 大字体大小', (WidgetTester tester) async {
        const double largeSize = 999.0;
        final text = testText.fontSize(largeSize);

        expect(text.style?.fontSize, equals(largeSize));
      });
    });

    group('颜色和样式', () {
      testWidgets('textColor 应该设置文本颜色', (WidgetTester tester) async {
        const Color color = Colors.red;
        final text = testText.textColor(color);

        expect(text, isA<Text>());
        expect(text.style?.color, equals(color));
      });

      testWidgets('aligned 应该设置文本对齐方式', (WidgetTester tester) async {
        const TextAlign align = TextAlign.center;
        final text = testText.aligned(align);

        expect(text, isA<Text>());
        expect(text.textAlign, equals(align));
      });

      testWidgets('underline 应该添加下划线', (WidgetTester tester) async {
        final text = testText.underline();

        expect(text, isA<Text>());
        expect(text.style?.decoration, equals(TextDecoration.underline));
      });

      testWidgets('lineThrough 应该添加删除线', (WidgetTester tester) async {
        final text = testText.lineThrough();

        expect(text, isA<Text>());
        expect(text.style?.decoration, equals(TextDecoration.lineThrough));
      });

      testWidgets('italic 应该设置斜体', (WidgetTester tester) async {
        final text = testText.italic();

        expect(text, isA<Text>());
        expect(text.style?.fontStyle, equals(FontStyle.italic));
      });
    });

    group('间距和行高', () {
      testWidgets('letterSpacing 应该设置字母间距', (WidgetTester tester) async {
        const double spacing = 2.0;
        final text = testText.letterSpacing(spacing);

        expect(text, isA<Text>());
        expect(text.style?.letterSpacing, equals(spacing));
      });

      testWidgets('lineHeight 应该设置行高', (WidgetTester tester) async {
        const double height = 1.5;
        final text = testText.lineHeight(height);

        expect(text, isA<Text>());
        expect(text.style?.height, equals(height));
      });

      testWidgets('fontFamily 应该设置字体族', (WidgetTester tester) async {
        const String family = 'Arial';
        final text = testText.fontFamily(family);

        expect(text, isA<Text>());
        expect(text.style?.fontFamily, equals(family));
      });
    });

    group('阴影', () {
      testWidgets('shadow 应该添加阴影', (WidgetTester tester) async {
        const Color color = Colors.black26;
        const double blurRadius = 2.0;
        const Offset offset = Offset(1, 1);
        final text = testText.shadow(
            color: color, blurRadius: blurRadius, offset: offset);

        expect(text, isA<Text>());
        expect(text.style?.shadows, isNotNull);
        expect(text.style?.shadows?.length, equals(1));
        expect(text.style?.shadows?.first.color, equals(color));
        expect(text.style?.shadows?.first.blurRadius, equals(blurRadius));
        expect(text.style?.shadows?.first.offset, equals(offset));
      });

      testWidgets('shadow 默认参数应该使用默认值', (WidgetTester tester) async {
        final text = testText.shadow();

        expect(text.style?.shadows, isNotNull);
        expect(text.style?.shadows?.length, equals(1));
        expect(text.style?.shadows?.first.color, equals(Colors.black26));
        expect(text.style?.shadows?.first.blurRadius, equals(2.0));
        expect(text.style?.shadows?.first.offset, equals(const Offset(1, 1)));
      });
    });

    group('溢出处理', () {
      testWidgets('ellipsis 应该设置溢出为省略号', (WidgetTester tester) async {
        final text = testText.ellipsis();

        expect(text, isA<Text>());
        expect(text.maxLines, equals(1));
        expect(text.overflow, equals(TextOverflow.ellipsis));
      });

      testWidgets('lines 应该设置最大行数', (WidgetTester tester) async {
        const int maxLines = 3;
        final text = testText.lines(maxLines);

        expect(text, isA<Text>());
        expect(text.maxLines, equals(maxLines));
        expect(text.overflow, equals(TextOverflow.ellipsis));
      });

      testWidgets('lines 0 应该不限制行数', (WidgetTester tester) async {
        final text = testText.lines(0);

        expect(text.maxLines, isNull);
      });
    });

    group('null 值处理', () {
      testWidgets('data 为空字符串时应该正确处理', (WidgetTester tester) async {
        final Text emptyText = const Text('');
        final text = emptyText.fontSize(16);

        expect(text.data, equals(''));
        expect(text.style?.fontSize, equals(16.0));
      });

      testWidgets('style 为 null 时应该创建新样式', (WidgetTester tester) async {
        const Text noStyleText = Text(testData, style: null);
        final text = noStyleText.fontSize(20);

        expect(text.style, isNotNull);
        expect(text.style?.fontSize, equals(20.0));
      });
    });

    group('链式调用', () {
      testWidgets('多个修饰器可以链式调用', (WidgetTester tester) async {
        final text = testText
            .fontSize(24)
            .bold()
            .textColor(Colors.blue)
            .underline()
            .letterSpacing(2);

        expect(text.style?.fontSize, equals(24.0));
        expect(text.style?.fontWeight, equals(FontWeight.bold));
        expect(text.style?.color, equals(Colors.blue));
        expect(text.style?.decoration, equals(TextDecoration.underline));
        expect(text.style?.letterSpacing, equals(2.0));
      });

      testWidgets('复杂链式调用', (WidgetTester tester) async {
        final text = testText
            .fontSize(18)
            .fontWeight(FontWeight.w500)
            .textColor(Colors.red)
            .aligned(TextAlign.center)
            .lines(2)
            .shadow(color: Colors.black54, blurRadius: 4);

        expect(text.style?.fontSize, equals(18.0));
        expect(text.style?.fontWeight, equals(FontWeight.w500));
        expect(text.style?.color, equals(Colors.red));
        expect(text.textAlign, equals(TextAlign.center));
        expect(text.maxLines, equals(2));
        expect(text.style?.shadows?.length, equals(1));
      });
    });

    group('组合测试', () {
      testWidgets('bold 和 italic 可以组合', (WidgetTester tester) async {
        final text = testText.bold().italic();

        expect(text.style?.fontWeight, equals(FontWeight.bold));
        expect(text.style?.fontStyle, equals(FontStyle.italic));
      });

      testWidgets('underline 和 lineThrough 不能同时存在',
          (WidgetTester tester) async {
        final text = testText.underline().lineThrough();

        // lineThrough 会覆盖 underline
        expect(text.style?.decoration, equals(TextDecoration.lineThrough));
      });

      testWidgets('ellipsis 和 lines 可以组合', (WidgetTester tester) async {
        final text = testText.lines(2).ellipsis();

        expect(text.maxLines, equals(1)); // ellipsis 会设置 maxLines 为 1
        expect(text.overflow, equals(TextOverflow.ellipsis));
      });
    });
  });
}
