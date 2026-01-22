import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('IconTextButton 相关测试', () {
    const Icon testIcon = Icon(Icons.favorite);
    const Text testText = Text('Like');

    group('IconTextButtonConfig', () {
      test('构造函数应该正确创建配置', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          onPressed: () {},
        );

        expect(config.icon, equals(testIcon));
        expect(config.text, equals(testText));
        expect(config.onPressed, isNotNull);
        expect(config.direction, equals(Axis.horizontal));
        expect(config.spacing, equals(8.0));
      });

      test('copyWith 应该正确复制并更新属性', () {
        final config1 = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        );
        final config2 = config1.copyWith(
          backgroundColor: Colors.blue,
          borderRadius: 8.0,
        );

        expect(config2.icon, equals(config1.icon));
        expect(config2.text, equals(config1.text));
        expect(config2.backgroundColor, equals(Colors.blue));
        expect(config2.borderRadius, equals(8.0));
      });

      test('默认值应该正确设置', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        );

        expect(config.direction, equals(Axis.horizontal));
        expect(config.spacing, equals(8.0));
        expect(config.mainAxisAlignment, equals(MainAxisAlignment.center));
        expect(config.crossAxisAlignment, equals(CrossAxisAlignment.center));
      });
    });

    group('IconTextButton Widget', () {
      testWidgets('IconTextButton 应该正确构建', (WidgetTester tester) async {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        );
        final widget = IconTextButton(config: config);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.text('Like'), findsOneWidget);
      });

      testWidgets('水平布局应该使用 Row', (WidgetTester tester) async {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          direction: Axis.horizontal,
        );
        final widget = IconTextButton(config: config);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Column), findsNothing);
      });

      testWidgets('垂直布局应该使用 Column', (WidgetTester tester) async {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          direction: Axis.vertical,
        );
        final widget = IconTextButton(config: config);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(Row), findsNothing);
      });

      testWidgets('有背景色时应该创建 Container', (WidgetTester tester) async {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          backgroundColor: Colors.blue,
        );
        final widget = IconTextButton(config: config);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

        expect(find.byType(Container), findsWidgets);
      });
    });

    group('IconTextButtonExtension', () {
      test('bg 应该设置背景色', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).bg(Colors.red);

        expect(config.backgroundColor, equals(Colors.red));
      });

      test('fg 应该设置前景色', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).fg(Colors.blue);

        expect(config.foregroundColor, equals(Colors.blue));
      });

      test('pad 应该设置内边距', () {
        const EdgeInsets padding = EdgeInsets.all(16);
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).pad(padding);

        expect(config.padding, equals(padding));
      });

      test('padAll 应该设置所有方向的内边距', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).padAll(20);

        expect(config.padding, equals(EdgeInsets.all(20)));
      });

      test('gap 应该设置间距', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).gap(12);

        expect(config.spacing, equals(12));
      });

      test('radius 应该设置圆角', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).radius(10);

        expect(config.borderRadius, equals(10));
      });

      test('borderSide 应该设置边框', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).borderSide(color: Colors.black, width: 2);

        expect(config.border, isNotNull);
        expect(config.border?.color, equals(Colors.black));
        expect(config.border?.width, equals(2));
      });

      test('shadow 应该设置阴影', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).shadow(4);

        expect(config.elevation, equals(4));
      });

      test('horizontal 应该设置水平布局', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).horizontal();

        expect(config.direction, equals(Axis.horizontal));
      });

      test('vertical 应该设置垂直布局', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).vertical();

        expect(config.direction, equals(Axis.vertical));
      });

      test('dir 应该设置方向', () {
        final config1 = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).dir(Axis.horizontal);

        expect(config1.direction, equals(Axis.horizontal));

        final config2 = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).dir(Axis.vertical);

        expect(config2.direction, equals(Axis.vertical));
      });

      test('align 应该设置对齐方式', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        ).align(
          main: MainAxisAlignment.start,
          cross: CrossAxisAlignment.start,
        );

        expect(config.mainAxisAlignment, equals(MainAxisAlignment.start));
        expect(config.crossAxisAlignment, equals(CrossAxisAlignment.start));
      });

      test('align 只设置 main 应该保留 cross', () {
        final config1 = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          crossAxisAlignment: CrossAxisAlignment.end,
        );
        final config2 = config1.align(main: MainAxisAlignment.start);

        expect(config2.mainAxisAlignment, equals(MainAxisAlignment.start));
        expect(config2.crossAxisAlignment, equals(CrossAxisAlignment.end));
      });

      test('align 只设置 cross 应该保留 main', () {
        final config1 = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          mainAxisAlignment: MainAxisAlignment.end,
        );
        final config2 = config1.align(cross: CrossAxisAlignment.start);

        expect(config2.mainAxisAlignment, equals(MainAxisAlignment.end));
        expect(config2.crossAxisAlignment, equals(CrossAxisAlignment.start));
      });

      test('build 应该创建 IconTextButton', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        );
        final widget = config.build();

        expect(widget, isA<IconTextButton>());
        final button = widget as IconTextButton;
        expect(button.config, equals(config));
      });

      test('链式调用应该正确工作', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
        )
            .bg(Colors.blue)
            .fg(Colors.white)
            .padAll(16)
            .gap(8)
            .radius(12)
            .shadow(2)
            .horizontal();

        expect(config.backgroundColor, equals(Colors.blue));
        expect(config.foregroundColor, equals(Colors.white));
        expect(config.padding, equals(EdgeInsets.all(16)));
        expect(config.spacing, equals(8));
        expect(config.borderRadius, equals(12));
        expect(config.elevation, equals(2));
        expect(config.direction, equals(Axis.horizontal));
      });
    });

    group('IconTextButtonCreator', () {
      test('iconTextButton 应该创建水平布局配置', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          direction: Axis.horizontal,
        );

        expect(config.direction, equals(Axis.horizontal));
        expect(config.icon, equals(testIcon));
        expect(config.text, equals(testText));
      });

      test('iconTextButtonVertical 应该创建垂直布局配置', () {
        final config = IconTextButtonConfig(
          icon: testIcon,
          text: testText,
          direction: Axis.vertical,
        );

        expect(config.direction, equals(Axis.vertical));
        expect(config.icon, equals(testIcon));
        expect(config.text, equals(testText));
      });
    });
  });
}
