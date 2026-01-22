import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('动画 Widget 实现测试', () {
    const Widget testChild = Text('Test');

    group('fadeIn 动画', () {
      testWidgets('fadeIn 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.fadeIn();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('fadeIn 应该支持自定义参数', (WidgetTester tester) async {
        final widget = testChild.fadeIn(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('fadeOut 动画', () {
      testWidgets('fadeOut 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.fadeOut();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('scaleIn 动画', () {
      testWidgets('scaleIn 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.scaleIn();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('scaleIn 应该支持自定义 begin', (WidgetTester tester) async {
        final widget = testChild.scaleIn(begin: 0.5);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('slideIn 动画', () {
      testWidgets('slideInFromLeft 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.slideInFromLeft();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('slideInFromRight 应该创建动画 Widget',
          (WidgetTester tester) async {
        final widget = testChild.slideInFromRight();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('slideInFromTop 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.slideInFromTop();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('slideInFromBottom 应该创建动画 Widget',
          (WidgetTester tester) async {
        final widget = testChild.slideInFromBottom();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('bounceIn 动画', () {
      testWidgets('bounceIn 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.bounceIn();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('rotateIn 动画', () {
      testWidgets('rotateIn 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.rotateIn();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('rotateIn 应该支持自定义 turns', (WidgetTester tester) async {
        final widget = testChild.rotateIn(turns: 2);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('shake 动画', () {
      testWidgets('shake 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.shake();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('shake 应该支持自定义 intensity', (WidgetTester tester) async {
        final widget = testChild.shake(intensity: 20);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('pulse 动画', () {
      testWidgets('pulse 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.pulse();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pump(); // pulse 是无限循环动画，不能使用 pumpAndSettle
        await tester.pump(const Duration(milliseconds: 100)); // 确保 delay 完成

        expect(find.text('Test'), findsOneWidget);

        // 清理 widget 确保定时器被取消
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pump();
      });
    });

    group('blink 动画', () {
      testWidgets('blink 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.blink();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pump(); // blink 是无限循环动画，不能使用 pumpAndSettle
        await tester.pump(const Duration(milliseconds: 100)); // 确保 delay 完成

        expect(find.text('Test'), findsOneWidget);

        // 清理 widget 确保定时器被取消
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pump();
      });
    });

    group('fadeSlideIn 动画', () {
      testWidgets('fadeSlideIn 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.fadeSlideIn();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('fadeSlideIn 应该支持自定义 offset', (WidgetTester tester) async {
        const Offset offset = Offset(0.5, 0.5);
        final widget = testChild.fadeSlideIn(beginOffset: offset);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('Anim Widget', () {
      testWidgets('Anim.fadeIn() 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.animate(Anim.fadeIn());

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('Anim.scale() 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.animate(Anim.scale());

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('Anim.bounce() 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.animate(Anim.bounce());

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('Anim.shake() 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.animate(Anim.shake());

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('Anim.pulse() 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.animate(Anim.pulse());

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pump(); // pulse 是无限循环动画，不能使用 pumpAndSettle
        await tester.pump(const Duration(milliseconds: 100)); // 确保 delay 完成

        expect(find.text('Test'), findsOneWidget);

        // 清理 widget 确保定时器被取消
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pump();
      });

      testWidgets('Anim.blink() 应该创建动画 Widget', (WidgetTester tester) async {
        final widget = testChild.animate(Anim.blink());

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pump(); // blink 是无限循环动画，不能使用 pumpAndSettle
        await tester.pump(const Duration(milliseconds: 100)); // 确保 delay 完成

        expect(find.text('Test'), findsOneWidget);

        // 清理 widget 确保定时器被取消
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pump();

        // 清理 widget 确保定时器被取消
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pump();
      });
    });

    group('动画生命周期', () {
      testWidgets('动画应该正确初始化和销毁', (WidgetTester tester) async {
        final widget = testChild.fadeIn();

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pump(); // 初始化
        await tester.pumpAndSettle(); // 等待动画完成

        expect(find.text('Test'), findsOneWidget);

        // 移除 widget 应该正确清理
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pump();
      });
    });

    group('链式调用', () {
      testWidgets('动画可以与其他修饰器链式调用', (WidgetTester tester) async {
        final widget =
            testChild.fadeIn().paddingAll(16).background(Colors.blue);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('高级动画效果', () {
      group('smoke 效果', () {
        testWidgets('smoke 应该创建动画 Widget', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.smoke());

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });

        testWidgets('smoke 应该支持自定义参数', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.smoke(
            duration: const Duration(milliseconds: 500),
            smokeColor: Colors.grey,
            intensity: 0.8,
          ));

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });
      });

      group('fire 效果', () {
        testWidgets('fire 应该创建动画 Widget', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.fire());

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });

        testWidgets('fire 应该支持自定义参数', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.fire(
            duration: const Duration(milliseconds: 1000),
            fireColor: Colors.orange,
            intensity: 0.9,
            repeat: true,
          ));

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });
      });

      group('snow 效果', () {
        testWidgets('snow 应该创建动画 Widget', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.snow());

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });

        testWidgets('snow 应该支持自定义参数', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.snow(
            duration: const Duration(milliseconds: 2000),
            snowColor: Colors.white,
            intensity: 0.7,
            repeat: true,
          ));

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });
      });

      group('broken 效果', () {
        testWidgets('broken 应该创建动画 Widget', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.broken());

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });

        testWidgets('broken 应该支持自定义参数', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.broken(
            duration: const Duration(milliseconds: 600),
            brokenPieces: 12,
            intensity: 0.9,
          ));

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });
      });

      group('glitch 效果', () {
        testWidgets('glitch 应该创建动画 Widget', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.glitch());

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });

        testWidgets('glitch 应该支持自定义参数', (WidgetTester tester) async {
          final widget = testChild.animate(Anim.glitch(
            duration: const Duration(milliseconds: 300),
            intensity: 0.7,
            repeat: true,
          ));

          await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.text('Test'), findsOneWidget);
        });
      });
    });
  });
}
