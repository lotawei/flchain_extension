import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ==================== 基础扩展 ====================

extension WidgetModifier on Widget {
  // 尺寸相关
  Widget width(double width) => SizedBox(width: width, child: this);

  Widget height(double height) => SizedBox(height: height, child: this);

  Widget size(double width, double height) =>
      SizedBox(width: width, height: height, child: this);

  Widget square(double size) =>
      SizedBox(width: size, height: size, child: this);

  // Padding 相关
  Widget padding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);

  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  // Margin 相关（通过 Container 实现）
  Widget margin(EdgeInsetsGeometry margin) =>
      Container(margin: margin, child: this);

  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  // 对齐相关
  Widget align(AlignmentGeometry alignment) =>
      Align(alignment: alignment, child: this);

  Widget center() => Center(child: this);

  Widget alignLeft() => Align(alignment: Alignment.centerLeft, child: this);

  Widget alignRight() => Align(alignment: Alignment.centerRight, child: this);

  Widget alignTop() => Align(alignment: Alignment.topCenter, child: this);

  Widget alignBottom() => Align(alignment: Alignment.bottomCenter, child: this);

  // 背景和装饰
  Widget background(Color color) => Container(color: color, child: this);

  Widget decorated({
    Color? color,
    DecorationImage? image,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          image: image,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          gradient: gradient,
        ),
        child: this,
      );

  Widget cornerRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  Widget rounded() =>
      ClipRRect(borderRadius: BorderRadius.circular(8), child: this);

  Widget circle() => ClipOval(child: this);

  // 边框
  Widget border({
    Color color = Colors.black,
    double width = 1,
    double radius = 0,
  }) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: width),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: this,
      );

  // 阴影
  Widget shadow({
    Color color = Colors.black26,
    double blurRadius = 4,
    Offset offset = const Offset(0, 2),
  }) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: color, blurRadius: blurRadius, offset: offset),
          ],
        ),
        child: this,
      );

  // 手势相关
  Widget onTap(VoidCallback onTap) => GestureDetector(
        onTap: () {
          onTap();
        },
        child: this,
      );

  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  Widget inkWell({
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? splashColor,
  }) =>
      InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        splashColor: splashColor,
        child: this,
      );

  // 可见性
  Widget visible(bool visible) => Visibility(visible: visible, child: this);

  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  // 旋转和变换
  Widget rotate(double angle) => Transform.rotate(angle: angle, child: this);

  Widget scale(double scale) => Transform.scale(scale: scale, child: this);

  // 灵活布局
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// 安全版本的 flexible，适用于可滚动容器中的 Column
  /// 自动使用 FlexFit.loose，避免 unbounded height 约束错误
  Widget flexibleSafe({int flex = 1}) =>
      Flexible(flex: flex, fit: FlexFit.loose, child: this);

  // 滚动
  Widget scrollable({Axis axis = Axis.vertical}) =>
      SingleChildScrollView(scrollDirection: axis, child: this);

  // Hero 动画
  Widget hero(String tag) => Hero(tag: tag, child: this);

  // SafeArea
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(top: top, bottom: bottom, left: left, right: right, child: this);

  // 约束
  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: maxWidth ?? double.infinity,
          minHeight: minHeight ?? 0,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: this,
      );

  Widget aspectRatio(double aspectRatio) =>
      AspectRatio(aspectRatio: aspectRatio, child: this);

  // 卡片效果
  Widget card({
    Color? color,
    double elevation = 1,
    ShapeBorder? shape,
    EdgeInsetsGeometry? margin,
  }) =>
      Card(
        color: color,
        elevation: elevation,
        shape: shape,
        margin: margin,
        child: this,
      );

  // 定位相关
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) =>
      Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
        child: this,
      );

  Widget positionedFill({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Positioned.fill(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: this,
      );

  // FittedBox
  Widget fitted({BoxFit fit = BoxFit.contain}) =>
      FittedBox(fit: fit, child: this);

  // IgnorePointer
  Widget ignorePointer({bool ignoring = true}) =>
      IgnorePointer(ignoring: ignoring, child: this);

  Widget absorbPointer({bool absorbing = true}) =>
      AbsorbPointer(absorbing: absorbing, child: this);

  // Material 效果
  Widget material({
    Color color = Colors.transparent,
    double elevation = 0,
    BorderRadius? borderRadius,
  }) =>
      Material(
        color: color,
        elevation: elevation,
        borderRadius: borderRadius,
        child: this,
      );

  // Tooltip
  Widget tooltip(String message) => Tooltip(message: message, child: this);

  // Semantics
  Widget semantics({String? label, bool? button}) =>
      Semantics(label: label, button: button, child: this);

  // 条件显示
  Widget when(bool condition) => condition ? this : const SizedBox.shrink();

  // 包装 Builder
  Widget builder(Widget Function(Widget child) builder) => builder(this);

  // 动画相关
  Widget animatedOpacity({
    required double opacity,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        curve: curve,
        child: this,
      );

  Widget animatedScale({
    required double scale,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedScale(
        scale: scale,
        duration: duration,
        curve: curve,
        child: this,
      );

  Widget animatedSlide({
    required Offset offset,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedSlide(
        offset: offset,
        duration: duration,
        curve: curve,
        child: this,
      );

  // ColorFiltered
  Widget colorFiltered(ColorFilter colorFilter) =>
      ColorFiltered(colorFilter: colorFilter, child: this);

  Widget grayscale() => ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: this,
      );

  // ShaderMask
  Widget shaderMask({
    required Shader Function(Rect bounds) shaderCallback,
    BlendMode blendMode = BlendMode.modulate,
  }) =>
      ShaderMask(
        shaderCallback: shaderCallback,
        blendMode: blendMode,
        child: this,
      );

  // RepaintBoundary (性能优化)
  Widget repaintBoundary() => RepaintBoundary(child: this);

  // Offstage
  Widget offstage({bool offstage = true}) =>
      Offstage(offstage: offstage, child: this);

  // SliverToBoxAdapter
  Widget sliverBox() => SliverToBoxAdapter(child: this);

  // 无限宽度/高度
  Widget fullWidth() => SizedBox(width: double.infinity, child: this);
  Widget fullHeight() => SizedBox(height: double.infinity, child: this);
  Widget fullSize() => SizedBox.expand(child: this);

  // FractionallySizedBox
  Widget fractionallySized({
    double? widthFactor,
    double? heightFactor,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        alignment: alignment,
        child: this,
      );

  // UnconstrainedBox
  Widget unconstrained({Axis? constrainedAxis}) =>
      UnconstrainedBox(constrainedAxis: constrainedAxis, child: this);

  // LimitedBox
  Widget limitedBox({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) =>
      LimitedBox(maxWidth: maxWidth, maxHeight: maxHeight, child: this);

  // 更多手势
  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);

  Widget onPanUpdate(void Function(DragUpdateDetails) onPanUpdate) =>
      GestureDetector(onPanUpdate: onPanUpdate, child: this);

  Widget onScaleUpdate(void Function(ScaleUpdateDetails) onScaleUpdate) =>
      GestureDetector(onScaleUpdate: onScaleUpdate, child: this);

  // Dismissible
  Widget dismissible({
    required Key key,
    VoidCallback? onDismissed,
    DismissDirection direction = DismissDirection.horizontal,
    Widget? background,
  }) =>
      Dismissible(
        key: key,
        onDismissed: (_) => onDismissed?.call(),
        direction: direction,
        background: background ?? Container(color: Colors.red),
        child: this,
      );

  // Draggable
  Widget draggable<T extends Object>({
    required T data,
    Widget? feedback,
    Widget? childWhenDragging,
  }) =>
      Draggable<T>(
        data: data,
        feedback: feedback ?? this,
        childWhenDragging: childWhenDragging,
        child: this,
      );

  // 更多动画
  Widget animatedContainer({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
    BoxDecoration? decoration,
  }) =>
      AnimatedContainer(
        duration: duration,
        curve: curve,
        color: decoration == null ? color : null,
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration: decoration,
        child: this,
      );

  Widget animatedPadding({
    required EdgeInsetsGeometry padding,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedPadding(
        padding: padding,
        duration: duration,
        curve: curve,
        child: this,
      );

  Widget animatedAlign({
    required AlignmentGeometry alignment,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedAlign(
        alignment: alignment,
        duration: duration,
        curve: curve,
        child: this,
      );

  Widget animatedPositioned({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) =>
      AnimatedPositioned(
        duration: duration,
        curve: curve,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
        child: this,
      );

  // 渐变背景
  Widget linearGradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) =>
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors, begin: begin, end: end),
        ),
        child: this,
      );

  Widget radialGradient({
    required List<Color> colors,
    double radius = 0.5,
    AlignmentGeometry center = Alignment.center,
  }) =>
      Container(
        decoration: BoxDecoration(
          gradient:
              RadialGradient(colors: colors, radius: radius, center: center),
        ),
        child: this,
      );

  // 模糊效果
  Widget blur({double sigmaX = 5, double sigmaY = 5}) => ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: this,
      );

  // ClipPath
  Widget clipPath(CustomClipper<Path> clipper) =>
      ClipPath(clipper: clipper, child: this);

  // 旋转角度（度数）
  Widget rotateDegrees(double degrees) =>
      Transform.rotate(angle: degrees * 3.14159265359 / 180, child: this);

  // 平移
  Widget translate({double x = 0, double y = 0}) =>
      Transform.translate(offset: Offset(x, y), child: this);

  // 倾斜
  Widget skew({double x = 0, double y = 0}) =>
      Transform(transform: Matrix4.skew(x, y), child: this);

  // 长按菜单
  Widget contextMenu({required List<PopupMenuEntry> items}) => GestureDetector(
        onLongPressStart: (details) {
          // 需要在 StatefulWidget 中使用 showMenu
        },
        child: this,
      );

  // 刷新指示器
  Widget refreshIndicator({
    required Future<void> Function() onRefresh,
    Color? color,
  }) =>
      RefreshIndicator(onRefresh: onRefresh, color: color, child: this);

  // 通知监听
  Widget notificationListener<T extends Notification>({
    required bool Function(T) onNotification,
  }) =>
      NotificationListener<T>(onNotification: onNotification, child: this);

  // 主题相关
  Widget themed(
    Widget Function(BuildContext context, ThemeData theme) builder,
  ) =>
      Builder(builder: (context) => builder(context, Theme.of(context)));

  // MediaQuery 响应式
  Widget responsive({
    Widget Function(BuildContext)? onMobile,
    Widget Function(BuildContext)? onTablet,
    Widget Function(BuildContext)? onDesktop,
  }) =>
      LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600 && onMobile != null) {
            return onMobile(context);
          } else if (constraints.maxWidth < 1200 && onTablet != null) {
            return onTablet(context);
          } else if (onDesktop != null) {
            return onDesktop(context);
          }
          return this;
        },
      );

  // 根据条件构建
  Widget ifElse(
    bool condition,
    Widget Function(Widget) ifTrue, [
    Widget Function(Widget)? ifFalse,
  ]) =>
      condition ? ifTrue(this) : (ifFalse?.call(this) ?? this);

  // 应用多个修饰器
  Widget apply(Widget Function(Widget) modifier) => modifier(this);

  // Sliver 系列
  Widget sliverPadding(EdgeInsetsGeometry padding) => SliverPadding(
        padding: padding,
        sliver: SliverToBoxAdapter(child: this),
      );

  // ==================== iOS UIView.animate 风格动画 ====================

  /// 淡入动画 (类似 iOS fadeIn)
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeIn,
  }) =>
      _FadeInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        child: this,
      );

  /// 淡出动画
  Widget fadeOut({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
  }) =>
      _FadeOutWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        child: this,
      );

  /// 缩放进入 (从小变大)
  Widget scaleIn({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutBack,
    double begin = 0.0,
  }) =>
      _ScaleInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        begin: begin,
        child: this,
      );

  /// 从左滑入
  Widget slideInFromLeft({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
  }) =>
      _SlideInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        beginOffset: const Offset(-1, 0),
        child: this,
      );

  /// 从右滑入
  Widget slideInFromRight({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
  }) =>
      _SlideInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        beginOffset: const Offset(1, 0),
        child: this,
      );

  /// 从上滑入
  Widget slideInFromTop({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
  }) =>
      _SlideInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        beginOffset: const Offset(0, -1),
        child: this,
      );

  /// 从下滑入
  Widget slideInFromBottom({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
  }) =>
      _SlideInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        beginOffset: const Offset(0, 1),
        child: this,
      );

  /// 弹跳效果
  Widget bounceIn({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
  }) =>
      _ScaleInWidget(
        duration: duration,
        delay: delay,
        curve: Curves.elasticOut,
        begin: 0.3,
        child: this,
      );

  /// 旋转进入
  Widget rotateIn({
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    double turns = 1,
  }) =>
      _RotateInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        turns: turns,
        child: this,
      );

  /// 抖动效果 (类似错误提示)
  Widget shake({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
    double intensity = 10,
  }) =>
      _ShakeWidget(
        duration: duration,
        delay: delay,
        intensity: intensity,
        child: this,
      );

  /// 脉冲效果 (循环)
  Widget pulse({
    Duration duration = const Duration(milliseconds: 1000),
    double minScale = 0.95,
    double maxScale = 1.05,
  }) =>
      _PulseWidget(
        duration: duration,
        minScale: minScale,
        maxScale: maxScale,
        child: this,
      );

  /// 闪烁效果 (循环)
  Widget blink({
    Duration duration = const Duration(milliseconds: 1000),
    double minOpacity = 0.3,
  }) =>
      _BlinkWidget(duration: duration, minOpacity: minOpacity, child: this);

  /// 组合动画：淡入+滑入
  Widget fadeSlideIn({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    Offset beginOffset = const Offset(0, 0.2),
  }) =>
      _FadeSlideInWidget(
        duration: duration,
        delay: delay,
        curve: curve,
        beginOffset: beginOffset,
        child: this,
      );

  // ==================== 统一动画 API ====================

  /// 统一动画接口
  /// ```dart
  /// widget.animate(Anim.fadeIn(duration: 300.ms))
  /// widget.animate(Anim.scale(trigger: AnimTrigger.onTap))
  /// widget.animate(Anim.pulse(repeat: true))
  /// ```
  Widget animate(Anim anim) => _UnifiedAnimWidget(anim: anim, child: this);
}

