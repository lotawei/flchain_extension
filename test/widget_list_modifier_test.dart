import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('WidgetListModifier 扩展测试', () {
    group('toColumn 方法', () {
      testWidgets('toColumn 应该创建 Column Widget', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toColumn();

        expect(widget, isA<Column>());
        final column = widget as Column;
        expect(column.children.length, equals(testWidgets.length));
        expect(column.children[0], same(testWidgets[0]));
        expect(column.children[1], same(testWidgets[1]));
        expect(column.children[2], same(testWidgets[2]));
        expect(column.mainAxisAlignment, equals(MainAxisAlignment.start));
        expect(column.crossAxisAlignment, equals(CrossAxisAlignment.center));
        expect(column.mainAxisSize, equals(MainAxisSize.max));
      });

      testWidgets('toColumn 应该支持自定义参数', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
        );

        expect(widget, isA<Column>());
        final column = widget as Column;
        expect(column.mainAxisAlignment, equals(MainAxisAlignment.center));
        expect(column.crossAxisAlignment, equals(CrossAxisAlignment.start));
        expect(column.mainAxisSize, equals(MainAxisSize.min));
      });

      testWidgets('空列表应该创建空 Column', (WidgetTester tester) async {
        final emptyList = <Widget>[];
        final widget = emptyList.toColumn();

        expect(widget, isA<Column>());
        final column = widget as Column;
        expect(column.children, isEmpty);
      });

      testWidgets('单个元素应该创建 Column', (WidgetTester tester) async {
        final singleList = [const Text('Single')];
        final widget = singleList.toColumn();

        expect(widget, isA<Column>());
        final column = widget as Column;
        expect(column.children.length, equals(1));
      });
    });

    group('toRow 方法', () {
      testWidgets('toRow 应该创建 Row Widget', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toRow();

        expect(widget, isA<Row>());
        final row = widget as Row;
        expect(row.children.length, equals(testWidgets.length));
        expect(row.children[0], same(testWidgets[0]));
        expect(row.children[1], same(testWidgets[1]));
        expect(row.children[2], same(testWidgets[2]));
        expect(row.mainAxisAlignment, equals(MainAxisAlignment.start));
        expect(row.crossAxisAlignment, equals(CrossAxisAlignment.center));
        expect(row.mainAxisSize, equals(MainAxisSize.max));
      });

      testWidgets('toRow 应该支持自定义参数', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
        );

        expect(widget, isA<Row>());
        final row = widget as Row;
        expect(row.mainAxisAlignment, equals(MainAxisAlignment.spaceBetween));
        expect(row.crossAxisAlignment, equals(CrossAxisAlignment.end));
        expect(row.mainAxisSize, equals(MainAxisSize.min));
      });

      testWidgets('空列表应该创建空 Row', (WidgetTester tester) async {
        final emptyList = <Widget>[];
        final widget = emptyList.toRow();

        expect(widget, isA<Row>());
        final row = widget as Row;
        expect(row.children, isEmpty);
      });
    });

    group('toStack 方法', () {
      testWidgets('toStack 应该创建 Stack Widget', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toStack();

        expect(widget, isA<Stack>());
        final stack = widget as Stack;
        expect(stack.children.length, equals(testWidgets.length));
        expect(stack.children[0], same(testWidgets[0]));
        expect(stack.children[1], same(testWidgets[1]));
        expect(stack.children[2], same(testWidgets[2]));
        expect(stack.alignment, equals(AlignmentDirectional.topStart));
        expect(stack.fit, equals(StackFit.loose));
      });

      testWidgets('toStack 应该支持自定义参数', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toStack(
          alignment: Alignment.center,
          fit: StackFit.expand,
        );

        expect(widget, isA<Stack>());
        final stack = widget as Stack;
        expect(stack.alignment, equals(Alignment.center));
        expect(stack.fit, equals(StackFit.expand));
      });

      testWidgets('空列表应该创建空 Stack', (WidgetTester tester) async {
        final emptyList = <Widget>[];
        final widget = emptyList.toStack();

        expect(widget, isA<Stack>());
        final stack = widget as Stack;
        expect(stack.children, isEmpty);
      });
    });

    group('toWrap 方法', () {
      testWidgets('toWrap 应该创建 Wrap Widget', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toWrap();

        expect(widget, isA<Wrap>());
        final wrap = widget as Wrap;
        expect(wrap.children.length, equals(testWidgets.length));
        expect(wrap.children[0], same(testWidgets[0]));
        expect(wrap.children[1], same(testWidgets[1]));
        expect(wrap.children[2], same(testWidgets[2]));
        expect(wrap.spacing, equals(0));
        expect(wrap.runSpacing, equals(0));
        expect(wrap.alignment, equals(WrapAlignment.start));
      });

      testWidgets('toWrap 应该支持自定义参数', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        const double spacing = 8.0;
        const double runSpacing = 12.0;
        final widget = testWidgets.toWrap(
          spacing: spacing,
          runSpacing: runSpacing,
          alignment: WrapAlignment.center,
        );

        expect(widget, isA<Wrap>());
        final wrap = widget as Wrap;
        expect(wrap.spacing, equals(spacing));
        expect(wrap.runSpacing, equals(runSpacing));
        expect(wrap.alignment, equals(WrapAlignment.center));
      });

      testWidgets('空列表应该创建空 Wrap', (WidgetTester tester) async {
        final emptyList = <Widget>[];
        final widget = emptyList.toWrap();

        expect(widget, isA<Wrap>());
        final wrap = widget as Wrap;
        expect(wrap.children, isEmpty);
      });
    });

    group('toListView 方法', () {
      testWidgets('toListView 应该创建 ListView Widget',
          (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final widget = testWidgets.toListView();

        expect(widget, isA<ListView>());
        final listView = widget as ListView;
        expect(listView.scrollDirection, equals(Axis.vertical));
        expect(listView.shrinkWrap, isFalse);
      });

      testWidgets('toListView 应该支持自定义参数', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        const EdgeInsets padding = EdgeInsets.all(16);
        final widget = testWidgets.toListView(
          scrollDirection: Axis.horizontal,
          padding: padding,
          shrinkWrap: true,
        );

        expect(widget, isA<ListView>());
        final listView = widget as ListView;
        expect(listView.scrollDirection, equals(Axis.horizontal));
        expect(listView.padding, equals(padding));
        expect(listView.shrinkWrap, isTrue);
      });

      testWidgets('空列表应该创建空 ListView', (WidgetTester tester) async {
        final emptyList = <Widget>[];
        final widget = emptyList.toListView();

        expect(widget, isA<ListView>());
        final listView = widget as ListView;
        expect(listView.scrollDirection, equals(Axis.vertical));
        expect(listView.shrinkWrap, isFalse);
      });
    });

    group('withSpacing 方法', () {
      test('withSpacing 应该在元素之间添加间距', () {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        const double spacing = 8.0;
        final result = testWidgets.withSpacing(spacing);

        expect(result.length, equals(5)); // 3 widgets + 2 spacing widgets
        expect(result[0], same(testWidgets[0]));
        expect(result[1], isA<SizedBox>());
        expect(result[2], same(testWidgets[1]));
        expect(result[3], isA<SizedBox>());
        expect(result[4], same(testWidgets[2]));

        // 检查间距 Widget
        final spacingWidget1 = result[1] as SizedBox;
        expect(spacingWidget1.width, equals(spacing));
        expect(spacingWidget1.height, equals(spacing));
      });

      test('空列表应该返回空列表', () {
        final emptyList = <Widget>[];
        final result = emptyList.withSpacing(10);

        expect(result, isEmpty);
      });

      test('单元素列表应该返回原列表', () {
        final singleList = [const Text('Single')];
        final result = singleList.withSpacing(10);

        expect(result.length, equals(1));
        expect(result[0], same(singleList[0]));
      });

      test('边界值测试 - 0 间距', () {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final result = testWidgets.withSpacing(0);

        expect(result.length, equals(5));
        final spacingWidget = result[1] as SizedBox;
        expect(spacingWidget.width, equals(0.0));
        expect(spacingWidget.height, equals(0.0));
      });

      test('边界值测试 - 负间距', () {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final result = testWidgets.withSpacing(-10);

        expect(result.length, equals(5));
        final spacingWidget = result[1] as SizedBox;
        expect(spacingWidget.width, equals(-10.0));
        expect(spacingWidget.height, equals(-10.0));
      });
    });

    group('withDivider 方法', () {
      test('withDivider 应该在元素之间添加分隔线', () {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final result = testWidgets.withDivider();

        expect(result.length, equals(5)); // 3 widgets + 2 dividers
        expect(result[0], same(testWidgets[0]));
        expect(result[1], isA<Divider>());
        expect(result[2], same(testWidgets[1]));
        expect(result[3], isA<Divider>());
        expect(result[4], same(testWidgets[2]));
      });

      test('withDivider 应该支持自定义分隔线', () {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        const Widget customDivider = Divider(height: 2, color: Colors.red);
        final result = testWidgets.withDivider(divider: customDivider);

        expect(result.length, equals(5));
        expect(result[1], same(customDivider));
        expect(result[3], same(customDivider));
      });

      test('空列表应该返回空列表', () {
        final emptyList = <Widget>[];
        final result = emptyList.withDivider();

        expect(result, isEmpty);
      });

      test('单元素列表应该返回原列表', () {
        final singleList = [const Text('Single')];
        final result = singleList.withDivider();

        expect(result.length, equals(1));
        expect(result[0], same(singleList[0]));
      });

      test('默认分隔线应该使用 Divider', () {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final result = testWidgets.withDivider();

        expect(result[1], isA<Divider>());
        final divider = result[1] as Divider;
        expect(divider.height, equals(1));
      });
    });

    group('组合测试', () {
      testWidgets('可以链式调用多个方法', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final column = testWidgets.toColumn();
        expect(column, isA<Column>());

        final row = testWidgets.toRow();
        expect(row, isA<Row>());

        final stack = testWidgets.toStack();
        expect(stack, isA<Stack>());
      });

      testWidgets('withSpacing 后可以转换为 Column', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final spaced = testWidgets.withSpacing(8);
        final column = spaced.toColumn();

        expect(column, isA<Column>());
        final col = column as Column;
        expect(col.children.length, equals(5));
      });

      testWidgets('withDivider 后可以转换为 ListView', (WidgetTester tester) async {
        final List<Widget> testWidgets = [
          const Text('Widget 1'),
          const Text('Widget 2'),
          const Text('Widget 3'),
        ];
        final divided = testWidgets.withDivider();
        final listView = divided.toListView();

        expect(listView, isA<ListView>());
      });
    });
  });
}
