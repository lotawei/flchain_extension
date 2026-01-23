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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // 更现代的紫色
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const ChainableExample(),
    );
  }
}

class ChainableExample extends StatelessWidget {
  const ChainableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLChain 设计展示'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            _buildSectionTitle(context, '✨ 动画效果 - 自动播放'),
            _buildAnimationDemo(),
            _buildSectionTitle(context, '🧩 组合序列动画'),
            _buildSequenceAnimationDemo(),
            _buildSectionTitle(context, '🎯 动画效果 - 点击触发'),
            _buildOnTapAnimationDemo(),
            _buildSectionTitle(context, '🔥 高级视觉效果'),
            _buildAdvancedAnimationDemo(),
            _buildSectionTitle(context, '📝 基础文本样式'),
            _buildTextDemo(),
            _buildSectionTitle(context, '🎨 容器装饰'),
            _buildContainerDemo(),
            _buildSectionTitle(context, '📐 组合布局'),
            _buildLayoutDemo(context),
            _buildSectionTitle(context, '🔘 按钮样式'),
            _buildButtonDemo(context),
            _buildSectionTitle(context, '🃏 卡片组件'),
            _buildCardDemo(context),
          ],
        ).scrollable().safeArea(),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FLChain Extension')
                .fontSize(28)
                .bold()
                .textColor(Colors.white),
            8.vGap,
            const Text('现代化的 Flutter 链式调用扩展库')
                .fontSize(14)
                .textColor(Colors.white.withOpacity(0.9)),
          ],
        ),
      );

  Widget _buildSectionTitle(BuildContext context, String title) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 4,
            ),
          ),
        ),
        child: Text(title).fontSize(16).bold().textColor(Colors.grey.shade800),
      );

  Widget _buildTextDemo() => Builder(
        builder: (context) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: [
            // String 扩展快速创建
            '你好木木哒'
                .text
                .fontSize(26)
                .bold()
                .textColor(Theme.of(context).colorScheme.primary),
            20.vGap,
            // Text 链式样式
            const Text('下划线+斜体')
                .underline()
                .italic()
                .fontSize(18)
                .textColor(Colors.orange.shade700),
            12.vGap,
            const Text('带阴影文字')
                .fontSize(22)
                .bold()
                .textColor(Colors.purple.shade700)
                .shadow(blurRadius: 4, color: Colors.purple.shade200),
            12.vGap,
            const Text('这是一段很长的文字需要省略显示的效果测试 这是一段很长的文字需要省略显示的效果测试')
                .fontSize(14)
                .textColor(Colors.grey.shade700)
                .ellipsis(),
            12.vGap,
            // 在可滚动容器中使用 flexibleSafe + shrinkWrap
            const Text('这是一段很长的文字需要省略显示的效果测试 这是一段很长的文字需要省略显示的效果测试')
                .fontSize(14)
                .textColor(Colors.grey.shade700)
                .flexibleSafe(),
          ].toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            shrinkWrap: true,
          ),
        ),
      );

  Widget _buildContainerDemo() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: [
          // 背景+圆角
          Text('背景+圆角')
              .fontSize(16)
              .bold()
              .textColor(Colors.blue.shade700)
              .paddingAll(16)
              .background(Colors.blue.shade50)
              .cornerRadius(12),
          16.vGap,
          // 渐变背景
          Text('渐变背景')
              .fontSize(16)
              .bold()
              .textColor(Colors.white)
              .paddingAll(16)
              .linearGradient(colors: [
            Colors.blue.shade600,
            Colors.purple.shade600,
          ]).cornerRadius(12),
          16.vGap,
          // 阴影+边框
          Text('阴影+边框')
              .fontSize(16)
              .bold()
              .textColor(Colors.blue.shade700)
              .paddingAll(16)
              .border(color: Colors.blue.shade300, width: 2, radius: 12)
              .shadow(blurRadius: 8, color: Colors.blue.shade100),
          16.vGap,
          // 模糊效果
          Text('模糊效果')
              .fontSize(16)
              .bold()
              .textColor(Colors.grey.shade700)
              .paddingAll(16)
              .blur(sigmaX: 1, sigmaY: 1),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      );

  Widget _buildLayoutDemo(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.shade50,
              Colors.orange.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.amber.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 圆形图标
            Container(
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.star, color: Colors.amber, size: 30),
            ),
            16.hGap,
            // 文字扩展填充
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rating: 4.5')
                    .fontSize(18)
                    .bold()
                    .textColor(Colors.grey.shade800),
                4.vGap,
                const Text('基于 128 条评价')
                    .fontSize(12)
                    .textColor(Colors.grey.shade600),
              ],
            ).expanded(),
            // 右侧图标
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );

  Widget _buildButtonDemo(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: [
          // 主按钮 - 渐变背景
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text('主按钮')
                .fontSize(16)
                .textColor(Colors.white)
                .bold()
                .center()
                .height(52)
                .fullWidth()
                .onTap(() => debugPrint('主按钮点击')),
          ),
          16.vGap,
          // 次按钮 - 边框样式
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text('次按钮')
                .fontSize(16)
                .textColor(Theme.of(context).colorScheme.primary)
                .bold()
                .center()
                .height(52)
                .fullWidth()
                .onTap(() => debugPrint('次按钮点击')),
          ),
          16.vGap,
          // IconTextButton - 水平布局 - 带点击动画
          IconTextButtonConfig(
            icon: const Icon(Icons.favorite, color: Colors.white),
            text: const Text('喜欢').textColor(Colors.white).bold(),
            onPressed: () => debugPrint('喜欢按钮点击'),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          ).bg(Colors.red.shade600).radius(28).build().animate(Anim.scale(
                begin: 1.0,
                trigger: AnimTrigger.onTap,
                duration: const Duration(milliseconds: 200),
              )),
          16.vGap,
          // IconTextButton - 垂直布局
          IconTextButtonConfig(
            icon: const Icon(Icons.share, color: Colors.blue, size: 24),
            text: const Text('分享').fontSize(13).textColor(Colors.blue).bold(),
            onPressed: () => debugPrint('分享按钮点击'),
            padding: const EdgeInsets.all(18),
          )
              .vertical()
              .borderSide(color: Colors.blue.shade300, width: 2)
              .radius(16)
              .build(),
          16.vGap,
          // IconTextButton - 链式调用示例
          IconTextButtonConfig(
            icon: Icon(Icons.download, size: 22, color: Colors.green.shade700),
            text: const Text('下载')
                .fontSize(14)
                .textColor(Colors.green.shade700)
                .bold(),
            onPressed: () => debugPrint('下载按钮点击'),
          )
              .padAll(18)
              .gap(10)
              .bg(Colors.green.shade50)
              .radius(12)
              .borderSide(
                  color: const Color.fromARGB(255, 154, 194, 156), width: 1.5)
              .build(),
          16.vGap,
          // 禁用按钮
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text('禁用按钮')
                .fontSize(16)
                .textColor(Colors.grey.shade500)
                .center()
                .height(52)
                .fullWidth()
                .ignorePointer(),
          ),
        ].toColumn(),
      );

  Widget _buildCardDemo(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: [
          // 卡片头部装饰
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.card_giftcard,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  12.hGap,
                  const Text('精美卡片标题')
                      .fontSize(20)
                      .bold()
                      .textColor(Colors.grey.shade800)
                      .expanded(),
                ],
              ),
              16.vGap,
              const Text(
                '这是卡片内容描述，支持多行显示。展示了现代 UI 设计的最佳实践，包括优雅的阴影、圆角和间距。',
              ).fontSize(15).textColor(Colors.grey.shade700).height(1.5),
              20.vGap,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text('查看详情')
                        .fontSize(15)
                        .bold()
                        .textColor(Colors.blue.shade700)
                        .expanded(),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16).onTap(() {
                  debugPrint('查看详情点击');
                }),
              ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          ),
        ].toColumn(),
      );

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
        12.vGap,
        // 流光效果 - 自动循环播放
        const Text('流光效果（自动循环）')
            .fontSize(16)
            .bold()
            .textColor(Colors.white)
            .paddingAll(16)
            .background(Colors.indigo.shade600)
            .cornerRadius(12)
            .animate(Anim.shimmer(
              duration: const Duration(milliseconds: 2000),
              highlightColor: Colors.orange,
              repeat: true,
            )),
        12.vGap,
        // 流光效果 - 点击触发
        const Text('流光效果（点击触发）')
            .fontSize(16)
            .bold()
            .textColor(Colors.white)
            .paddingAll(16)
            .background(Colors.teal.shade600)
            .cornerRadius(12)
            .animate(Anim.shimmer(
              duration: const Duration(milliseconds: 1500),
              highlightColor: Colors.orange,
              trigger: AnimTrigger.onTap,
            )),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16);

  Widget _buildSequenceAnimationDemo() => [
        const Text('顺序 + 交错 + 并行示例')
            .fontSize(12)
            .textColor(Colors.grey.shade600)
            .paddingOnly(left: 16, bottom: 8),
        const Text('顺序：淡入 -> 滑入 -> 轻微缩放')
            .fontSize(12)
            .textColor(Colors.grey.shade700)
            .paddingOnly(left: 16, bottom: 8),
        const Text('顺序组合卡片')
            .fontSize(16)
            .bold()
            .textColor(Colors.white)
            .paddingAll(16)
            .background(Colors.indigo.shade500)
            .cornerRadius(12)
            .animateSequence(
              AnimSequence(
                duration: const Duration(milliseconds: 800),
                steps: [
                  AnimStep.fadeIn(interval: const Interval(0.0, 0.3)),
                  AnimStep.slide(
                    interval: const Interval(0.1, 0.6),
                    begin: const Offset(0, 0.6),
                  ),
                  AnimStep.scale(
                    interval: const Interval(0.6, 1.0),
                    begin: 0.98,
                    end: 1.0,
                  ),
                ],
                trigger: AnimTrigger.onTap,
              ),
            ),
        12.vGap,
        const Text('并行：同时淡入 + 缩放 + 轻微旋转')
            .fontSize(12)
            .textColor(Colors.grey.shade700)
            .paddingOnly(left: 16, bottom: 8),
        const Text('并行组合卡片')
            .fontSize(16)
            .bold()
            .textColor(Colors.white)
            .paddingAll(16)
            .background(Colors.teal.shade500)
            .cornerRadius(12)
            .animateSequence(
              AnimSequence(
                duration: const Duration(milliseconds: 600),
                steps: [
                  AnimStep.fadeIn(interval: const Interval(0.0, 1.0)),
                  AnimStep.scale(
                    interval: const Interval(0.0, 1.0),
                    begin: 0.9,
                    end: 1.0,
                  ),
                  AnimStep.rotate(
                    interval: const Interval(0.0, 1.0),
                    begin: 0.0,
                    end: 0.05,
                  ),
                ],
              ),
            ),
        12.vGap,
        const Text('交错：列表按索引延迟')
            .fontSize(12)
            .textColor(Colors.grey.shade700)
            .paddingOnly(left: 16, bottom: 8),
        [
          _buildSequenceListItem('第一项', 0),
          8.vGap,
          _buildSequenceListItem('第二项', 1),
          8.vGap,
          _buildSequenceListItem('第三项', 2),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16),
        const Text('点击触发：按钮微交互')
            .fontSize(12)
            .textColor(Colors.grey.shade700)
            .paddingOnly(left: 16, bottom: 8),
        const Text('点击我')
            .fontSize(16)
            .bold()
            .textColor(Colors.white)
            .paddingAll(14)
            .background(Colors.purple.shade500)
            .cornerRadius(10)
            .animateSequence(
              AnimSequence(
                duration: const Duration(milliseconds: 500),
                trigger: AnimTrigger.onTap,
                steps: [
                  AnimStep.scale(
                    interval: const Interval(0.0, 0.6),
                    begin: 1.0,
                    end: 0.92,
                  ),
                  AnimStep.scale(
                    interval: const Interval(0.6, 1.0),
                    begin: 0.92,
                    end: 1.0,
                  ),
                  AnimStep.fade(
                    interval: const Interval(0.0, 0.6),
                    begin: 1.0,
                    end: 0.8,
                  ),
                  AnimStep.fade(
                    interval: const Interval(0.6, 1.0),
                    begin: 0.8,
                    end: 1.0,
                  ),
                ],
              ),
            ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16);

  Widget _buildSequenceListItem(String title, int index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(title).fontSize(14).textColor(Colors.grey.shade800),
      ).animateSequence(
        AnimSequence.stagger(
          index: index,
          stagger: const Duration(milliseconds: 80),
          steps: [
            AnimStep.fadeIn(interval: const Interval(0.0, 0.6)),
            AnimStep.slide(
              interval: const Interval(0.0, 0.6),
              begin: const Offset(0, 0.15),
            ),
          ],
        ),
      );

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

  Widget _buildAdvancedAnimationDemo() => [
        // 说明文字
        const Text('高级视觉效果演示 - 适合特殊场景和强调效果')
            .fontSize(12)
            .textColor(Colors.grey.shade600)
            .paddingOnly(left: 16, bottom: 8),
        16.vGap,
        // Smoke 效果 - 盐雾
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: [
            const Text('Smoke 盐雾效果')
                .fontSize(16)
                .bold()
                .textColor(Colors.white),
            8.vGap,
            const Text('适合过渡和消失动画')
                .fontSize(12)
                .textColor(Colors.grey.shade400),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        )
            .animate(Anim.smoke(
              duration: const Duration(milliseconds: 800),
              smokeColor: Colors.grey.shade400,
              intensity: 0.7,
            ))
            .cornerRadius(12),

        12.vGap,
        // Fire 效果 - 火焰
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: [
            const Text('Fire 火焰效果').fontSize(16).bold().textColor(Colors.white),
            8.vGap,
            const Text('适合强调和警告场景')
                .fontSize(12)
                .textColor(Colors.orange.shade200),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        )
            .animate(Anim.fire(
              duration: const Duration(milliseconds: 1000),
              fireColor: Colors.orange,
              intensity: 0.8,
              repeat: true,
            ))
            .cornerRadius(12),
        12.vGap,
        // Snow 效果 - 雪花
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: [
            const Text('Snow 雪花效果').fontSize(16).bold().textColor(Colors.white),
            8.vGap,
            const Text('适合冬季主题和装饰效果')
                .fontSize(12)
                .textColor(Colors.blue.shade200),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        )
            .animate(Anim.snow(
              duration: const Duration(milliseconds: 2000),
              snowColor: Colors.white,
              intensity: 0.7,
              repeat: true,
            ))
            .cornerRadius(12),
        12.vGap,
        // Broken 效果 - 玻璃破碎
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: [
            const Text('Broken 玻璃破碎效果')
                .fontSize(16)
                .bold()
                .textColor(Colors.white),
            8.vGap,
            const Text('适合错误或破坏性操作反馈')
                .fontSize(12)
                .textColor(Colors.red.shade200),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        )
            .animate(Anim.broken(
              duration: const Duration(milliseconds: 600),
              brokenPieces: 10,
              intensity: 0.9,
            ))
            .cornerRadius(12),
        12.vGap,
        // Glitch 效果 - 故障
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: [
            const Text('Glitch 故障效果')
                .fontSize(16)
                .bold()
                .textColor(Colors.white),
            8.vGap,
            const Text('适合科技感和错误提示')
                .fontSize(12)
                .textColor(Colors.purple.shade300),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        )
            .animate(Anim.glitch(
              duration: const Duration(milliseconds: 300),
              intensity: 0.6,
              repeat: true,
            ))
            .cornerRadius(12),
        12.vGap,
        // 点击触发版本
        const Text('点击触发版本')
            .fontSize(12)
            .textColor(Colors.grey.shade600)
            .paddingOnly(left: 16, top: 8, bottom: 4),
        12.vGap,
        // Smoke - 点击触发
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Text('点击触发 Smoke')
              .fontSize(14)
              .textColor(Colors.grey.shade800),
        )
            .animate(Anim.smoke(
                duration: const Duration(milliseconds: 800),
                smokeColor: Colors.grey.shade600,
                intensity: 0.7,
                trigger: AnimTrigger.onTap,
                repeat: true))
            .cornerRadius(8)
            .onTap(() {
          debugPrint('点击触发 Smoke');
        }),
        8.vGap,
        // Fire - 点击触发
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 182, 180, 177),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('点击触发 Fire')
              .fontSize(14)
              .textColor(Colors.orange.shade900),
        )
            .animate(Anim.fire(
              duration: const Duration(milliseconds: 1000),
              fireColor: Colors.red,
              intensity: 0.8,
              trigger: AnimTrigger.onTap,
              repeat: true,
            ))
            .cornerRadius(8),
        8.vGap,
        // Broken - 点击触发
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade300),
          ),
          child: const Text('点击触发 Broken')
              .fontSize(14)
              .textColor(Colors.red.shade900),
        )
            .animate(Anim.broken(
              duration: const Duration(milliseconds: 600),
              brokenPieces: 12,
              intensity: 0.9,
              trigger: AnimTrigger.onTap,
            ))
            .cornerRadius(8)
            .onTap(() {
          debugPrint('点击触发 Broken');
        }),
        8.vGap,
        // Glitch - 点击触发
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.shade300),
          ),
          child: const Text('点击触发 Glitch')
              .fontSize(14)
              .textColor(Colors.purple.shade900),
        )
            .animate(Anim.glitch(
              duration: const Duration(milliseconds: 300),
              intensity: 0.6,
              trigger: AnimTrigger.onTap,
            ))
            .cornerRadius(8),
        12.vGap,
        // 组合使用示例
        const Text('组合使用示例')
            .fontSize(12)
            .textColor(Colors.grey.shade600)
            .paddingOnly(left: 16, top: 8, bottom: 4),
        12.vGap,
        // IconTextButton + Glitch
        IconTextButtonConfig(
          icon: const Icon(Icons.warning, color: Colors.white),
          text: const Text('警告').textColor(Colors.white).bold(),
          onPressed: () => debugPrint('警告按钮点击'),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ).bg(Colors.red.shade600).radius(20).build().animate(Anim.glitch(
              duration: const Duration(milliseconds: 300),
              intensity: 0.5,
              trigger: AnimTrigger.onTap,
            )),
        8.vGap,
        // Text + Fire
        const Text('🔥 重要通知')
            .fontSize(18)
            .bold()
            .textColor(Colors.white)
            .paddingAll(16)
            .background(Colors.orange.shade600)
            .cornerRadius(12)
            .animate(Anim.fire(
              duration: const Duration(milliseconds: 1000),
              fireColor: Colors.orange,
              intensity: 0.7,
              repeat: true,
            )),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingAll(16);
}