// ==================== 动画配置 ====================

/// 动画触发方式
enum AnimTrigger {
  /// 自动播放（出现时）
  auto,

  /// 点击触发
  onTap,

  /// 长按触发
  onLongPress,
}

/// 统一动画配置
class Anim {
  final AnimType type;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool repeat;
  final AnimTrigger trigger;
  final Offset? slideOffset;
  final double? scaleBegin;
  final double? turns;
  final double? intensity;
  // 新效果参数
  final Color? smokeColor;
  final Color? fireColor;
  final Color? snowColor;
  final int? brokenPieces;

  const Anim._({
    required this.type,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.repeat = false,
    this.trigger = AnimTrigger.auto,
    this.slideOffset,
    this.scaleBegin,
    this.turns,
    this.intensity,
    this.smokeColor,
    this.fireColor,
    this.snowColor,
    this.brokenPieces,
  });

  /// 淡入
  static Anim fadeIn({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeIn,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.fadeIn,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
      );

  /// 淡出
  static Anim fadeOut({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.fadeOut,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
      );

  /// 缩放
  static Anim scale({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutBack,
    double begin = 0.0,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.scale,
        duration: duration,
        delay: delay,
        curve: curve,
        scaleBegin: begin,
        repeat: repeat,
        trigger: trigger,
      );

  /// 弹跳
  static Anim bounce({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.bounce,
        duration: duration,
        delay: delay,
        curve: Curves.elasticOut,
        scaleBegin: 0.3,
        repeat: repeat,
        trigger: trigger,
      );

  /// 从左滑入
  static Anim slideLeft({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.slide,
        duration: duration,
        delay: delay,
        curve: curve,
        slideOffset: const Offset(-1, 0),
        repeat: repeat,
        trigger: trigger,
      );

  /// 从右滑入
  static Anim slideRight({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.slide,
        duration: duration,
        delay: delay,
        curve: curve,
        slideOffset: const Offset(1, 0),
        repeat: repeat,
        trigger: trigger,
      );

  /// 从上滑入
  static Anim slideTop({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.slide,
        duration: duration,
        delay: delay,
        curve: curve,
        slideOffset: const Offset(0, -1),
        repeat: repeat,
        trigger: trigger,
      );

  /// 从下滑入
  static Anim slideBottom({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.slide,
        duration: duration,
        delay: delay,
        curve: curve,
        slideOffset: const Offset(0, 1),
        repeat: repeat,
        trigger: trigger,
      );

  /// 旋转
  static Anim rotate({
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    double turns = 1,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.rotate,
        duration: duration,
        delay: delay,
        curve: curve,
        turns: turns,
        repeat: repeat,
        trigger: trigger,
      );

  /// 抖动
  static Anim shake({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
    double intensity = 10,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.shake,
        duration: duration,
        delay: delay,
        intensity: intensity,
        repeat: repeat,
        trigger: trigger,
      );

  /// 脉冲
  static Anim pulse({
    Duration duration = const Duration(milliseconds: 1000),
    bool repeat = true,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.pulse,
        duration: duration,
        repeat: repeat,
        trigger: trigger,
      );

  /// 闪烁
  static Anim blink({
    Duration duration = const Duration(milliseconds: 1000),
    bool repeat = true,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.blink,
        duration: duration,
        repeat: repeat,
        trigger: trigger,
      );

  /// 淡入+滑入组合
  static Anim fadeSlide({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    Offset offset = const Offset(0, 0.2),
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
  }) =>
      Anim._(
        type: AnimType.fadeSlide,
        duration: duration,
        delay: delay,
        curve: curve,
        slideOffset: offset,
        repeat: repeat,
        trigger: trigger,
      );

  /// 流光效果（Shimmer）- 渐变高光扫过效果
  /// 常用于加载状态或强调效果
  static Anim shimmer({
    Duration duration = const Duration(milliseconds: 1500),
    Duration delay = Duration.zero,
    Curve curve = Curves.linear,
    bool repeat = true,
    AnimTrigger trigger = AnimTrigger.auto,
    Offset direction = const Offset(1, 0), // 默认从上到下
    Color highlightColor = Colors.orange,
    double highlightOpacity = 0.2,
    double width = 0.02, // 流光宽度（相对于总宽度）
  }) =>
      Anim._(
        type: AnimType.shimmer,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
        slideOffset: direction, // 复用 slideOffset 存储方向
        scaleBegin: highlightOpacity, // 复用 scaleBegin 存储透明度
        intensity: width, // 复用 intensity 存储宽度
      );

  /// 盐雾效果（Smoke）- 从底部向上扩散的模糊粒子效果
  /// 适合过渡和消失动画
  static Anim smoke({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
    Color smokeColor = const Color(0xFF808080), // 默认灰色
    double intensity = 0.7, // 粒子数量和密度（0.0-1.0）
  }) =>
      Anim._(
        type: AnimType.smoke,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
        smokeColor: smokeColor,
        intensity: intensity,
      );

  /// 火焰效果（Fire）- 底部向上跳动的火焰形状，颜色从红到黄渐变
  /// 适合强调和警告场景
  static Anim fire({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
    Color fireColor = const Color(0xFFFF6B35), // 默认橙红色
    double intensity = 0.8, // 火焰高度和跳动幅度（0.0-1.0）
  }) =>
      Anim._(
        type: AnimType.fire,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
        fireColor: fireColor,
        intensity: intensity,
      );

  /// 雪花效果（Snow）- 从顶部向下飘落的雪花粒子
  /// 适合冬季主题和装饰效果
  static Anim snow({
    Duration duration = const Duration(milliseconds: 2000),
    Duration delay = Duration.zero,
    Curve curve = Curves.linear,
    bool repeat = true,
    AnimTrigger trigger = AnimTrigger.auto,
    Color snowColor = const Color(0xFFFFFFFF), // 默认白色
    double intensity = 0.7, // 雪花数量和密度（0.0-1.0）
  }) =>
      Anim._(
        type: AnimType.snow,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
        snowColor: snowColor,
        intensity: intensity,
      );

  /// 玻璃破碎效果（Broken）- 从中心向外扩散的裂纹，碎片分离效果
  /// 适合错误或破坏性操作反馈
  static Anim broken({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool repeat = false,
    AnimTrigger trigger = AnimTrigger.auto,
    int brokenPieces = 10, // 碎片数量（默认8-12片）
    double intensity = 0.9, // 破碎程度（0.0-1.0）
  }) =>
      Anim._(
        type: AnimType.broken,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
        brokenPieces: brokenPieces,
        intensity: intensity,
      );

  /// 故障效果（Glitch）- RGB 通道分离、水平位移、随机噪音、模糊
  /// 适合科技感和错误提示
  static Anim glitch({
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.linear,
    bool repeat = true,
    AnimTrigger trigger = AnimTrigger.auto,
    double intensity = 0.6, // 故障强度（0.0-1.0）
  }) =>
      Anim._(
        type: AnimType.glitch,
        duration: duration,
        delay: delay,
        curve: curve,
        repeat: repeat,
        trigger: trigger,
        intensity: intensity,
      );
}

enum AnimType {
  fadeIn,
  fadeOut,
  scale,
  bounce,
  slide,
  rotate,
  shake,
  pulse,
  blink,
  fadeSlide,
  shimmer,
  smoke, // 盐雾效果
  fire, // 火焰效果
  snow, // 雪花效果
  broken, // 玻璃破碎
  glitch, // 故障效果
}

// ==================== Text 专用扩展 ====================

extension TextModifier on Text {
  Text fontSize(double size) => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(fontSize: size),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text fontWeight(FontWeight weight) => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(fontWeight: weight),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text bold() => fontWeight(FontWeight.bold);

  Text textColor(Color color) => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(color: color),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text aligned(TextAlign align) => Text(
        data ?? '',
        style: style,
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text lines(int count) => Text(
        data ?? '',
        style: style,
        textAlign: textAlign,
        maxLines: count == 0 ? null : count,
        overflow: overflow ?? TextOverflow.ellipsis,
      );

  Text underline() => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(
          decoration: TextDecoration.underline,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text lineThrough() => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(
          decoration: TextDecoration.lineThrough,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text italic() => Text(
        data ?? '',
        style:
            (style ?? const TextStyle()).copyWith(fontStyle: FontStyle.italic),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text letterSpacing(double spacing) => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(letterSpacing: spacing),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text lineHeight(double height) => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(height: height),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text fontFamily(String family) => Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(fontFamily: family),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text shadow({
    Color color = Colors.black26,
    double blurRadius = 2,
    Offset offset = const Offset(1, 1),
  }) =>
      Text(
        data ?? '',
        style: (style ?? const TextStyle()).copyWith(
          shadows: [
            Shadow(color: color, blurRadius: blurRadius, offset: offset)
          ],
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text ellipsis() => Text(
        data ?? '',
        style: style,
        textAlign: textAlign,
        maxLines: 1, // ellipsis 总是设置 maxLines 为 1
        overflow: TextOverflow.ellipsis,
      );
}

// ==================== Icon 专用扩展 ====================

extension IconModifier on Icon {
  Icon iconSize(double size) => Icon(icon, size: size, color: color);

  Icon iconColor(Color color) => Icon(icon, size: size, color: color);
}

// ==================== Image 专用扩展 ====================

extension ImageModifier on Image {
  Widget imageSize(double width, double height) =>
      SizedBox(width: width, height: height, child: this);

  Widget imageFit(BoxFit fit) => SizedBox(
        child: Image(image: image, fit: fit),
      );
}

// ==================== Container 专用扩展 ====================

extension ContainerModifier on Container {
  Container backgroundColor(Color color) {
    // Container 没有公开的 width/height getter，这些值在构造时会被转换为 constraints
    // 如果原 Container 有 constraints，保留 constraints
    // 如果原 Container 没有 constraints，尝试从 constraints 中提取 maxWidth/maxHeight
    // 注意：当用户创建 Container(width: 100) 时，Container 内部会创建 constraints，
    // 但 constraints 属性可能仍然是 null（如果用户没有显式传入）
    // 在这种情况下，我们无法获取原始的 width/height 值

    // 尝试从 constraints 中提取 width/height
    // 只有当 constraints 是简单的 maxWidth/maxHeight 约束（minWidth/minHeight 为 0）
    // 且能够同时提取 width 和 height 时，才提取；否则保留 constraints
    double? extractedWidth;
    double? extractedHeight;
    BoxConstraints? remainingConstraints;

    if (constraints != null) {
      final canExtractWidth = constraints!.minWidth == 0 &&
          constraints!.maxWidth != double.infinity;
      final canExtractHeight = constraints!.minHeight == 0 &&
          constraints!.maxHeight != double.infinity;

      if (canExtractWidth && canExtractHeight) {
        // 可以完全提取为 width/height
        extractedWidth = constraints!.maxWidth;
        extractedHeight = constraints!.maxHeight;
        remainingConstraints = null;
      } else {
        // 保留 constraints（不能部分提取，因为 constraints 会覆盖 width/height）
        remainingConstraints = constraints;
      }
    }

    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      color: decoration == null ? color : null,
      decoration: decoration != null
          ? (decoration as BoxDecoration).copyWith(color: color)
          : null,
      margin: margin,
      constraints: remainingConstraints,
      width: extractedWidth,
      height: extractedHeight,
      child: child,
    );
  }
}

// ==================== List<Widget> 扩展 ====================

extension WidgetListModifier on List<Widget> {
  Widget toColumn({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    bool shrinkWrap = false,
  }) =>
      Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: shrinkWrap ? MainAxisSize.min : mainAxisSize,
        children: this,
      );

  Widget toRow({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) =>
      Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: this,
      );

  Widget toStack({
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    StackFit fit = StackFit.loose,
  }) =>
      Stack(alignment: alignment, fit: fit, children: this);

  Widget toWrap({
    double spacing = 0,
    double runSpacing = 0,
    WrapAlignment alignment = WrapAlignment.start,
  }) =>
      Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        children: this,
      );

  Widget toListView({
    Axis scrollDirection = Axis.vertical,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
  }) =>
      ListView(
        scrollDirection: scrollDirection,
        padding: padding,
        shrinkWrap: shrinkWrap,
        children: this,
      );

  // 添加间距
  List<Widget> withSpacing(double spacing) {
    if (isEmpty) return this;
    return expand((widget) sync* {
      yield widget;
      yield SizedBox(width: spacing, height: spacing);
    }).toList()
      ..removeLast();
  }

  List<Widget> withDivider({Widget? divider}) {
    if (isEmpty) return this;
    final div = divider ?? const Divider(height: 1);
    return expand((widget) sync* {
      yield widget;
      yield div;
    }).toList()
      ..removeLast();
  }
}

// ==================== num 扩展 (用于间距) ====================

extension NumSpacingModifier on num {
  Widget get hGap => SizedBox(width: toDouble());
  Widget get vGap => SizedBox(height: toDouble());
  Widget get gap => SizedBox(width: toDouble(), height: toDouble());

  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get left => EdgeInsets.only(left: toDouble());
  EdgeInsets get right => EdgeInsets.only(right: toDouble());
  EdgeInsets get top => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble());

  BorderRadius get circular => BorderRadius.circular(toDouble());
  Radius get radius => Radius.circular(toDouble());

  Duration get ms => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
}

// ==================== String 扩展 (快速创建 Text) ====================

extension StringTextModifier on String {
  Text get text => Text(this);
  Text textStyle(TextStyle style) => Text(this, style: style);
}

// ==================== Color 扩展 ====================

extension ColorModifier on Color {
  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color withOpacity10() => withValues(alpha: 0.1);
  Color withOpacity20() => withValues(alpha: 0.2);
  Color withOpacity50() => withValues(alpha: 0.5);
  Color withOpacity80() => withValues(alpha: 0.8);
}

// ==================== 动画 Widget 实现 ====================

/// 淡入动画
class _FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  const _FadeInWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
  });
  @override
  State<_FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<_FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _animation, child: widget.child);
}

/// 淡出动画
class _FadeOutWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  const _FadeOutWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
  });
  @override
  State<_FadeOutWidget> createState() => _FadeOutWidgetState();
}

class _FadeOutWidgetState extends State<_FadeOutWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
      value: 1.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    Future.delayed(widget.delay, () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _animation, child: widget.child);
}

/// 缩放进入动画
class _ScaleInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;
  const _ScaleInWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.begin,
  });
  @override
  State<_ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<_ScaleInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: widget.begin,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ScaleTransition(scale: _animation, child: widget.child);
}

/// 滑入动画
class _SlideInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset beginOffset;
  const _SlideInWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.beginOffset,
  });
  @override
  State<_SlideInWidget> createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<_SlideInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SlideTransition(position: _animation, child: widget.child);
}

