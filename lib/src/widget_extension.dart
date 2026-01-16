import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

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
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

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
        maxLines: count,
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
        maxLines: maxLines ?? 1,
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
  Container backgroundColor(Color color) => Container(
        key: key,
        alignment: alignment,
        padding: padding,
        color: decoration == null ? color : null,
        decoration: decoration != null
            ? (decoration as BoxDecoration).copyWith(color: color)
            : null,
        margin: margin,
        width: constraints?.maxWidth,
        height: constraints?.maxHeight,
        child: child,
      );
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
    _controller = AnimationController(
      duration: widget.anim.duration,
      vsync: this,
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
        _controller.value = 0;
      } else {
        _controller.repeat(reverse: true);
      }
    } else {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = _buildAnimatedChild();

    if (widget.anim.trigger == AnimTrigger.onTap) {
      return GestureDetector(onTap: _playAnimation, child: animatedChild);
    } else if (widget.anim.trigger == AnimTrigger.onLongPress) {
      return GestureDetector(onLongPress: _playAnimation, child: animatedChild);
    }
    return animatedChild;
  }

  Widget _buildAnimatedChild() {
    final anim = widget.anim;
    final curve = CurvedAnimation(parent: _controller, curve: anim.curve);

    switch (anim.type) {
      case AnimType.fadeIn:
        return FadeTransition(opacity: curve, child: widget.child);

      case AnimType.fadeOut:
        final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
        return FadeTransition(opacity: fadeOut, child: widget.child);

      case AnimType.scale:
        final scale = Tween<double>(
          begin: anim.scaleBegin ?? 0.0,
          end: 1.0,
        ).animate(curve);
        return ScaleTransition(scale: scale, child: widget.child);

      case AnimType.bounce:
        final bounce = Tween<double>(
          begin: anim.scaleBegin ?? 0.3,
          end: 1.0,
        ).animate(curve);
        return ScaleTransition(scale: bounce, child: widget.child);

      case AnimType.slide:
        final slide = Tween<Offset>(
          begin: anim.slideOffset ?? const Offset(0, 1),
          end: Offset.zero,
        ).animate(curve);
        return SlideTransition(position: slide, child: widget.child);

      case AnimType.rotate:
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
        final pulse = Tween<double>(begin: 0.95, end: 1.05).animate(curve);
        return ScaleTransition(scale: pulse, child: widget.child);

      case AnimType.blink:
        final blink = Tween<double>(begin: 1.0, end: 0.3).animate(curve);
        return FadeTransition(opacity: blink, child: widget.child);

      case AnimType.fadeSlide:
        final fade = CurvedAnimation(parent: _controller, curve: anim.curve);
        final slide = Tween<Offset>(
          begin: anim.slideOffset ?? const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(curve);
        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: slide, child: widget.child),
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
