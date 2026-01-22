import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

class _TestClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

void main() {
  group('WidgetModifier 扩展测试', () {
    const Widget testWidget = Text('Test');

    group('尺寸相关', () {
      testWidgets('width 应该创建指定宽度的 SizedBox', (WidgetTester tester) async {
        const double width = 100.0;
        final widget = testWidget.width(width);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(width));
        expect(sizedBox.height, isNull);
      });

      testWidgets('height 应该创建指定高度的 SizedBox', (WidgetTester tester) async {
        const double height = 200.0;
        final widget = testWidget.height(height);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, isNull);
        expect(sizedBox.height, equals(height));
      });

      testWidgets('size 应该创建指定尺寸的 SizedBox', (WidgetTester tester) async {
        const double width = 100.0;
        const double height = 200.0;
        final widget = testWidget.size(width, height);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(width));
        expect(sizedBox.height, equals(height));
      });

      testWidgets('square 应该创建正方形 SizedBox', (WidgetTester tester) async {
        const double size = 50.0;
        final widget = testWidget.square(size);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(size));
        expect(sizedBox.height, equals(size));
      });

      testWidgets('边界值测试 - 0 尺寸', (WidgetTester tester) async {
        final widget = testWidget.size(0, 0);
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(0.0));
        expect(sizedBox.height, equals(0.0));
      });
    });

    group('Padding 相关', () {
      testWidgets('padding 应该创建 Padding Widget', (WidgetTester tester) async {
        const EdgeInsets padding = EdgeInsets.all(16.0);
        final widget = testWidget.padding(padding);

        expect(widget, isA<Padding>());
        final paddingWidget = widget as Padding;
        expect(paddingWidget.padding, equals(padding));
      });

      testWidgets('paddingAll 应该创建所有方向相同的 Padding',
          (WidgetTester tester) async {
        const double value = 20.0;
        final widget = testWidget.paddingAll(value);

        expect(widget, isA<Padding>());
        final paddingWidget = widget as Padding;
        expect(paddingWidget.padding, equals(EdgeInsets.all(value)));
      });

      testWidgets('paddingSymmetric 应该创建对称的 Padding',
          (WidgetTester tester) async {
        const double horizontal = 10.0;
        const double vertical = 20.0;
        final widget = testWidget.paddingSymmetric(
            horizontal: horizontal, vertical: vertical);

        expect(widget, isA<Padding>());
        final paddingWidget = widget as Padding;
        expect(
            paddingWidget.padding,
            equals(EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical)));
      });

      testWidgets('paddingOnly 应该创建指定方向的 Padding', (WidgetTester tester) async {
        final widget =
            testWidget.paddingOnly(left: 5, top: 10, right: 15, bottom: 20);

        expect(widget, isA<Padding>());
        final paddingWidget = widget as Padding;
        expect(
            paddingWidget.padding,
            equals(const EdgeInsets.only(
                left: 5, top: 10, right: 15, bottom: 20)));
      });
    });

    group('Margin 相关', () {
      testWidgets('margin 应该创建带 margin 的 Container',
          (WidgetTester tester) async {
        const EdgeInsets margin = EdgeInsets.all(16.0);
        final widget = testWidget.margin(margin);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.margin, equals(margin));
      });

      testWidgets('marginAll 应该创建所有方向相同的 margin', (WidgetTester tester) async {
        const double value = 20.0;
        final widget = testWidget.marginAll(value);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.margin, equals(EdgeInsets.all(value)));
      });
    });

    group('对齐相关', () {
      testWidgets('align 应该创建 Align Widget', (WidgetTester tester) async {
        const Alignment alignment = Alignment.center;
        final widget = testWidget.align(alignment);

        expect(widget, isA<Align>());
        final alignWidget = widget as Align;
        expect(alignWidget.alignment, equals(alignment));
      });

      testWidgets('center 应该创建 Center Widget', (WidgetTester tester) async {
        final widget = testWidget.center();

        expect(widget, isA<Center>());
      });

      testWidgets('alignLeft 应该创建左对齐的 Align', (WidgetTester tester) async {
        final widget = testWidget.alignLeft();

        expect(widget, isA<Align>());
        final alignWidget = widget as Align;
        expect(alignWidget.alignment, equals(Alignment.centerLeft));
      });

      testWidgets('alignRight 应该创建右对齐的 Align', (WidgetTester tester) async {
        final widget = testWidget.alignRight();

        expect(widget, isA<Align>());
        final alignWidget = widget as Align;
        expect(alignWidget.alignment, equals(Alignment.centerRight));
      });

      testWidgets('alignTop 应该创建顶部对齐的 Align', (WidgetTester tester) async {
        final widget = testWidget.alignTop();

        expect(widget, isA<Align>());
        final alignWidget = widget as Align;
        expect(alignWidget.alignment, equals(Alignment.topCenter));
      });

      testWidgets('alignBottom 应该创建底部对齐的 Align', (WidgetTester tester) async {
        final widget = testWidget.alignBottom();

        expect(widget, isA<Align>());
        final alignWidget = widget as Align;
        expect(alignWidget.alignment, equals(Alignment.bottomCenter));
      });
    });

    group('背景和装饰', () {
      testWidgets('background 应该创建带背景色的 Container',
          (WidgetTester tester) async {
        const Color color = Colors.red;
        final widget = testWidget.background(color);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.color, equals(color));
      });

      testWidgets('decorated 应该创建带装饰的 Container', (WidgetTester tester) async {
        const Color color = Colors.blue;
        const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
        final widget = testWidget.decorated(
          color: color,
          borderRadius: borderRadius,
        );

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(color));
        expect(decoration.borderRadius, equals(borderRadius));
      });

      testWidgets('cornerRadius 应该创建带圆角的 ClipRRect',
          (WidgetTester tester) async {
        const double radius = 10.0;
        final widget = testWidget.cornerRadius(radius);

        expect(widget, isA<ClipRRect>());
        final clipRRect = widget as ClipRRect;
        expect(clipRRect.borderRadius, equals(BorderRadius.circular(radius)));
      });

      testWidgets('rounded 应该创建默认圆角的 ClipRRect', (WidgetTester tester) async {
        final widget = testWidget.rounded();

        expect(widget, isA<ClipRRect>());
        final clipRRect = widget as ClipRRect;
        expect(clipRRect.borderRadius, equals(BorderRadius.circular(8)));
      });

      testWidgets('circle 应该创建 ClipOval', (WidgetTester tester) async {
        final widget = testWidget.circle();

        expect(widget, isA<ClipOval>());
      });

      testWidgets('border 应该创建带边框的 Container', (WidgetTester tester) async {
        const Color color = Colors.black;
        const double width = 2.0;
        const double radius = 5.0;
        final widget =
            testWidget.border(color: color, width: width, radius: radius);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
        expect(decoration.borderRadius, equals(BorderRadius.circular(radius)));
      });

      testWidgets('shadow 应该创建带阴影的 Container', (WidgetTester tester) async {
        const Color color = Colors.black26;
        const double blurRadius = 4.0;
        const Offset offset = Offset(0, 2);
        final widget = testWidget.shadow(
            color: color, blurRadius: blurRadius, offset: offset);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));
        expect(decoration.boxShadow!.first.color, equals(color));
        expect(decoration.boxShadow!.first.blurRadius, equals(blurRadius));
        expect(decoration.boxShadow!.first.offset, equals(offset));
      });
    });

    group('手势相关', () {
      testWidgets('onTap 应该创建 GestureDetector', (WidgetTester tester) async {
        bool tapped = false;
        final widget = testWidget.onTap(() {
          tapped = true;
        });

        expect(widget, isA<GestureDetector>());
        final gestureDetector = widget as GestureDetector;
        expect(gestureDetector.onTap, isNotNull);

        // 触发 tap
        gestureDetector.onTap?.call();
        expect(tapped, isTrue);
      });

      testWidgets('onLongPress 应该创建 GestureDetector',
          (WidgetTester tester) async {
        bool longPressed = false;
        final widget = testWidget.onLongPress(() {
          longPressed = true;
        });

        expect(widget, isA<GestureDetector>());
        final gestureDetector = widget as GestureDetector;
        expect(gestureDetector.onLongPress, isNotNull);

        // 触发 long press
        gestureDetector.onLongPress?.call();
        expect(longPressed, isTrue);
      });

      testWidgets('inkWell 应该创建 InkWell', (WidgetTester tester) async {
        bool tapped = false;
        final widget = testWidget.inkWell(
          onTap: () {
            tapped = true;
          },
        );

        expect(widget, isA<InkWell>());
        final inkWell = widget as InkWell;
        expect(inkWell.onTap, isNotNull);

        // 触发 tap
        inkWell.onTap?.call();
        expect(tapped, isTrue);
      });

      testWidgets('onDoubleTap 应该创建 GestureDetector',
          (WidgetTester tester) async {
        bool doubleTapped = false;
        final widget = testWidget.onDoubleTap(() {
          doubleTapped = true;
        });

        expect(widget, isA<GestureDetector>());
        final gestureDetector = widget as GestureDetector;
        expect(gestureDetector.onDoubleTap, isNotNull);

        gestureDetector.onDoubleTap?.call();
        expect(doubleTapped, isTrue);
      });

      testWidgets('onPanUpdate 应该创建 GestureDetector',
          (WidgetTester tester) async {
        bool panUpdated = false;
        final widget = testWidget.onPanUpdate((details) {
          panUpdated = true;
        });

        expect(widget, isA<GestureDetector>());
        final gestureDetector = widget as GestureDetector;
        expect(gestureDetector.onPanUpdate, isNotNull);

        gestureDetector.onPanUpdate?.call(DragUpdateDetails(
          globalPosition: Offset.zero,
          localPosition: Offset.zero,
          delta: Offset.zero,
        ));
        expect(panUpdated, isTrue);
      });

      testWidgets('onScaleUpdate 应该创建 GestureDetector',
          (WidgetTester tester) async {
        bool scaleUpdated = false;
        final widget = testWidget.onScaleUpdate((details) {
          scaleUpdated = true;
        });

        expect(widget, isA<GestureDetector>());
        final gestureDetector = widget as GestureDetector;
        expect(gestureDetector.onScaleUpdate, isNotNull);

        gestureDetector.onScaleUpdate?.call(ScaleUpdateDetails(
          scale: 1.0,
          focalPoint: Offset.zero,
          localFocalPoint: Offset.zero,
        ));
        expect(scaleUpdated, isTrue);
      });

      testWidgets('dismissible 应该创建 Dismissible', (WidgetTester tester) async {
        bool dismissed = false;
        final widget = testWidget.dismissible(
          key: const Key('test'),
          onDismissed: () {
            dismissed = true;
          },
        );

        expect(widget, isA<Dismissible>());
        final dismissible = widget as Dismissible;
        expect(dismissible.key, equals(const Key('test')));
        expect(dismissible.onDismissed, isNotNull);

        dismissible.onDismissed?.call(DismissDirection.startToEnd);
        expect(dismissed, isTrue);
      });

      testWidgets('draggable 应该创建 Draggable', (WidgetTester tester) async {
        final widget = testWidget.draggable<String>(
          data: 'test',
        );

        expect(widget, isA<Draggable<String>>());
        final draggable = widget as Draggable<String>;
        expect(draggable.data, equals('test'));
      });
    });

    group('可见性', () {
      testWidgets('visible true 应该显示 Widget', (WidgetTester tester) async {
        final widget = testWidget.visible(true);

        expect(widget, isA<Visibility>());
        final visibility = widget as Visibility;
        expect(visibility.visible, isTrue);
      });

      testWidgets('visible false 应该隐藏 Widget', (WidgetTester tester) async {
        final widget = testWidget.visible(false);

        expect(widget, isA<Visibility>());
        final visibility = widget as Visibility;
        expect(visibility.visible, isFalse);
      });

      testWidgets('opacity 应该创建 Opacity Widget', (WidgetTester tester) async {
        const double opacity = 0.5;
        final widget = testWidget.opacity(opacity);

        expect(widget, isA<Opacity>());
        final opacityWidget = widget as Opacity;
        expect(opacityWidget.opacity, equals(opacity));
      });
    });

    group('变换', () {
      testWidgets('rotate 应该创建 Transform.rotate', (WidgetTester tester) async {
        const double angle = 0.5;
        final widget = testWidget.rotate(angle);

        expect(widget, isA<Transform>());
        final transform = widget as Transform;
        expect(transform.transform, isNotNull);
      });

      testWidgets('scale 应该创建 Transform.scale', (WidgetTester tester) async {
        const double scale = 1.5;
        final widget = testWidget.scale(scale);

        expect(widget, isA<Transform>());
        final transform = widget as Transform;
        expect(transform.transform, isNotNull);
      });

      testWidgets('rotateDegrees 应该创建 Transform.rotate',
          (WidgetTester tester) async {
        const double degrees = 45.0;
        final widget = testWidget.rotateDegrees(degrees);

        expect(widget, isA<Transform>());
      });

      testWidgets('translate 应该创建 Transform.translate',
          (WidgetTester tester) async {
        const double x = 10.0;
        const double y = 20.0;
        final widget = testWidget.translate(x: x, y: y);

        expect(widget, isA<Transform>());
      });

      testWidgets('skew 应该创建 Transform', (WidgetTester tester) async {
        const double x = 0.1;
        const double y = 0.2;
        final widget = testWidget.skew(x: x, y: y);

        expect(widget, isA<Transform>());
      });
    });

    group('布局', () {
      testWidgets('expanded 应该创建 Expanded', (WidgetTester tester) async {
        const int flex = 2;
        final widget = testWidget.expanded(flex: flex);

        expect(widget, isA<Expanded>());
        final expanded = widget as Expanded;
        expect(expanded.flex, equals(flex));
      });

      testWidgets('flexible 应该创建 Flexible', (WidgetTester tester) async {
        const int flex = 1;
        const FlexFit fit = FlexFit.tight;
        final widget = testWidget.flexible(flex: flex, fit: fit);

        expect(widget, isA<Flexible>());
        final flexible = widget as Flexible;
        expect(flexible.flex, equals(flex));
        expect(flexible.fit, equals(fit));
      });

      testWidgets('flexibleSafe 应该创建 Flexible with loose fit',
          (WidgetTester tester) async {
        const int flex = 1;
        final widget = testWidget.flexibleSafe(flex: flex);

        expect(widget, isA<Flexible>());
        final flexible = widget as Flexible;
        expect(flexible.flex, equals(flex));
        expect(flexible.fit, equals(FlexFit.loose));
      });

      testWidgets('scrollable 应该创建 SingleChildScrollView',
          (WidgetTester tester) async {
        final widget = testWidget.scrollable();

        expect(widget, isA<SingleChildScrollView>());
        final scrollView = widget as SingleChildScrollView;
        expect(scrollView.scrollDirection, equals(Axis.vertical));
      });

      testWidgets('scrollable 水平方向应该创建水平滚动', (WidgetTester tester) async {
        final widget = testWidget.scrollable(axis: Axis.horizontal);

        expect(widget, isA<SingleChildScrollView>());
        final scrollView = widget as SingleChildScrollView;
        expect(scrollView.scrollDirection, equals(Axis.horizontal));
      });
    });

    group('其他功能', () {
      testWidgets('hero 应该创建 Hero Widget', (WidgetTester tester) async {
        const String tag = 'hero-tag';
        final widget = testWidget.hero(tag);

        expect(widget, isA<Hero>());
        final hero = widget as Hero;
        expect(hero.tag, equals(tag));
      });

      testWidgets('safeArea 应该创建 SafeArea', (WidgetTester tester) async {
        final widget = testWidget.safeArea();

        expect(widget, isA<SafeArea>());
        final safeArea = widget as SafeArea;
        expect(safeArea.top, isTrue);
        expect(safeArea.bottom, isTrue);
        expect(safeArea.left, isTrue);
        expect(safeArea.right, isTrue);
      });

      testWidgets('constrained 应该创建 ConstrainedBox',
          (WidgetTester tester) async {
        const double minWidth = 100.0;
        const double maxWidth = 200.0;
        final widget =
            testWidget.constrained(minWidth: minWidth, maxWidth: maxWidth);

        expect(widget, isA<ConstrainedBox>());
        final constrainedBox = widget as ConstrainedBox;
        expect(constrainedBox.constraints.minWidth, equals(minWidth));
        expect(constrainedBox.constraints.maxWidth, equals(maxWidth));
      });

      testWidgets('aspectRatio 应该创建 AspectRatio', (WidgetTester tester) async {
        const double aspectRatio = 16 / 9;
        final widget = testWidget.aspectRatio(aspectRatio);

        expect(widget, isA<AspectRatio>());
        final aspectRatioWidget = widget as AspectRatio;
        expect(aspectRatioWidget.aspectRatio, equals(aspectRatio));
      });

      testWidgets('card 应该创建 Card', (WidgetTester tester) async {
        const Color color = Colors.blue;
        const double elevation = 2.0;
        final widget = testWidget.card(color: color, elevation: elevation);

        expect(widget, isA<Card>());
        final card = widget as Card;
        expect(card.color, equals(color));
        expect(card.elevation, equals(elevation));
      });

      testWidgets('positioned 应该创建 Positioned', (WidgetTester tester) async {
        const double left = 10.0;
        const double top = 20.0;
        final widget = testWidget.positioned(left: left, top: top);

        expect(widget, isA<Positioned>());
        final positioned = widget as Positioned;
        expect(positioned.left, equals(left));
        expect(positioned.top, equals(top));
      });

      testWidgets('positionedFill 应该创建 Positioned.fill',
          (WidgetTester tester) async {
        final widget = testWidget.positionedFill();

        expect(widget, isA<Positioned>());
        final positioned = widget as Positioned;
        expect(positioned.left, equals(0.0));
        expect(positioned.top, equals(0.0));
        expect(positioned.right, equals(0.0));
        expect(positioned.bottom, equals(0.0));
      });

      testWidgets('fitted 应该创建 FittedBox', (WidgetTester tester) async {
        const BoxFit fit = BoxFit.cover;
        final widget = testWidget.fitted(fit: fit);

        expect(widget, isA<FittedBox>());
        final fittedBox = widget as FittedBox;
        expect(fittedBox.fit, equals(fit));
      });

      testWidgets('ignorePointer 应该创建 IgnorePointer',
          (WidgetTester tester) async {
        final widget = testWidget.ignorePointer(ignoring: true);

        expect(widget, isA<IgnorePointer>());
        final ignorePointer = widget as IgnorePointer;
        expect(ignorePointer.ignoring, isTrue);
      });

      testWidgets('absorbPointer 应该创建 AbsorbPointer',
          (WidgetTester tester) async {
        final widget = testWidget.absorbPointer(absorbing: true);

        expect(widget, isA<AbsorbPointer>());
        final absorbPointer = widget as AbsorbPointer;
        expect(absorbPointer.absorbing, isTrue);
      });

      testWidgets('material 应该创建 Material', (WidgetTester tester) async {
        const Color color = Colors.red;
        const double elevation = 2.0;
        final widget = testWidget.material(color: color, elevation: elevation);

        expect(widget, isA<Material>());
        final material = widget as Material;
        expect(material.color, equals(color));
        expect(material.elevation, equals(elevation));
      });

      testWidgets('tooltip 应该创建 Tooltip', (WidgetTester tester) async {
        const String message = 'Tooltip message';
        final widget = testWidget.tooltip(message);

        expect(widget, isA<Tooltip>());
        final tooltip = widget as Tooltip;
        expect(tooltip.message, equals(message));
      });

      testWidgets('semantics 应该创建 Semantics', (WidgetTester tester) async {
        const String label = 'Label';
        final widget = testWidget.semantics(label: label);

        expect(widget, isA<Semantics>());
        final semantics = widget as Semantics;
        expect(semantics.properties.label, equals(label));
        // 验证 widget 可以正常渲染
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        expect(find.byWidget(widget), findsOneWidget);
      });

      testWidgets('when true 应该返回原 Widget', (WidgetTester tester) async {
        final widget = testWidget.when(true);

        expect(widget, equals(testWidget));
      });

      testWidgets('when false 应该返回 SizedBox.shrink',
          (WidgetTester tester) async {
        final widget = testWidget.when(false);

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(0.0));
        expect(sizedBox.height, equals(0.0));
      });

      testWidgets('builder 应该应用 builder 函数', (WidgetTester tester) async {
        final widget = testWidget.builder((child) => Container(child: child));

        expect(widget, isA<Container>());
      });

      testWidgets('fullWidth 应该创建无限宽度的 SizedBox', (WidgetTester tester) async {
        final widget = testWidget.fullWidth();

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(double.infinity));
        expect(sizedBox.height, isNull);
      });

      testWidgets('fullHeight 应该创建无限高度的 SizedBox', (WidgetTester tester) async {
        final widget = testWidget.fullHeight();

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, isNull);
        expect(sizedBox.height, equals(double.infinity));
      });

      testWidgets('fullSize 应该创建 SizedBox.expand', (WidgetTester tester) async {
        final widget = testWidget.fullSize();

        expect(widget, isA<SizedBox>());
        final sizedBox = widget as SizedBox;
        expect(sizedBox.width, equals(double.infinity));
        expect(sizedBox.height, equals(double.infinity));
      });

      testWidgets('fractionallySized 应该创建 FractionallySizedBox',
          (WidgetTester tester) async {
        const double widthFactor = 0.5;
        const double heightFactor = 0.5;
        final widget = testWidget.fractionallySized(
            widthFactor: widthFactor, heightFactor: heightFactor);

        expect(widget, isA<FractionallySizedBox>());
        final fractionallySizedBox = widget as FractionallySizedBox;
        expect(fractionallySizedBox.widthFactor, equals(widthFactor));
        expect(fractionallySizedBox.heightFactor, equals(heightFactor));
      });

      testWidgets('unconstrained 应该创建 UnconstrainedBox',
          (WidgetTester tester) async {
        final widget = testWidget.unconstrained();

        expect(widget, isA<UnconstrainedBox>());
      });

      testWidgets('limitedBox 应该创建 LimitedBox', (WidgetTester tester) async {
        const double maxWidth = 100.0;
        const double maxHeight = 200.0;
        final widget =
            testWidget.limitedBox(maxWidth: maxWidth, maxHeight: maxHeight);

        expect(widget, isA<LimitedBox>());
        final limitedBox = widget as LimitedBox;
        expect(limitedBox.maxWidth, equals(maxWidth));
        expect(limitedBox.maxHeight, equals(maxHeight));
      });

      testWidgets('repaintBoundary 应该创建 RepaintBoundary',
          (WidgetTester tester) async {
        final widget = testWidget.repaintBoundary();

        expect(widget, isA<RepaintBoundary>());
      });

      testWidgets('offstage 应该创建 Offstage', (WidgetTester tester) async {
        final widget = testWidget.offstage(offstage: true);

        expect(widget, isA<Offstage>());
        final offstage = widget as Offstage;
        expect(offstage.offstage, isTrue);
      });

      testWidgets('sliverBox 应该创建 SliverToBoxAdapter',
          (WidgetTester tester) async {
        final widget = testWidget.sliverBox();

        expect(widget, isA<SliverToBoxAdapter>());
      });
    });

    group('渐变和效果', () {
      testWidgets('linearGradient 应该创建带线性渐变的 Container',
          (WidgetTester tester) async {
        const List<Color> colors = [Colors.red, Colors.blue];
        final widget = testWidget.linearGradient(colors: colors);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<LinearGradient>());
      });

      testWidgets('radialGradient 应该创建带径向渐变的 Container',
          (WidgetTester tester) async {
        const List<Color> colors = [Colors.red, Colors.blue];
        final widget = testWidget.radialGradient(colors: colors);

        expect(widget, isA<Container>());
        final container = widget as Container;
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<RadialGradient>());
      });

      testWidgets('blur 应该创建 ImageFiltered', (WidgetTester tester) async {
        final widget = testWidget.blur(sigmaX: 5, sigmaY: 5);

        expect(widget, isA<ImageFiltered>());
      });

      testWidgets('grayscale 应该创建 ColorFiltered', (WidgetTester tester) async {
        final widget = testWidget.grayscale();

        expect(widget, isA<ColorFiltered>());
      });

      testWidgets('colorFiltered 应该创建 ColorFiltered',
          (WidgetTester tester) async {
        final colorFilter = ColorFilter.mode(Colors.red, BlendMode.multiply);
        final widget = testWidget.colorFiltered(colorFilter);

        expect(widget, isA<ColorFiltered>());
        final colorFiltered = widget as ColorFiltered;
        expect(colorFiltered.colorFilter, equals(colorFilter));
      });

      testWidgets('shaderMask 应该创建 ShaderMask', (WidgetTester tester) async {
        final widget = testWidget.shaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.red, Colors.blue],
          ).createShader(bounds),
        );

        expect(widget, isA<ShaderMask>());
      });

      testWidgets('clipPath 应该创建 ClipPath', (WidgetTester tester) async {
        final clipper = _TestClipper();
        final widget = testWidget.clipPath(clipper);

        expect(widget, isA<ClipPath>());
        final clipPath = widget as ClipPath;
        expect(clipPath.clipper, same(clipper));
      });
    });

    group('高级功能', () {
      testWidgets('contextMenu 应该创建 GestureDetector',
          (WidgetTester tester) async {
        final widget = testWidget.contextMenu(
          items: [
            const PopupMenuItem(child: Text('Item 1')),
            const PopupMenuItem(child: Text('Item 2')),
          ],
        );

        expect(widget, isA<GestureDetector>());
      });

      testWidgets('refreshIndicator 应该创建 RefreshIndicator',
          (WidgetTester tester) async {
        final widget = testWidget.refreshIndicator(
          onRefresh: () async {},
        );

        expect(widget, isA<RefreshIndicator>());
        final refreshIndicator = widget as RefreshIndicator;
        expect(refreshIndicator.onRefresh, isNotNull);
      });

      testWidgets('notificationListener 应该创建 NotificationListener',
          (WidgetTester tester) async {
        final widget = testWidget.notificationListener<ScrollNotification>(
          onNotification: (notification) => true,
        );

        expect(widget, isA<NotificationListener<ScrollNotification>>());
      });

      testWidgets('themed 应该创建 Builder', (WidgetTester tester) async {
        final widget = testWidget.themed((context, theme) {
          return Container();
        });

        expect(widget, isA<Builder>());
      });

      testWidgets('responsive 应该创建 LayoutBuilder', (WidgetTester tester) async {
        final widget = testWidget.responsive(
          onMobile: (context) => const Text('Mobile'),
          onTablet: (context) => const Text('Tablet'),
          onDesktop: (context) => const Text('Desktop'),
        );

        expect(widget, isA<LayoutBuilder>());
      });

      testWidgets('ifElse true 应该应用 ifTrue', (WidgetTester tester) async {
        final widget = testWidget.ifElse(
          true,
          (child) => Container(child: child),
        );

        expect(widget, isA<Container>());
      });

      testWidgets('ifElse false 应该应用 ifFalse', (WidgetTester tester) async {
        final widget = testWidget.ifElse(
          false,
          (child) => Container(child: child),
          (child) => Padding(padding: EdgeInsets.all(8), child: child),
        );

        expect(widget, isA<Padding>());
      });

      testWidgets('ifElse false 没有 ifFalse 应该返回原 Widget',
          (WidgetTester tester) async {
        final widget = testWidget.ifElse(
          false,
          (child) => Container(child: child),
        );

        expect(widget, equals(testWidget));
      });

      testWidgets('apply 应该应用修饰器函数', (WidgetTester tester) async {
        final widget = testWidget.apply((child) => Container(child: child));

        expect(widget, isA<Container>());
      });

      testWidgets('sliverPadding 应该创建 SliverPadding',
          (WidgetTester tester) async {
        final widget = testWidget.sliverPadding(EdgeInsets.all(16));

        expect(widget, isA<SliverPadding>());
        final sliverPadding = widget as SliverPadding;
        expect(sliverPadding.padding, equals(EdgeInsets.all(16)));
      });
    });

    group('动画相关', () {
      testWidgets('animatedOpacity 应该创建 AnimatedOpacity',
          (WidgetTester tester) async {
        const double opacity = 0.5;
        final widget = testWidget.animatedOpacity(opacity: opacity);

        expect(widget, isA<AnimatedOpacity>());
        final animatedOpacity = widget as AnimatedOpacity;
        expect(animatedOpacity.opacity, equals(opacity));
      });

      testWidgets('animatedScale 应该创建 AnimatedScale',
          (WidgetTester tester) async {
        const double scale = 1.5;
        final widget = testWidget.animatedScale(scale: scale);

        expect(widget, isA<AnimatedScale>());
        final animatedScale = widget as AnimatedScale;
        expect(animatedScale.scale, equals(scale));
      });

      testWidgets('animatedSlide 应该创建 AnimatedSlide',
          (WidgetTester tester) async {
        const Offset offset = Offset(0.5, 0.5);
        final widget = testWidget.animatedSlide(offset: offset);

        expect(widget, isA<AnimatedSlide>());
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        expect(find.byType(AnimatedSlide), findsOneWidget);
      });

      testWidgets('animatedContainer 应该创建 AnimatedContainer',
          (WidgetTester tester) async {
        const Color color = Colors.red;
        final widget = testWidget.animatedContainer(color: color);

        expect(widget, isA<AnimatedContainer>());
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        expect(find.byType(AnimatedContainer), findsOneWidget);
      });

      testWidgets('animatedPadding 应该创建 AnimatedPadding',
          (WidgetTester tester) async {
        const EdgeInsets padding = EdgeInsets.all(16);
        final widget = testWidget.animatedPadding(padding: padding);

        expect(widget, isA<AnimatedPadding>());
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        expect(find.byType(AnimatedPadding), findsOneWidget);
      });

      testWidgets('animatedAlign 应该创建 AnimatedAlign',
          (WidgetTester tester) async {
        const Alignment alignment = Alignment.center;
        final widget = testWidget.animatedAlign(alignment: alignment);

        expect(widget, isA<AnimatedAlign>());
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        expect(find.byType(AnimatedAlign), findsOneWidget);
      });
    });

    group('链式调用测试', () {
      testWidgets('多个修饰器可以链式调用', (WidgetTester tester) async {
        final widget = testWidget
            .width(100)
            .height(200)
            .paddingAll(16)
            .background(Colors.blue)
            .cornerRadius(8);

        expect(widget, isA<ClipRRect>());
      });

      testWidgets('复杂链式调用', (WidgetTester tester) async {
        final widget = testWidget
            .size(100, 100)
            .paddingSymmetric(horizontal: 10, vertical: 20)
            .marginAll(5)
            .align(Alignment.center)
            .background(Colors.red)
            .cornerRadius(10)
            .shadow();

        expect(widget, isA<Container>());
      });
    });
  });
}