/// 旋转进入动画
class _RotateInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double turns;
  const _RotateInWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.turns,
  });
  @override
  State<_RotateInWidget> createState() => _RotateInWidgetState();
}

class _RotateInWidgetState extends State<_RotateInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: widget.turns,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      RotationTransition(turns: _animation, child: widget.child);
}

/// 抖动动画
class _ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double intensity;
  const _ShakeWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.intensity,
  });
  @override
  State<_ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<_ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final sineValue = math.sin(_animation.value * 3.14159 * 4);
        return Transform.translate(
          offset: Offset(
            sineValue * widget.intensity * (1 - _animation.value),
            0,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// 脉冲动画 (循环)
class _PulseWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;
  const _PulseWidget({
    required this.child,
    required this.duration,
    required this.minScale,
    required this.maxScale,
  });
  @override
  State<_PulseWidget> createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<_PulseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ScaleTransition(scale: _animation, child: widget.child);
}

/// 闪烁动画 (循环)
class _BlinkWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minOpacity;
  const _BlinkWidget({
    required this.child,
    required this.duration,
    required this.minOpacity,
  });
  @override
  State<_BlinkWidget> createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<_BlinkWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 1.0,
      end: widget.minOpacity,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _animation, child: widget.child);
}

/// 淡入+滑入组合动画
class _FadeSlideInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset beginOffset;
  const _FadeSlideInWidget({
    required this.child,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.beginOffset,
  });
  @override
  State<_FadeSlideInWidget> createState() => _FadeSlideInWidgetState();
}

