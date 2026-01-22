import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('StringTextModifier 扩展测试', () {
    group('text getter', () {
      testWidgets('text 应该创建 Text Widget', (WidgetTester tester) async {
        const String text = 'Hello World';
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
      });

      testWidgets('空字符串应该创建空 Text Widget', (WidgetTester tester) async {
        const String text = '';
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(''));
      });

      testWidgets('特殊字符应该正确创建 Text Widget', (WidgetTester tester) async {
        const String text = 'Hello\nWorld\tTab';
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
      });

      testWidgets('中文字符应该正确创建 Text Widget', (WidgetTester tester) async {
        const String text = '你好世界';
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
      });

      testWidgets('emoji 字符应该正确创建 Text Widget', (WidgetTester tester) async {
        const String text = 'Hello 😀 World 🌍';
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
      });

      testWidgets('长文本应该正确创建 Text Widget', (WidgetTester tester) async {
        final String text = List.filled(1000, 'A').join();
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
        expect(textWidget.data?.length, equals(1000));
      });
    });

    group('textStyle 方法', () {
      testWidgets('textStyle 应该创建带样式的 Text Widget',
          (WidgetTester tester) async {
        const String text = 'Styled Text';
        const TextStyle style = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        );
        final widget = text.textStyle(style);

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
        expect(textWidget.style, equals(style));
      });

      testWidgets('空字符串和样式应该正确创建 Text Widget', (WidgetTester tester) async {
        const String text = '';
        const TextStyle style = TextStyle(fontSize: 20);
        final widget = text.textStyle(style);

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(''));
        expect(textWidget.style, equals(style));
      });

      testWidgets('不同 TextStyle 属性应该正确应用', (WidgetTester tester) async {
        const String text = 'Test';
        final style1 = TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontStyle: FontStyle.italic,
        );
        final widget1 = text.textStyle(style1);

        expect((widget1 as Text).style?.fontSize, equals(24));
        expect((widget1 as Text).style?.fontWeight, equals(FontWeight.bold));
        expect((widget1 as Text).style?.color, equals(Colors.blue));
        expect((widget1 as Text).style?.fontStyle, equals(FontStyle.italic));

        final style2 = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.green,
        );
        final widget2 = text.textStyle(style2);

        expect((widget2 as Text).style?.fontSize, equals(12));
        expect((widget2 as Text).style?.fontWeight, equals(FontWeight.normal));
        expect((widget2 as Text).style?.color, equals(Colors.green));
      });

      testWidgets('null TextStyle 应该创建无样式的 Text Widget',
          (WidgetTester tester) async {
        const String text = 'No Style';
        final widget = text.textStyle(const TextStyle());

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));
        expect(textWidget.style, isNotNull);
      });

      testWidgets('链式调用测试', (WidgetTester tester) async {
        const String text = 'Chain Test';
        final widget = text.text;

        expect(widget, isA<Text>());
        final textWidget = widget as Text;
        expect(textWidget.data, equals(text));

        // 可以继续链式调用 TextModifier 的方法
        final styledWidget = text.textStyle(
          const TextStyle(fontSize: 18, color: Colors.purple),
        );
        expect(styledWidget, isA<Text>());
      });
    });

    group('边界情况测试', () {
      testWidgets('只包含空格的字符串', (WidgetTester tester) async {
        const String text = '   ';
        final widget = text.text;

        expect(widget, isA<Text>());
        expect((widget as Text).data, equals('   '));
      });

      testWidgets('只包含换行符的字符串', (WidgetTester tester) async {
        const String text = '\n\n\n';
        final widget = text.text;

        expect(widget, isA<Text>());
        expect((widget as Text).data, equals('\n\n\n'));
      });

      testWidgets('包含 null 字符的字符串', (WidgetTester tester) async {
        const String text = 'Hello\u0000World';
        final widget = text.text;

        expect(widget, isA<Text>());
        expect((widget as Text).data, equals(text));
      });
    });
  });
}
