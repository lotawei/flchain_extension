import 'package:flchain_extension/flchain_extension.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLChain Extension Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ChainableExample(),
    );
  }
}

class ChainableExample extends StatelessWidget {
  const ChainableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('链式调用示例')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('动画效果 - 自动播放'),
          _buildAnimationDemo(),
          _buildSectionTitle('动画效果 - 点击触发（已修复初始状态）'),
          _buildOnTapAnimationDemo(),
          _buildSectionTitle('基础文本样式'),
          _buildTextDemo(),
          _buildSectionTitle('容器装饰'),
          _buildContainerDemo(),
          _buildSectionTitle('组合布局'),
          _buildLayoutDemo(),
          _buildSectionTitle('按钮样式'),
          _buildButtonDemo(),
          _buildSectionTitle('卡片组件'),
          _buildCardDemo(),
        ],
      ).scrollable().safeArea(),
    );
  }

  Widget _buildSectionTitle(String title) => Text(title)
      .fontSize(14)
      .textColor(Colors.grey)
      .paddingOnly(left: 16, top: 16, bottom: 8);

  Widget _buildTextDemo() => [
        // String 扩展快速创建
        '你好木木哒'.text.fontSize(24).bold().textColor(Colors.blue),
        16.vGap,
        // Text 链式样式
        const Text('下划线+斜体').underline().italic().textColor(Colors.orange),
        8.vGap,
        const Text('带阴影文字').fontSize(20).bold().shadow(),
        8.vGap,
        const Text('这是一段很长的文字需要省略显示的效果测试 这是一段很长的文字需要省略显示的效果测试').ellipsis(),
        8.vGap,
        // 在可滚动容器中使用 flexibleSafe + shrinkWrap
        const Text('这是一段很长的文字需要省略显示的效果测试 这是一段很长的文字需要省略显示的效果测试').flexibleSafe(),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            shrinkWrap: true, // 关键：在可滚动容器中需要 shrinkWrap
          )
          .paddingAll(16);

  Widget _buildContainerDemo() => [
        // 背景+圆角
        const Text(
          '背景+圆角',
        ).paddingAll(12).background(Colors.blue.shade100).cornerRadius(8),
        12.vGap,
        // 渐变背景
        const Text('渐变背景')
            .textColor(Colors.white)
            .paddingAll(12)
            .linearGradient(
                colors: [Colors.blue, Colors.purple]).cornerRadius(8),
        12.vGap,
        // 阴影+边框
        const Text('阴影+边框')
            .paddingAll(12)
            .border(color: Colors.blue, width: 2, radius: 8)
            .shadow(blurRadius: 8),
        12.vGap,
        // 模糊效果
        const Text('模糊效果').paddingAll(12).blur(sigmaX: 1, sigmaY: 1),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16);

  Widget _buildLayoutDemo() => Row(
        children: [
          // 圆形图标
          const Icon(Icons.star, color: Colors.amber, size: 30)
              .background(Colors.red)
              .paddingAll(12)
              .background(Colors.amber.shade50)
              .circle(),
          12.hGap,
          // 文字扩展填充
          const Text('Rating: 4.5').fontSize(16).expanded(),
          // 右侧图标
          const Icon(Icons.arrow_forward_ios, size: 16).opacity(0.5),
        ],
      )
          .paddingAll(16)
          .background(Colors.grey.shade100)
          .cornerRadius(12)
          .margin(const EdgeInsets.symmetric(horizontal: 16));

  Widget _buildButtonDemo() => [
        // 主按钮
        const Text('主按钮')
            .fontSize(16)
            .textColor(Colors.white)
            .bold()
            .center()
            .height(48)
            .fullWidth()
            .background(Colors.blue)
            .cornerRadius(24)
            .onTap(() => debugPrint('主按钮点击')),
        12.vGap,
        // 次按钮
        const Text('次按钮')
            .fontSize(16)
            .textColor(Colors.blue)
            .center()
            .height(48)
            .fullWidth()
            .border(color: Colors.blue, width: 1.5, radius: 24)
            .onTap(() => debugPrint('次按钮点击')),
        12.vGap,
        // IconTextButton - 水平布局
        // IconTextButton - 带点击动画（默认显示，点击时缩放）
        IconTextButtonConfig(
          icon: const Icon(Icons.favorite, color: Colors.white),
          text: const Text('喜欢').textColor(Colors.white).bold(),
          onPressed: () => debugPrint('喜欢按钮点击'),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ).bg(Colors.red).radius(24).build().animate(Anim.scale(
              begin: 1.0, // 初始可见（scale = 1.0）
              trigger: AnimTrigger.onTap, // 点击时缩放
              duration: const Duration(milliseconds: 200),
            )),
        12.vGap,
        // IconTextButton - 垂直布局
        IconTextButtonConfig(
          icon: const Icon(Icons.share, color: Colors.blue, size: 24),
          text: const Text('分享').fontSize(12).textColor(Colors.blue),
          onPressed: () => debugPrint('分享按钮点击'),
          padding: const EdgeInsets.all(16),
        )
            .vertical()
            .borderSide(color: Colors.blue, width: 1.5)
            .radius(12)
            .build(),
        12.vGap,
        // IconTextButton - 链式调用示例
        IconTextButtonConfig(
          icon: const Icon(Icons.download, size: 20),
          text: const Text('下载'),
          onPressed: () => debugPrint('下载按钮点击'),
        )
            .fg(Colors.green)
            .padAll(16)
            .gap(8)
            .bg(Colors.green.shade50)
            .radius(8)
            .borderSide(color: Colors.green, width: 1)
            .build(),
        12.vGap,
        // 禁用按钮
        const Text('禁用按钮')
            .fontSize(16)
            .textColor(Colors.grey)
            .center()
            .height(48)
            .fullWidth()
            .background(Colors.grey.shade200)
            .cornerRadius(24)
            .ignorePointer(),
      ].toColumn().paddingSymmetric(horizontal: 16);

  Widget _buildCardDemo() => [
        const Text('卡片标题').fontSize(18).bold(),
        8.vGap,
        const Text(
          '这是卡片内容描述，支持多行显示。',
        ).fontSize(14).textColor(Colors.grey.shade600).lines(2),
        16.vGap,
        Row(
          children: [
            const Text('查看详情').textColor(Colors.blue).expanded(),
            const Icon(Icons.arrow_forward, color: Colors.blue, size: 18),
          ],
        ),
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .paddingAll(16)
          .decorated(
        color: Colors.white,
        borderRadius: 12.circular,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ).margin(const EdgeInsets.symmetric(horizontal: 16));

  Widget _buildAnimationDemo() => [
        // 淡入效果 - 自动播放
        const Text('淡入(自动)')
            .paddingAll(12)
            .background(Colors.green.shade100)
            .cornerRadius(8)
            .animate(Anim.fadeIn(duration: const Duration(milliseconds: 500))),
        12.vGap,
        // 从左滑入 - 自动播放
        const Text('滑入(自动)')
            .paddingAll(12)
            .background(Colors.orange.shade100)
            .cornerRadius(8)
            .animate(Anim.slideLeft(delay: const Duration(milliseconds: 200))),
        12.vGap,
        // 弹跳 - 点击触发
        const Text('点击弹跳')
            .paddingAll(12)
            .background(Colors.purple.shade100)
            .cornerRadius(8)
            .animate(Anim.bounce(trigger: AnimTrigger.onTap)),
        12.vGap,
        // 缩放 - 点击触发
        const Text('点击缩放')
            .paddingAll(12)
            .background(Colors.blue.shade100)
            .cornerRadius(8)
            .animate(Anim.scale(trigger: AnimTrigger.onTap)),
        12.vGap,
        // 抖动 - 点击触发
        const Text('点击抖动')
            .paddingAll(12)
            .background(Colors.red.shade100)
            .cornerRadius(8)
            .animate(Anim.shake(trigger: AnimTrigger.onTap)),
        12.vGap,
        // 旋转 - 点击触发
        Row(
          children: [
            const Icon(
              Icons.refresh,
              color: Colors.teal,
              size: 40,
            ).animate(Anim.rotate(trigger: AnimTrigger.onTap)),
            12.hGap,
            const Text('点击旋转').textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // 脉冲循环 - 点击切换
        Row(
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 40,
            ).animate(Anim.pulse(repeat: true, trigger: AnimTrigger.onTap)),
            12.hGap,
            const Text('点击切换脉冲').textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // 闪烁循环 - 点击切换
        Row(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.amber,
              size: 40,
            ).animate(Anim.blink(repeat: true, trigger: AnimTrigger.onTap)),
            12.hGap,
            const Text('点击切换闪烁').textColor(Colors.grey),
          ],
        ).background(Colors.black.withOpacity(0.1)),
        12.vGap,
        // 淡入+滑入组合 - 点击触发
        const Text('点击淡入滑入')
            .paddingAll(12)
            .background(Colors.cyan.shade100)
            .cornerRadius(8)
            .animate(Anim.fadeSlide(trigger: AnimTrigger.onTap)),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16);

  Widget _buildOnTapAnimationDemo() => [
        // 说明文字
        const Text('以下动画默认可见，点击时有反馈效果')
            .fontSize(12)
            .textColor(Colors.grey.shade600)
            .paddingOnly(left: 16, bottom: 8),
        // Scale - 缩放（已修复）
        Row(
          children: [
            const Text('Scale 缩放')
                .paddingAll(12)
                .background(Colors.blue.shade100)
                .cornerRadius(8)
                .animate(Anim.scale(
                  begin: 1.0,
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 200),
                ))
                .expanded(),
            8.hGap,
            const Text('默认可见，点击缩放').fontSize(12).textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // Bounce - 弹跳（已修复）
        Row(
          children: [
            const Text('Bounce 弹跳')
                .paddingAll(12)
                .background(Colors.purple.shade100)
                .cornerRadius(8)
                .animate(Anim.bounce(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 300),
                ))
                .expanded(),
            8.hGap,
            const Text('默认可见，点击弹跳').fontSize(12).textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // FadeIn - 淡入（已修复）
        Row(
          children: [
            const Text('FadeIn 淡入')
                .paddingAll(12)
                .background(Colors.green.shade100)
                .cornerRadius(8)
                .animate(Anim.fadeIn(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 300),
                ))
                .expanded(),
            8.hGap,
            const Text('默认可见，点击闪烁').fontSize(12).textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // Slide - 滑动（已修复）
        Row(
          children: [
            const Text('Slide 滑动')
                .paddingAll(12)
                .background(Colors.orange.shade100)
                .cornerRadius(8)
                .animate(Anim.slideLeft(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 300),
                ))
                .expanded(),
            8.hGap,
            const Text('默认可见，点击滑动').fontSize(12).textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // Rotate - 旋转（已修复）
        Row(
          children: [
            const Icon(Icons.refresh, color: Colors.teal, size: 30)
                .paddingAll(12)
                .background(Colors.teal.shade100)
                .cornerRadius(8)
                .animate(Anim.rotate(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 300),
                )),
            8.hGap,
            const Text('Rotate 旋转 - 默认可见，点击旋转')
                .fontSize(12)
                .textColor(Colors.grey)
                .expanded(),
          ],
        ),
        12.vGap,
        // Pulse - 脉冲（已修复）
        Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red, size: 30)
                .paddingAll(12)
                .background(Colors.red.shade100)
                .cornerRadius(8)
                .animate(Anim.pulse(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 400),
                ))
                .expanded(),
            8.hGap,
            const Text('Pulse 脉冲 - 默认可见，点击脉冲')
                .fontSize(12)
                .textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // FadeSlide - 淡入+滑入（已修复）
        Row(
          children: [
            const Text('FadeSlide 淡入滑入')
                .paddingAll(12)
                .background(Colors.cyan.shade100)
                .cornerRadius(8)
                .animate(Anim.fadeSlide(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 300),
                ))
                .expanded(),
            8.hGap,
            const Text('默认可见，点击效果').fontSize(12).textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // Shake - 抖动（本来就正常）
        Row(
          children: [
            const Text('Shake 抖动')
                .paddingAll(12)
                .background(Colors.red.shade100)
                .cornerRadius(8)
                .animate(Anim.shake(
                  trigger: AnimTrigger.onTap,
                  duration: const Duration(milliseconds: 500),
                ))
                .expanded(),
            8.hGap,
            const Text('默认可见，点击抖动').fontSize(12).textColor(Colors.grey),
          ],
        ),
        12.vGap,
        // 组合测试 - IconTextButton + 动画
        const Text('IconTextButton + Scale 动画')
            .fontSize(12)
            .textColor(Colors.grey.shade600)
            .paddingOnly(left: 16, top: 8, bottom: 4),
        IconTextButtonConfig(
          icon: const Icon(Icons.thumb_up, color: Colors.white),
          text: const Text('点赞').textColor(Colors.white).bold(),
          onPressed: () => debugPrint('点赞按钮点击'),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ).bg(Colors.blue).radius(20).build().animate(Anim.scale(
              begin: 1.0,
              trigger: AnimTrigger.onTap,
              duration: const Duration(milliseconds: 200),
            )),
        12.vGap,
        IconTextButtonConfig(
          icon: const Icon(Icons.share, color: Colors.orange, size: 20),
          text: const Text('分享').fontSize(12).textColor(Colors.orange),
          onPressed: () => debugPrint('分享按钮点击'),
          padding: const EdgeInsets.all(12),
        )
            .vertical()
            .borderSide(color: Colors.orange, width: 1.5)
            .radius(12)
            .build()
            .animate(Anim.bounce(
              trigger: AnimTrigger.onTap,
              duration: const Duration(milliseconds: 300),
            )),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16);
}