class _FadeSlideInWidgetState extends State<_FadeSlideInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      );
}

// ==================== 统一动画 Widget ====================

class _UnifiedAnimWidget extends StatefulWidget {
  final Anim anim;
  final Widget child;
  const _UnifiedAnimWidget({required this.anim, required this.child});
  @override
  State<_UnifiedAnimWidget> createState() => _UnifiedAnimWidgetState();
}

class _UnifiedAnimWidgetState extends State<_UnifiedAnimWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 如果是 onTap 触发，初始值应该是 1.0（让按钮初始可见/正常状态）
    final initialValue = (widget.anim.trigger == AnimTrigger.onTap &&
            (widget.anim.type == AnimType.scale ||
                widget.anim.type == AnimType.bounce ||
                widget.anim.type == AnimType.fadeIn ||
                widget.anim.type == AnimType.slide ||
                widget.anim.type == AnimType.rotate ||
                widget.anim.type == AnimType.pulse ||
                widget.anim.type == AnimType.fadeSlide ||
                widget.anim.type == AnimType.shimmer ||
                widget.anim.type == AnimType.smoke ||
                widget.anim.type == AnimType.fire ||
                widget.anim.type == AnimType.snow ||
                widget.anim.type == AnimType.broken ||
                widget.anim.type == AnimType.glitch))
        ? 1.0
        : 0.0;
    _controller = AnimationController(
      duration: widget.anim.duration,
      vsync: this,
      value: initialValue, // 设置初始值
    );
    if (widget.anim.trigger == AnimTrigger.auto) {
      Future.delayed(widget.anim.delay, () {
        if (mounted) {
          if (widget.anim.repeat) {
            _controller.repeat(reverse: true);
          } else {
            _controller.forward();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() {
    if (widget.anim.repeat) {
      if (_controller.isAnimating) {
        _controller.stop();
        // 如果是 scale 且 scaleBegin 是 1.0，初始值应该是 1.0
        _controller.value = (widget.anim.type == AnimType.scale &&
                widget.anim.scaleBegin == 1.0 &&
                widget.anim.trigger == AnimTrigger.onTap)
            ? 1.0
            : 0;
      } else {
        _controller.repeat(reverse: true);
      }
    } else {
      // 如果是 onTap 触发，从 0 播放到 1.0（在 _buildAnimatedChild 中会映射为正常状态 -> 动画效果 -> 正常状态）
      if (widget.anim.trigger == AnimTrigger.onTap &&
          (widget.anim.type == AnimType.scale ||
              widget.anim.type == AnimType.bounce ||
              widget.anim.type == AnimType.fadeIn ||
              widget.anim.type == AnimType.slide ||
              widget.anim.type == AnimType.rotate ||
              widget.anim.type == AnimType.pulse ||
              widget.anim.type == AnimType.fadeSlide ||
              widget.anim.type == AnimType.shimmer ||
              widget.anim.type == AnimType.smoke ||
              widget.anim.type == AnimType.fire ||
              widget.anim.type == AnimType.snow ||
              widget.anim.type == AnimType.broken ||
              widget.anim.type == AnimType.glitch)) {
        // 对于粒子效果，需要重置到 0 然后播放，让效果从无到有
        if (_controller.value >= 0.99) {
          // 如果当前是结束状态，重置并播放
          _controller.reset();
        }
        _controller.forward().then((_) {
          if (mounted) {
            // 动画结束后，延迟一下再回到初始状态，让用户看到效果
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) {
                _controller.value = 1.0; // 动画结束后保持为 1.0（正常状态）
              }
            });
          }
        });
      } else {
        _controller.forward(from: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = _buildAnimatedChild();

    if (widget.anim.trigger == AnimTrigger.onTap) {
      // 使用 GestureDetector 的 onTapDown 来触发动画
      // 关键：不使用 onTap，只使用 onTapDown，这样不会阻止外层的 onTap 事件
      // 使用 behavior: HitTestBehavior.translucent 确保事件可以穿透
      // 使用 Listener 而不是 GestureDetector，因为 Listener 不会阻止 GestureDetector 的 onTap 事件
      return Listener(
        onPointerDown: (_) {
          _playAnimation();
        },
        behavior: HitTestBehavior.translucent,
        child: animatedChild,
      );
    }
    // 移除 onLongPress 支持，简化实现
    return animatedChild;
  }

  Widget _buildAnimatedChild() {
    final anim = widget.anim;
    final curve = CurvedAnimation(parent: _controller, curve: anim.curve);

    switch (anim.type) {
      case AnimType.fadeIn:
        // 如果是 onTap 触发，初始应该是可见的（opacity=1.0）
        if (anim.trigger == AnimTrigger.onTap) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // 初始状态（value=0）或动画结束（value=1.0）时，opacity=1.0
              // 动画过程中（value 0->1），opacity 从 1.0 到 1.0（不变，或者可以稍微闪烁）
              // 为了有反馈效果，可以让它稍微变暗再恢复
              final opacity = _controller.value <= 0.5
                  ? 1.0 - (_controller.value * 2) * 0.2 // 前半段：1.0 -> 0.8
                  : 0.8 +
                      ((_controller.value - 0.5) * 2) * 0.2; // 后半段：0.8 -> 1.0
              return Opacity(opacity: opacity, child: widget.child);
            },
            child: widget.child,
          );
        }
        return FadeTransition(opacity: curve, child: widget.child);

      case AnimType.fadeOut:
        final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
        return FadeTransition(opacity: fadeOut, child: widget.child);

      case AnimType.scale:
        // 如果 scaleBegin 是 1.0 且是 onTap 触发，则点击时从 1.0 缩放到 0.9 再回到 1.0
        if (anim.scaleBegin == 1.0 && anim.trigger == AnimTrigger.onTap) {
          // 使用 AnimatedBuilder 来处理初始值和动画
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scaleValue;
              // 当 value 为 1.0 或接近 1.0 时（初始状态或动画结束），scale = 1.0
              if (_controller.value >= 0.99) {
                scaleValue = 1.0;
              } else if (_controller.value <= 0.5) {
                // 前半段（0 到 0.5）：从 1.0 缩放到 0.9
                scaleValue = 1.0 - (_controller.value * 2) * 0.1;
              } else {
                // 后半段（0.5 到 1.0）：从 0.9 回到 1.0
                scaleValue = 0.9 + ((_controller.value - 0.5) * 2) * 0.1;
              }
              return Transform.scale(scale: scaleValue, child: widget.child);
            },
            child: widget.child,
          );
        }
        // 默认行为：从 scaleBegin 缩放到 1.0
        final scale = Tween<double>(
          begin: anim.scaleBegin ?? 0.0,
          end: 1.0,
        ).animate(curve);
        return ScaleTransition(scale: scale, child: widget.child);

      case AnimType.bounce:
        // 如果是 onTap 触发，初始应该是正常大小（scale=1.0）
        if (anim.trigger == AnimTrigger.onTap) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scaleValue;
              if (_controller.value >= 0.99) {
                scaleValue = 1.0; // 初始或结束状态
              } else {
                // 弹跳效果：从 1.0 到 0.9 再回到 1.0
                if (_controller.value <= 0.5) {
                  scaleValue =
                      1.0 - (_controller.value * 2) * 0.1; // 1.0 -> 0.9
                } else {
                  scaleValue =
                      0.9 + ((_controller.value - 0.5) * 2) * 0.1; // 0.9 -> 1.0
                }
              }
              return Transform.scale(scale: scaleValue, child: widget.child);
            },
            child: widget.child,
          );
        }
        final bounce = Tween<double>(
          begin: anim.scaleBegin ?? 0.3,
          end: 1.0,
        ).animate(curve);
        return ScaleTransition(scale: bounce, child: widget.child);

      case AnimType.slide:
        // 如果是 onTap 触发，初始应该在正常位置（Offset.zero）
        if (anim.trigger == AnimTrigger.onTap) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final beginOffset = anim.slideOffset ?? const Offset(0, 1);
              Offset offset;
              if (_controller.value >= 0.99) {
                offset = Offset.zero; // 初始或结束状态
              } else {
                // 滑动效果：从正常位置偏移一点再回来
                final progress = _controller.value;
                if (progress <= 0.5) {
                  // 前半段：从 zero 到 beginOffset 的一部分
                  offset = Offset.zero + (beginOffset * progress * 2 * 0.3);
                } else {
                  // 后半段：从偏移回到 zero
                  offset = beginOffset * 0.3 * (1 - (progress - 0.5) * 2);
                }
              }
              return Transform.translate(offset: offset, child: widget.child);
            },
            child: widget.child,
          );
        }
        final slide = Tween<Offset>(
          begin: anim.slideOffset ?? const Offset(0, 1),
          end: Offset.zero,
        ).animate(curve);
        return SlideTransition(position: slide, child: widget.child);

      case AnimType.rotate:
        // 如果是 onTap 触发，初始应该是不旋转（turns=0.0）
        if (anim.trigger == AnimTrigger.onTap) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double turns;
              if (_controller.value >= 0.99) {
                turns = 0.0; // 初始或结束状态
              } else {
                // 旋转效果：从 0 转一圈再回到 0
                final totalTurns = anim.turns ?? 1.0;
                if (_controller.value <= 0.5) {
                  // 前半段：从 0 转到 totalTurns（转一圈）
                  turns = (_controller.value * 2) * totalTurns;
                } else {
                  // 后半段：从 totalTurns 回到 0
                  turns = totalTurns * (1 - (_controller.value - 0.5) * 2);
                }
              }
              return Transform.rotate(
                  angle: turns * 2 * math.pi, child: widget.child);
            },
            child: widget.child,
          );
        }
        final rotate = Tween<double>(
          begin: anim.turns ?? 1,
          end: 0.0,
        ).animate(curve);
        return RotationTransition(turns: rotate, child: widget.child);

      case AnimType.shake:
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final sineValue = math.sin(_controller.value * math.pi * 4);
            return Transform.translate(
              offset: Offset(
                sineValue * (anim.intensity ?? 10) * (1 - _controller.value),
                0,
              ),
              child: child,
            );
          },
          child: widget.child,
        );

      case AnimType.pulse:
        // 如果是 onTap 触发且不重复，初始应该是正常大小（scale=1.0）
        if (anim.trigger == AnimTrigger.onTap && !anim.repeat) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scaleValue;
              if (_controller.value >= 0.99) {
                scaleValue = 1.0; // 初始或结束状态
              } else {
                // 脉冲效果：从 1.0 到 1.05 再回到 1.0
                if (_controller.value <= 0.5) {
                  scaleValue =
                      1.0 + (_controller.value * 2) * 0.05; // 1.0 -> 1.05
                } else {
                  scaleValue = 1.05 -
                      ((_controller.value - 0.5) * 2) * 0.05; // 1.05 -> 1.0
                }
              }
              return Transform.scale(scale: scaleValue, child: widget.child);
            },
            child: widget.child,
          );
        }
        final pulse = Tween<double>(begin: 0.95, end: 1.05).animate(curve);
        return ScaleTransition(scale: pulse, child: widget.child);

      case AnimType.blink:
        final blink = Tween<double>(begin: 1.0, end: 0.3).animate(curve);
        return FadeTransition(opacity: blink, child: widget.child);

      case AnimType.fadeSlide:
        // 如果是 onTap 触发，初始应该是可见且在正常位置
        if (anim.trigger == AnimTrigger.onTap) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final beginOffset = anim.slideOffset ?? const Offset(0, 0.2);
              double opacity;
              Offset offset;
              if (_controller.value >= 0.99) {
                opacity = 1.0;
                offset = Offset.zero;
              } else {
                // 淡入+滑入效果：从可见+正常位置，变暗+偏移，再恢复
                if (_controller.value <= 0.5) {
                  // 前半段：从 1.0 变暗到 0.5，从 zero 偏移到完整 offset
                  opacity = 1.0 - (_controller.value * 2) * 0.5; // 1.0 -> 0.5
                  offset =
                      beginOffset * (_controller.value * 2); // zero -> offset
                } else {
                  // 后半段：从 0.5 恢复到 1.0，从 offset 回到 zero
                  opacity =
                      0.5 + ((_controller.value - 0.5) * 2) * 0.5; // 0.5 -> 1.0
                  offset = beginOffset *
                      (1 - (_controller.value - 0.5) * 2); // offset -> zero
                }
              }
              return Opacity(
                opacity: opacity,
                child: Transform.translate(offset: offset, child: widget.child),
              );
            },
            child: widget.child,
          );
        }
        final fade = CurvedAnimation(parent: _controller, curve: anim.curve);
        final slide = Tween<Offset>(
          begin: anim.slideOffset ?? const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(curve);
        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: slide, child: widget.child),
        );

      case AnimType.shimmer:
        // 流光效果：使用 ShaderMask 配合 LinearGradient 实现
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final direction = anim.slideOffset ?? const Offset(1, 0);
            final highlightOpacity = anim.scaleBegin ?? 0.6;
            final width = anim.intensity ?? 0.3;
            final highlightColor = Colors.white;

            // 计算流光位置（从 -width 到 1+width）
            // 如果是 onTap 触发且 value >= 0.99，则不显示流光（初始状态）
            double progress;
            if (anim.trigger == AnimTrigger.onTap &&
                _controller.value >= 0.99) {
              // 初始状态或动画结束，不显示流光
              progress = -1; // 设置为 -1 表示不显示
            } else {
              progress = _controller.value;
            }

            // 如果 progress < 0，不显示流光效果
            if (progress < 0) {
              return widget.child;
            }

            final start = -width + progress * (1 + width * 2);
            final end = start + width;

            // 创建渐变遮罩
            // 渐变从左到右：透明 -> 高光 -> 透明
            return ShaderMask(
              shaderCallback: (bounds) {
                // 根据方向调整渐变
                if (direction.dx.abs() > direction.dy.abs()) {
                  // 水平方向（左右）
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                      math.max(0, start - 0.1),
                      math.max(0, start),
                      math.min(1, end),
                      math.min(1, end + 0.1),
                    ],
                    colors: [
                      Colors.transparent,
                      highlightColor.withOpacity(highlightOpacity),
                      highlightColor.withOpacity(highlightOpacity),
                      Colors.transparent,
                    ],
                  ).createShader(bounds);
                } else {
                  // 垂直方向（上下）
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      math.max(0, start - 0.1),
                      math.max(0, start),
                      math.min(1, end),
                      math.min(1, end + 0.1),
                    ],
                    colors: [
                      Colors.transparent,
                      highlightColor.withOpacity(highlightOpacity),
                      highlightColor.withOpacity(highlightOpacity),
                      Colors.transparent,
                    ],
                  ).createShader(bounds);
                }
              },
              blendMode: BlendMode.srcATop,
              child: widget.child,
            );
          },
          child: widget.child,
        );

      case AnimType.smoke:
        // 烟雾效果：使用统一粒子系统，从底部边缘向上扩散
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double progress;
            // 对于 onTap 触发：value 从 1.0 -> 0 -> 1.0，progress 应该是 0 -> 1.0 -> 0
            if (anim.trigger == AnimTrigger.onTap) {
              if (_controller.value >= 0.99) {
                progress = 0;
              } else {
                progress = 1.0 - _controller.value;
              }
            } else {
              progress = _controller.value;
            }

            if (progress <= 0) {
              return widget.child;
            }

            final smokeColor = anim.smokeColor ?? const Color(0xFF808080);
            final intensity = anim.intensity ?? 0.7;

            return _ParticleSystemWidget(
              child: widget.child,
              config: ParticleConfig(
                type: AnimType.smoke,
                color: smokeColor,
                density: intensity,
                minRadius: 3.0,
                maxRadius: 12.0,
                minSpeed: 30.0,
                maxSpeed: 80.0,
                direction: 0, // 向上
                lifetime: 1.5,
                spawnFromEdge: true,
              ),
              progress: progress,
              controller: _controller,
            );
          },
          child: widget.child,
        );

      case AnimType.fire:
        final fireColor = anim.fireColor ?? const Color(0xFFFF6B35);
        final intensity = anim.intensity ?? 0.8;
        return _FireFlameWidget(
          child: widget.child,
          controller: _controller,
          color: fireColor,
          intensity: intensity,
          trigger: anim.trigger,
        );

      case AnimType.snow:
        // 雪花效果：使用统一粒子系统，从顶部边缘向下飘落
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double progress;
            // 对于 onTap 触发：value 从 1.0 -> 0 -> 1.0，progress 应该是 0 -> 1.0 -> 0
            if (anim.trigger == AnimTrigger.onTap) {
              if (_controller.value >= 0.99) {
                progress = 0;
              } else {
                progress = 1.0 - _controller.value;
              }
            } else {
              progress = _controller.value;
            }

            if (progress <= 0) {
              return widget.child;
            }

            final snowColor = anim.snowColor ?? const Color(0xFFFFFFFF);
            final intensity = anim.intensity ?? 0.7;

            return _ParticleSystemWidget(
              child: widget.child,
              config: ParticleConfig(
                type: AnimType.snow,
                color: snowColor,
                density: intensity,
                minRadius: 2.0,
                maxRadius: 6.0,
                minSpeed: 20.0,
                maxSpeed: 50.0,
                direction: 1, // 向下
                lifetime: 3.0,
                spawnFromEdge: true,
              ),
              progress: progress,
              controller: _controller,
            );
          },
          child: widget.child,
        );

      case AnimType.broken:
        // 破碎效果：轻量化渲染，避免大内存开销
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double progress;
            if (anim.trigger == AnimTrigger.onTap &&
                _controller.value >= 0.99) {
              progress = 0;
            } else {
              progress = _controller.value;
            }

            if (progress <= 0) {
              return widget.child;
            }

            final pieces = anim.brokenPieces ?? 10;
            final intensity = anim.intensity ?? 0.9;
            final shake = math.sin(progress * math.pi * 6) * intensity * 3;

            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(shake, 0),
                  child: Opacity(
                    opacity: 1.0 - progress * 0.15,
                    child: widget.child,
                  ),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BrokenPainter(
                      progress: progress,
                      pieces: pieces,
                      intensity: intensity,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BrokenShardPainter(
                      progress: progress,
                      pieces: pieces,
                      intensity: intensity,
                    ),
                  ),
                ),
              ],
            );
          },
          child: widget.child,
        );

      case AnimType.glitch:
        // 故障效果：RGB 通道分离、水平位移、随机噪音、模糊
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double progress;
            if (anim.trigger == AnimTrigger.onTap &&
                _controller.value >= 0.99) {
              progress = 0;
            } else {
              progress = anim.trigger == AnimTrigger.onTap
                  ? 1.0 - _controller.value
                  : _controller.value;
            }

            if (progress <= 0) {
              return widget.child;
            }

            final intensity = anim.intensity ?? 0.6;
            final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
            final glitchOffset =
                (math.sin(time * 10) * intensity * 5).roundToDouble();

            return RepaintBoundary(
              child: Stack(
                children: [
                  // RGB 通道分离效果
                  Positioned.fill(
                    child: Transform.translate(
                      offset: Offset(-glitchOffset * progress, 0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.matrix([
                          1, 0, 0, 0, 0, // R
                          0, 0, 0, 0, 0, // G
                          0, 0, 0, 0, 0, // B
                          0, 0, 0, 1, 0, // A
                        ]),
                        child: Opacity(
                          opacity: progress * intensity * 0.5,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Transform.translate(
                      offset: Offset(glitchOffset * progress, 0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.matrix([
                          0, 0, 0, 0, 0, // R
                          0, 1, 0, 0, 0, // G
                          0, 0, 1, 0, 0, // B
                          0, 0, 0, 1, 0, // A
                        ]),
                        child: Opacity(
                          opacity: progress * intensity * 0.5,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                  // 原始内容
                  widget.child,
                  // 噪音层
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GlitchPainter(
                        progress: progress,
                        intensity: intensity,
                        time: time,
                      ),
                    ),
                  ),
                  // 模糊效果
                  if (progress > 0.5)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: progress * intensity * 2,
                          sigmaY: progress * intensity * 2,
                        ),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          child: widget.child,
        );
    }
  }
}

// ==================== 点击触发动画 ====================

extension TapAnimationModifier on Widget {
  /// 点击缩放效果 (类似 iOS 按钮点击)
  Widget tapScale({
    double scale = 0.95,
    Duration duration = const Duration(milliseconds: 100),
  }) =>
      _TapScaleWidget(scale: scale, duration: duration, child: this);

  /// 点击透明度效果
  Widget tapOpacity({
    double opacity = 0.6,
    Duration duration = const Duration(milliseconds: 100),
  }) =>
      _TapOpacityWidget(opacity: opacity, duration: duration, child: this);

  /// 点击弹跳效果
  Widget tapBounce({Duration duration = const Duration(milliseconds: 150)}) =>
      _TapBounceWidget(duration: duration, child: this);

  /// 点击涟漪效果 (带回调)
  Widget tapRipple({VoidCallback? onTap, Color? color}) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: color,
          borderRadius: BorderRadius.circular(8),
          child: this,
        ),
      );
}

/// 点击缩放
class _TapScaleWidget extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;
  const _TapScaleWidget({
    required this.child,
    required this.scale,
    required this.duration,
  });
  @override
  State<_TapScaleWidget> createState() => _TapScaleWidgetState();
}

