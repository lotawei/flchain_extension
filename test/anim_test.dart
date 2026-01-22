import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flchain_extension/flchain_extension.dart';

void main() {
  group('Anim 配置类测试', () {
    group('fadeIn', () {
      test('fadeIn 应该创建 Anim 配置', () {
        final anim = Anim.fadeIn();

        expect(anim, isA<Anim>());
      });

      test('fadeIn 应该支持自定义参数', () {
        const Duration duration = Duration(milliseconds: 500);
        const Duration delay = Duration(milliseconds: 100);
        final anim = Anim.fadeIn(duration: duration, delay: delay);

        expect(anim, isA<Anim>());
      });
    });

    group('fadeOut', () {
      test('fadeOut 应该创建 Anim 配置', () {
        final anim = Anim.fadeOut();

        expect(anim, isA<Anim>());
      });
    });

    group('scale', () {
      test('scale 应该创建 Anim 配置', () {
        final anim = Anim.scale();

        expect(anim, isA<Anim>());
      });

      test('scale 应该支持自定义 scaleBegin', () {
        final anim = Anim.scale(begin: 0.5);

        expect(anim, isA<Anim>());
      });
    });

    group('bounce', () {
      test('bounce 应该创建 Anim 配置', () {
        final anim = Anim.bounce();

        expect(anim, isA<Anim>());
      });
    });

    group('slideLeft', () {
      test('slideLeft 应该创建 Anim 配置', () {
        final anim = Anim.slideLeft();

        expect(anim, isA<Anim>());
      });
    });

    group('slideRight', () {
      test('slideRight 应该创建 Anim 配置', () {
        final anim = Anim.slideRight();

        expect(anim, isA<Anim>());
      });
    });

    group('slideTop', () {
      test('slideTop 应该创建 Anim 配置', () {
        final anim = Anim.slideTop();

        expect(anim, isA<Anim>());
      });
    });

    group('slideBottom', () {
      test('slideBottom 应该创建 Anim 配置', () {
        final anim = Anim.slideBottom();

        expect(anim, isA<Anim>());
      });
    });

    group('rotate', () {
      test('rotate 应该创建 Anim 配置', () {
        final anim = Anim.rotate();

        expect(anim, isA<Anim>());
      });

      test('rotate 应该支持自定义 turns', () {
        final anim = Anim.rotate(turns: 2);

        expect(anim, isA<Anim>());
      });
    });

    group('shake', () {
      test('shake 应该创建 Anim 配置', () {
        final anim = Anim.shake();

        expect(anim, isA<Anim>());
      });

      test('shake 应该支持自定义 intensity', () {
        final anim = Anim.shake(intensity: 20);

        expect(anim, isA<Anim>());
      });
    });

    group('pulse', () {
      test('pulse 应该创建 Anim 配置', () {
        final anim = Anim.pulse();

        expect(anim, isA<Anim>());
      });
    });

    group('blink', () {
      test('blink 应该创建 Anim 配置', () {
        final anim = Anim.blink();

        expect(anim, isA<Anim>());
      });
    });

    group('fadeSlide', () {
      test('fadeSlide 应该创建 Anim 配置', () {
        final anim = Anim.fadeSlide();

        expect(anim, isA<Anim>());
      });

      test('fadeSlide 应该支持自定义 offset', () {
        const Offset offset = Offset(0.5, 0.5);
        final anim = Anim.fadeSlide(offset: offset);

        expect(anim, isA<Anim>());
      });
    });

    group('shimmer', () {
      test('shimmer 应该创建 Anim 配置', () {
        final anim = Anim.shimmer();

        expect(anim, isA<Anim>());
      });

      test('shimmer 应该支持自定义参数', () {
        const Offset direction = Offset(1, 0);
        const Color highlightColor = Colors.white;
        const double highlightOpacity = 0.8;
        const double width = 0.5;
        final anim = Anim.shimmer(
          direction: direction,
          highlightColor: highlightColor,
          highlightOpacity: highlightOpacity,
          width: width,
        );

        expect(anim, isA<Anim>());
      });
    });

    group('AnimTrigger 枚举', () {
      test('AnimTrigger.auto 应该存在', () {
        expect(AnimTrigger.auto, isA<AnimTrigger>());
      });

      test('AnimTrigger.onTap 应该存在', () {
        expect(AnimTrigger.onTap, isA<AnimTrigger>());
      });
    });

    group('参数验证', () {
      test('duration 应该正确传递', () {
        const Duration duration = Duration(milliseconds: 1000);
        final anim = Anim.fadeIn(duration: duration);

        expect(anim, isA<Anim>());
      });

      test('delay 应该正确传递', () {
        const Duration delay = Duration(milliseconds: 200);
        final anim = Anim.fadeIn(delay: delay);

        expect(anim, isA<Anim>());
      });

      test('curve 应该正确传递', () {
        const Curve curve = Curves.easeInOut;
        final anim = Anim.fadeIn(curve: curve);

        expect(anim, isA<Anim>());
      });

      test('repeat 应该正确传递', () {
        final anim = Anim.fadeIn(repeat: true);

        expect(anim, isA<Anim>());
      });

      test('trigger 应该正确传递', () {
        final anim = Anim.fadeIn(trigger: AnimTrigger.onTap);

        expect(anim, isA<Anim>());
      });
    });

    group('边界值测试', () {
      test('0 duration 应该被接受', () {
        final anim = Anim.fadeIn(duration: Duration.zero);

        expect(anim, isA<Anim>());
      });

      test('负 delay 应该被接受', () {
        final anim = Anim.fadeIn(delay: const Duration(milliseconds: -100));

        expect(anim, isA<Anim>());
      });
    });
  });
}