class _TapScaleWidgetState extends State<_TapScaleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ScaleTransition(scale: _animation, child: widget.child),
      );
}

/// 点击透明度
class _TapOpacityWidget extends StatefulWidget {
  final Widget child;
  final double opacity;
  final Duration duration;
  const _TapOpacityWidget({
    required this.child,
    required this.opacity,
    required this.duration,
  });
  @override
  State<_TapOpacityWidget> createState() => _TapOpacityWidgetState();
}

class _TapOpacityWidgetState extends State<_TapOpacityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 1.0,
      end: widget.opacity,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: FadeTransition(opacity: _animation, child: widget.child),
      );
}

/// 点击弹跳
class _TapBounceWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const _TapBounceWidget({required this.child, required this.duration});
  @override
  State<_TapBounceWidget> createState() => _TapBounceWidgetState();
}

class _TapBounceWidgetState extends State<_TapBounceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onTap,
        child: ScaleTransition(scale: _animation, child: widget.child),
      );
}

// ==================== IconTextButton 组件 ====================

/// IconTextButton 配置类，用于链式调用
class IconTextButtonConfig {
  final Icon icon;
  final Text text;
  final VoidCallback? onPressed;
  final Axis direction;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final double? elevation;
  final BorderSide? border;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const IconTextButtonConfig({
    required this.icon,
    required this.text,
    this.onPressed,
    this.direction = Axis.horizontal,
    this.padding,
    this.spacing = 8.0,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.elevation,
    this.border,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  IconTextButtonConfig copyWith({
    Icon? icon,
    Text? text,
    VoidCallback? onPressed,
    Axis? direction,
    EdgeInsetsGeometry? padding,
    double? spacing,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    double? elevation,
    BorderSide? border,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) =>
      IconTextButtonConfig(
        icon: icon ?? this.icon,
        text: text ?? this.text,
        onPressed: onPressed ?? this.onPressed,
        direction: direction ?? this.direction,
        padding: padding ?? this.padding,
        spacing: spacing ?? this.spacing,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
        borderRadius: borderRadius ?? this.borderRadius,
        elevation: elevation ?? this.elevation,
        border: border ?? this.border,
        mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      );
}

/// IconTextButton Widget - 支持水平和垂直布局的图标+文字按钮
class IconTextButton extends StatelessWidget {
  final IconTextButtonConfig config;

  const IconTextButton({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final content = config.direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: config.mainAxisAlignment,
            crossAxisAlignment: config.crossAxisAlignment,
            children: [
              config.icon,
              SizedBox(width: config.spacing),
              config.text,
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: config.mainAxisAlignment,
            crossAxisAlignment: config.crossAxisAlignment,
            children: [
              config.icon,
              SizedBox(height: config.spacing),
              config.text,
            ],
          );

    Widget button = config.padding != null
        ? Padding(padding: config.padding!, child: content)
        : content;

    if (config.backgroundColor != null ||
        config.borderRadius != null ||
        config.border != null ||
        config.elevation != null) {
      button = Container(
        decoration: BoxDecoration(
          color: config.backgroundColor,
          borderRadius: config.borderRadius != null
              ? BorderRadius.circular(config.borderRadius!)
              : null,
          border: config.border != null
              ? Border.fromBorderSide(config.border!)
              : null,
        ),
        child: button,
      );
    }

    if (config.elevation != null && config.elevation! > 0) {
      button = Material(
        elevation: config.elevation!,
        color: Colors.transparent,
        borderRadius: config.borderRadius != null
            ? BorderRadius.circular(config.borderRadius!)
            : null,
        child: button,
      );
    }

    if (config.onPressed != null) {
      // 使用 Material + InkWell 以支持涟漪效果，同时允许外层 GestureDetector 捕获事件
      return Material(
        color: Colors.transparent,
        borderRadius: config.borderRadius != null
            ? BorderRadius.circular(config.borderRadius!)
            : null,
        child: InkWell(
          onTap: config.onPressed,
          borderRadius: config.borderRadius != null
              ? BorderRadius.circular(config.borderRadius!)
              : null,
          child: button,
        ),
      );
    }

    return button;
  }
}

// ==================== IconTextButton 扩展方法 ====================

extension IconTextButtonExtension on IconTextButtonConfig {
  /// 设置背景色
  IconTextButtonConfig bg(Color color) => copyWith(backgroundColor: color);

  /// 设置前景色（文字和图标颜色）
  IconTextButtonConfig fg(Color color) => copyWith(
        foregroundColor: color,
        icon: Icon(
          icon.icon,
          size: icon.size,
          color: color,
          semanticLabel: icon.semanticLabel,
          textDirection: icon.textDirection,
        ),
        text: Text(
          text.data ?? '',
          style: (text.style ?? const TextStyle()).copyWith(color: color),
          textAlign: text.textAlign,
          maxLines: text.maxLines,
          overflow: text.overflow,
        ),
      );

  /// 设置内边距
  IconTextButtonConfig pad(EdgeInsetsGeometry padding) =>
      copyWith(padding: padding);

  /// 设置内边距（全部）
  IconTextButtonConfig padAll(double value) =>
      copyWith(padding: EdgeInsets.all(value));

  /// 设置间距
  IconTextButtonConfig gap(double spacing) => copyWith(spacing: spacing);

  /// 设置圆角
  IconTextButtonConfig radius(double radius) => copyWith(borderRadius: radius);

  /// 设置边框
  IconTextButtonConfig borderSide({
    Color color = Colors.black,
    double width = 1.0,
  }) =>
      copyWith(border: BorderSide(color: color, width: width));

  /// 设置阴影
  IconTextButtonConfig shadow(double elevation) =>
      copyWith(elevation: elevation);

  /// 设置方向
  IconTextButtonConfig dir(Axis direction) => copyWith(direction: direction);

  /// 水平布局
  IconTextButtonConfig horizontal() => copyWith(direction: Axis.horizontal);

  /// 垂直布局
  IconTextButtonConfig vertical() => copyWith(direction: Axis.vertical);

  /// 设置对齐方式
  IconTextButtonConfig align({
    MainAxisAlignment? main,
    CrossAxisAlignment? cross,
  }) =>
      copyWith(
        mainAxisAlignment: main ?? mainAxisAlignment,
        crossAxisAlignment: cross ?? crossAxisAlignment,
      );

  /// 构建 Widget
  Widget build() => IconTextButton(config: this);
}

// ==================== 快速创建 IconTextButton 的扩展 ====================

extension IconTextButtonCreator on Object {
  /// 创建水平布局的 IconTextButton
  IconTextButtonConfig iconTextButton({
    required Icon icon,
    required Text text,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? padding,
    double spacing = 8.0,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    double? elevation,
    BorderSide? border,
  }) =>
      IconTextButtonConfig(
        icon: icon,
        text: text,
        onPressed: onPressed,
        direction: Axis.horizontal,
        padding: padding,
        spacing: spacing,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderRadius: borderRadius,
        elevation: elevation,
        border: border,
      );

  /// 创建垂直布局的 IconTextButton
  IconTextButtonConfig iconTextButtonVertical({
    required Icon icon,
    required Text text,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? padding,
    double spacing = 8.0,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    double? elevation,
    BorderSide? border,
  }) =>
      IconTextButtonConfig(
        icon: icon,
        text: text,
        onPressed: onPressed,
        direction: Axis.vertical,
        padding: padding,
        spacing: spacing,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderRadius: borderRadius,
        elevation: elevation,
        border: border,
      );
}

// ==================== 高级动画效果 Painter ====================
class _BrokenPainter extends CustomPainter {
  final double progress;
  final int pieces;
  final double intensity;
  final List<Path> crackPaths;

  _BrokenPainter({
    required this.progress,
    required this.pieces,
    required this.intensity,
  }) : crackPaths = _generateCrackPaths(pieces);

  static List<Path> _generateCrackPaths(int pieces) {
    final paths = <Path>[];
    final random = math.Random(42); // 固定种子以保证一致性

    for (int i = 0; i < pieces; i++) {
      final angle = (i / pieces) * math.pi * 2;
      final path = Path();
      path.moveTo(0.5, 0.5); // 中心点
      final distance = 0.3 + random.nextDouble() * 0.4;
      final endX = 0.5 + math.cos(angle) * distance;
      final endY = 0.5 + math.sin(angle) * distance;
      path.lineTo(endX, endY);
      paths.add(path);
    }

    return paths;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final matrix = Matrix4.identity()..scale(size.width, size.height);

    for (final path in crackPaths) {
      final transformedPath = path.transform(matrix.storage);
      canvas.drawPath(transformedPath, paint);
    }
  }

  @override
  bool shouldRepaint(_BrokenPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// 玻璃碎片效果绘制器
class _BrokenShardPainter extends CustomPainter {
  final double progress;
  final int pieces;
  final double intensity;

  _BrokenShardPainter({
    required this.progress,
    required this.pieces,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.2) return;
    final random = math.Random(24);
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) * 0.55;
    final shardCount = pieces.clamp(8, 20);
    final spread = (progress * intensity).clamp(0.0, 1.0);

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.25 * spread)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < shardCount; i++) {
      final angle = (i / shardCount) * math.pi * 2 + random.nextDouble() * 0.3;
      final radius = maxRadius * (0.35 + random.nextDouble() * 0.65) * spread;
      final shardSize = (6 + random.nextDouble() * 10) * (0.6 + spread);
      final direction = Offset(math.cos(angle), math.sin(angle));
      final extra = (12 + random.nextDouble() * 18) * spread;
      final shardCenter = center + direction * radius + direction * extra;
      final wobble = math.sin(progress * math.pi * 6 + i) * 0.12;
      final rotate = (random.nextBool() ? 1 : -1) *
              (0.6 + random.nextDouble() * 0.6) *
              spread +
          wobble;
      final path = Path()
        ..moveTo(0, -shardSize)
        ..lineTo(-shardSize * 0.6, shardSize * 0.6)
        ..lineTo(shardSize * 0.6, shardSize * 0.6)
        ..close();
      canvas.save();
      canvas.translate(shardCenter.dx, shardCenter.dy);
      canvas.rotate(rotate);
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BrokenShardPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.pieces != pieces ||
        oldDelegate.intensity != intensity;
  }
}

/// 故障效果绘制器
class _GlitchPainter extends CustomPainter {
  final double progress;
  final double intensity;
  final double time;
  final math.Random random;

  _GlitchPainter({
    required this.progress,
    required this.intensity,
    required this.time,
  }) : random = math.Random((time * 1000).round());

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3 * intensity * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 绘制随机噪音线条
    final lineCount = (5 * intensity).round();
    for (int i = 0; i < lineCount; i++) {
      final y = size.height * random.nextDouble();
      final startX = size.width * random.nextDouble() * 0.3;
      final endX = size.width * (0.7 + random.nextDouble() * 0.3);
      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_GlitchPainter oldDelegate) {
    return (oldDelegate.time - time).abs() > 0.05 ||
        oldDelegate.progress != progress;
  }
}

// ==================== 统一粒子系统 ====================

/// 粒子配置
class ParticleConfig {
  /// 粒子类型（smoke/fire/snow）
  final AnimType type;

  /// 粒子颜色
  final Color color;

  /// 粒子数量（0.0-1.0，会根据容器大小自动计算）
  final double density;

  /// 粒子大小范围（最小-最大半径）
  final double minRadius;
  final double maxRadius;

  /// 粒子速度范围
  final double minSpeed;
  final double maxSpeed;

  /// 粒子生成位置（0.0=底部/左侧，1.0=顶部/右侧）
  final double spawnPosition;

  /// 粒子运动方向（0=向上，1=向下，2=向左，3=向右）
  final int direction;

  /// 粒子生命周期（秒）
  final double lifetime;

  /// 是否从边缘生成（true=边缘，false=随机位置）
  final bool spawnFromEdge;

  /// 最大粒子数量（防止超大尺寸导致内存暴涨）
  final int? maxParticles;

  /// 粒子计算的最大面积（逻辑像素平方）
  final double? maxArea;

  const ParticleConfig({
    required this.type,
    required this.color,
    this.density = 0.7,
    this.minRadius = 2.0,
    this.maxRadius = 8.0,
    this.minSpeed = 20.0,
    this.maxSpeed = 60.0,
    this.spawnPosition = 0.0,
    this.direction = 0,
    this.lifetime = 2.0,
    this.spawnFromEdge = true,
    this.maxParticles = 120,
    this.maxArea = 200000,
  });
}

/// 单个粒子
class Particle {
  /// 当前位置
  Offset position;

  /// 速度（像素/秒）
  Offset velocity;

  /// 半径
  double radius;

  /// 颜色
  Color color;

  /// 生命周期（0.0-1.0）
  double life;

  /// 最大生命周期（秒）
  double maxLife;

  /// 透明度
  double opacity;

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
    required this.maxLife,
  })  : life = 1.0,
        opacity = 1.0;

  /// 更新粒子状态
  void update(double dt) {
    position += velocity * dt;
    life -= dt / maxLife;
    if (life < 0) life = 0;
    // 透明度随生命周期衰减
    opacity = life;
  }

  /// 是否已死亡
  bool get isDead => life <= 0;
}

/// 粒子系统绘制器
class _ParticleSystemPainter extends CustomPainter {
  final List<Particle> particles;
  final ParticleConfig config;
  final double progress;

  _ParticleSystemPainter({
    required this.particles,
    required this.config,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    if (config.type == AnimType.fire) {
      final glowHeight = size.height * 0.35;
      final glowRect = Rect.fromLTWH(
        0,
        size.height - glowHeight,
        size.width,
        glowHeight,
      );
      final glowPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.orangeAccent.withOpacity(0.35 * progress),
            Colors.redAccent.withOpacity(0.15 * progress),
            Colors.transparent,
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(glowRect);
      canvas.drawRect(glowRect, glowPaint);
    }

    if (particles.isEmpty) {
      return;
    }

    for (final particle in particles) {
      if (particle.isDead) continue;

      final paint = Paint()
        ..color = particle.color.withOpacity(
          particle.opacity * progress * 0.8,
        )
        ..style = PaintingStyle.fill;

      // 根据类型绘制不同形状
      switch (config.type) {
        case AnimType.smoke:
          // 烟雾：绘制模糊圆形
          canvas.drawCircle(
            particle.position,
            particle.radius,
            paint..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0),
          );
          break;
        case AnimType.fire:
          // 火焰：使用双层椭圆提高可见度
          final flameOpacity =
              (particle.opacity * progress * 1.4).clamp(0.0, 1.0);
          final outerPaint = Paint()
            ..color = particle.color.withOpacity(flameOpacity)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
          final outerRect = Rect.fromCenter(
            center: particle.position,
            width: particle.radius * 1.4,
            height: particle.radius * 2.2,
          );
          canvas.drawOval(outerRect, outerPaint);
          final innerPaint = Paint()
            ..color = Colors.yellowAccent.withOpacity(flameOpacity * 0.8);
          final innerRect = Rect.fromCenter(
            center: particle.position.translate(0, -particle.radius * 0.3),
            width: particle.radius * 0.7,
            height: particle.radius * 1.2,
          );
          canvas.drawOval(innerRect, innerPaint);
          break;
        case AnimType.snow:
          // 雪花：绘制六角星或圆形
          _drawSnowflake(canvas, particle.position, particle.radius, paint);
          break;
        default:
          canvas.drawCircle(particle.position, particle.radius, paint);
      }
    }
  }

  /// 绘制雪花（简单的六角星）
  void _drawSnowflake(
      Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const angle = math.pi / 3; // 60度
    for (int i = 0; i < 6; i++) {
      final x = center.dx + radius * math.cos(i * angle);
      final y = center.dy + radius * math.sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
    // 中心点
    canvas.drawCircle(center, radius * 0.3, paint);
  }

  @override
  bool shouldRepaint(_ParticleSystemPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.particles.length != particles.length;
  }
}

/// 粒子系统 Widget
class _ParticleSystemWidget extends StatefulWidget {
  final Widget child;
  final ParticleConfig config;
  final double progress;
  final AnimationController controller;

  const _ParticleSystemWidget({
    required this.child,
    required this.config,
    required this.progress,
    required this.controller,
  });

  @override
  State<_ParticleSystemWidget> createState() => _ParticleSystemWidgetState();
}

class _ParticleSystemWidgetState extends State<_ParticleSystemWidget>
    with SingleTickerProviderStateMixin {
  late List<Particle> _particles;
  late final _ticker = createTicker(_onTick);
  double _lastTime = 0;
  Size? _currentSize;
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _ticker.start();
    _initializeParticles();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentSize();
    });
  }

  @override
  void didUpdateWidget(_ParticleSystemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当 progress 从 0 变为 > 0 时，立即生成粒子
    if (oldWidget.progress == 0 &&
        widget.progress > 0 &&
        _currentSize != null) {
      final size = _currentSize!;
      if (size.width.isFinite &&
          size.height.isFinite &&
          size.width > 0 &&
          size.height > 0) {
        final targetCount = _calculateTargetCount(size);
        // 立即生成初始粒子
        _particles.clear();
        for (int i = 0; i < targetCount.clamp(0, 50); i++) {
          _particles.add(_createParticle(size));
        }
        setState(() {});
      }
    }
    // 配置变化时重新初始化
    if (oldWidget.config != widget.config && widget.progress > 0) {
      _initializeParticles();
    }
    // 当 progress 从 > 0 变为 0 时，清理粒子
    if (oldWidget.progress > 0 && widget.progress == 0) {
      _particles.clear();
      setState(() {});
    }
    if (oldWidget.child != widget.child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateCurrentSize();
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    _particles = [];
    _lastTime = 0;
  }

  void _updateCurrentSize() {
    final size = _childKey.currentContext?.size ?? context.size;
    if (size == null) return;
    if (!_isValidSize(size)) return;
    final safeSize = _getSafeSize(size);
    final isChanged = _currentSize != safeSize;
    _currentSize = safeSize;
    if (isChanged && widget.progress > 0 && _particles.isEmpty) {
      _spawnInitialParticles(safeSize);
      if (mounted) setState(() {});
    }
  }

  bool _isValidSize(Size size) {
    if (!size.width.isFinite || !size.height.isFinite) return false;
    if (size.width <= 0 || size.height <= 0) return false;
    return true;
  }

  Size _getSafeSize(Size size) {
    final maxArea = widget.config.maxArea ?? 200000;
    final area = size.width * size.height;
    if (area <= maxArea) return size;
    final scale = math.sqrt(maxArea / area);
    return Size(size.width * scale, size.height * scale);
  }

  int _calculateTargetCount(Size size) {
    final maxArea = widget.config.maxArea ?? 200000;
    final maxParticles = widget.config.maxParticles ?? 120;
    final area = math.min(size.width * size.height, maxArea);
    final count = (area * widget.config.density / 10000).round();
    return count.clamp(6, maxParticles);
  }

  void _spawnInitialParticles(Size size) {
    final targetCount = _calculateTargetCount(size);
    for (int i = 0; i < targetCount.clamp(0, 30); i++) {
      _particles.add(_createParticle(size));
    }
  }

  void _onTick(Duration elapsed) {
    // 粒子系统更新逻辑
    if (!mounted) return;

    final currentTime = elapsed.inMilliseconds / 1000.0;
    final dt = currentTime - _lastTime;
    _lastTime = currentTime;

    // 如果 progress <= 0 或 size 未设置，清理粒子但不更新
    if (widget.progress <= 0 || _currentSize == null) {
      if (_currentSize == null) _updateCurrentSize();
      if (_particles.isNotEmpty) {
        _particles.clear();
        setState(() {});
      }
      return;
    }

    final size = _currentSize!;
    final safeSize = _getSafeSize(size);

    // 检查 size 是否有效（不是 Infinity 或 NaN）
    if (!size.width.isFinite ||
        !size.height.isFinite ||
        size.width <= 0 ||
        size.height <= 0) {
      return;
    }

    if (dt <= 0) return;

    final targetCount = _calculateTargetCount(safeSize);

    // 更新现有粒子
    _particles.removeWhere((p) {
      p.update(dt);
      if (widget.config.type == AnimType.fire) {
        final flutter = math.sin((currentTime + p.position.dy) * 10) * 6;
        p.position = p.position.translate(flutter * dt, 0);
      }
      return p.isDead || _isOutOfBounds(p.position, size);
    });

    // 生成新粒子直到达到目标数量
    while (_particles.length < targetCount) {
      _particles.add(_createParticle(safeSize));
    }

    // 触发重建以显示粒子
    if (mounted) {
      setState(() {});
    }
  }

  Particle _createParticle(Size size) {
    final random = math.Random();
    Offset spawnPos;
    Offset velocity;

    // 根据配置生成位置和速度
    if (widget.config.spawnFromEdge) {
      // 从边缘生成
      switch (widget.config.direction) {
        case 0: // 向上
          spawnPos = Offset(
            size.width * (0.15 + random.nextDouble() * 0.7),
            size.height * (0.6 + random.nextDouble() * 0.35),
          );
          velocity = Offset(
            (random.nextDouble() - 0.5) * 20,
            -widget.config.minSpeed -
                random.nextDouble() *
                    (widget.config.maxSpeed - widget.config.minSpeed),
          );
          break;
        case 1: // 向下
          spawnPos = Offset(
            size.width * (0.2 + random.nextDouble() * 0.6),
            size.height * (0.0 + random.nextDouble() * 0.2),
          );
          velocity = Offset(
            (random.nextDouble() - 0.5) * 20,
            widget.config.minSpeed +
                random.nextDouble() *
                    (widget.config.maxSpeed - widget.config.minSpeed),
          );
          break;
        case 2: // 向左
          spawnPos = Offset(
            size.width * (0.8 + random.nextDouble() * 0.2),
            size.height * (0.2 + random.nextDouble() * 0.6),
          );
          velocity = Offset(
            -widget.config.minSpeed -
                random.nextDouble() *
                    (widget.config.maxSpeed - widget.config.minSpeed),
            (random.nextDouble() - 0.5) * 20,
          );
          break;
        case 3: // 向右
          spawnPos = Offset(
            size.width * (0.0 + random.nextDouble() * 0.2),
            size.height * (0.2 + random.nextDouble() * 0.6),
          );
          velocity = Offset(
            widget.config.minSpeed +
                random.nextDouble() *
                    (widget.config.maxSpeed - widget.config.minSpeed),
            (random.nextDouble() - 0.5) * 20,
          );
          break;
        default:
          spawnPos = Offset(size.width / 2, size.height / 2);
          velocity = Offset.zero;
      }
    } else {
      // 随机位置生成
      spawnPos = Offset(
        size.width * random.nextDouble(),
        size.height * random.nextDouble(),
      );
      velocity = Offset(
        (random.nextDouble() - 0.5) * widget.config.maxSpeed,
        (random.nextDouble() - 0.5) * widget.config.maxSpeed,
      );
    }

    return Particle(
      position: spawnPos,
      velocity: velocity,
      radius: widget.config.minRadius +
          random.nextDouble() *
              (widget.config.maxRadius - widget.config.minRadius),
      color: widget.config.color,
      maxLife: widget.config.lifetime,
    );
  }

  bool _isOutOfBounds(Offset pos, Size size) {
    return pos.dx < -50 ||
        pos.dx > size.width + 50 ||
        pos.dy < -50 ||
        pos.dy > size.height + 50;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentSize();
    });
    final size = _currentSize;
    if (size == null || !_isValidSize(size)) {
      return KeyedSubtree(key: _childKey, child: widget.child);
    }
    if (widget.progress > 0 &&
        _particles.isEmpty &&
        widget.config.type == AnimType.fire) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final safeSize = _currentSize;
        if (safeSize == null || !_isValidSize(safeSize)) return;
        _spawnInitialParticles(safeSize);
        setState(() {});
      });
    }
    return Stack(
      children: [
        KeyedSubtree(key: _childKey, child: widget.child),
        if (widget.progress > 0 &&
            (_particles.isNotEmpty || widget.config.type == AnimType.fire))
          ClipRect(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: CustomPaint(
                painter: _ParticleSystemPainter(
                  particles: _particles,
                  config: widget.config,
                  progress: widget.progress,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ==================== 火焰绘制 ====================

class _FireFlameWidget extends StatelessWidget {
  final Widget child;
  final AnimationController controller;
  final Color color;
  final double intensity;
  final AnimTrigger trigger;

  const _FireFlameWidget({
    required this.child,
    required this.controller,
    required this.color,
    required this.intensity,
    required this.trigger,
  });

  double _calculateProgress(double value) {
    if (trigger == AnimTrigger.onTap) {
      if (value >= 0.99) return 0;
      return math.sin(value * math.pi);
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final progress = _calculateProgress(controller.value);
        if (progress <= 0) return child;
        return CustomPaint(
          foregroundPainter: _FireFlamePainter(
            progress: progress,
            color: color,
            intensity: intensity,
            time: controller.value,
          ),
          child: child,
        );
      },
    );
  }
}

class _FireFlamePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double intensity;
  final double time;

  const _FireFlamePainter({
    required this.progress,
    required this.color,
    required this.intensity,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final baseHeight = size.height * (0.2 + intensity * 0.15);
    final maxHeight = size.height * (0.45 + intensity * 0.25);
    final flameCount = (10 + intensity * 10).round().clamp(10, 20);
    final step = size.width / (flameCount - 1);
    final phase = time * math.pi * 2;

    final outerPath = Path()..moveTo(0, size.height);
    for (int i = 0; i < flameCount; i++) {
      final x = step * i;
      final wave = math.sin(phase * 1.6 + i * 0.9);
      final jitter = math.sin(phase * 2.3 + i * 1.7);
      final height = baseHeight +
          (maxHeight - baseHeight) * (0.6 + 0.4 * wave) +
          jitter * (maxHeight * 0.08);
      final y = size.height - height * progress;
      outerPath.lineTo(x, y);
    }
    outerPath
      ..lineTo(size.width, size.height)
      ..close();

    final outerPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          color.withOpacity(0.85 * progress),
          Colors.deepOrangeAccent.withOpacity(0.55 * progress),
          Colors.transparent,
        ],
        stops: const [0.0, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawPath(outerPath, outerPaint);

    final innerPath = Path()..moveTo(0, size.height);
    for (int i = 0; i < flameCount; i++) {
      final x = step * i;
      final wave = math.sin(phase * 2.1 + i * 1.1);
      final height = baseHeight * 0.6 +
          (maxHeight * 0.75 - baseHeight * 0.6) * (0.6 + 0.4 * wave);
      final y = size.height - height * progress;
      innerPath.lineTo(x, y);
    }
    innerPath
      ..lineTo(size.width, size.height)
      ..close();

    final innerPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.yellowAccent.withOpacity(0.8 * progress),
          Colors.orangeAccent.withOpacity(0.5 * progress),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(_FireFlamePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.time != time ||
        oldDelegate.intensity != intensity ||
        oldDelegate.color != color;
  }
}

//玻璃容器效果
class LiqContainer {}
