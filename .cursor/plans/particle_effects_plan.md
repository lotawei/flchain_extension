# 添加高级粒子动画效果实现方案

## 一、需求分析

用户理解正确：**烟雾、火焰、雪花本质都是粒子效果，只是参数不同**。

### 1.1 粒子效果共性
- **smoke（烟雾）**：灰白色粒子，从底部向上扩散，逐渐变淡消失
- **fire（火焰）**：橙红色粒子，向上跳跃运动，动态变化
- **snow（雪花）**：白色粒子，从上向下飘落，缓慢旋转
- **broken（玻璃破碎）**：透明碎片粒子，向外飞散，带旋转
- **glitch（故障）**：RGB分离 + 随机位移 + 颜色抖动，模拟电视故障

### 1.2 统一粒子系统设计

所有粒子效果共享同一个底层实现，通过参数配置：

```dart
// 粒子配置参数
class ParticleConfig {
  final List<Color> colors;           // 颜色（支持渐变）
  final Offset direction;              // 运动方向（-1到1的向量）
  final double speed;                  // 速度
  final double spread;                 // 扩散范围
  final int particleCount;              // 粒子数量
  final double minSize;                // 最小尺寸
  final double maxSize;                // 最大尺寸
  final double opacityStart;           // 初始透明度
  final double opacityEnd;             // 结束透明度
  final bool rotate;                   // 是否旋转
  final Curve movementCurve;           // 运动曲线
}
```

## 二、技术实现方案

### 2.1 架构设计

```
AnimType 枚举
  ├── smoke
  ├── fire  
  ├── snow
  ├── broken
  └── glitch

统一粒子系统
  ├── _ParticleSystemWidget (基础粒子渲染)
  └── _ParticleConfig (配置参数)

Anim 工厂方法
  ├── Anim.smoke(...)
  ├── Anim.fire(...)
  ├── Anim.snow(...)
  ├── Anim.broken(...)
  └── Anim.glitch(...)
```

### 2.2 实现技术

#### 方案A：CustomPainter + RepaintBoundary（推荐）
- **优点**：性能好，可控性强，跨平台一致
- **实现**：使用 `CustomPainter` 绘制粒子，`RepaintBoundary` 隔离重绘
- **适用**：smoke, fire, snow, broken

#### 方案B：Shader（GLSL Fragment Shader）
- **优点**：性能最优，效果最酷炫
- **实现**：Flutter 2.5+ 支持 Fragment Shader
- **适用**：glitch（RGB分离、颜色抖动）

#### 方案C：组合方案
- **粒子效果**：CustomPainter（smoke/fire/snow/broken）
- **故障效果**：Shader + ImageFilter（glitch）

### 2.3 具体实现

#### 2.3.1 统一粒子系统 Widget

```dart
class _ParticleSystemWidget extends StatefulWidget {
  final Widget child;
  final ParticleConfig config;
  final AnimationController controller;
  
  // 粒子数据
  final List<Particle> particles;
}

class Particle {
  Offset position;
  Offset velocity;
  double size;
  Color color;
  double opacity;
  double rotation;
  double life; // 0.0 到 1.0
}
```

#### 2.3.2 各效果参数配置

**smoke（烟雾）**：
```dart
ParticleConfig(
  colors: [Color(0xFF808080), Color(0xFFE0E0E0)],
  direction: Offset(0, -1),  // 向上
  speed: 0.3,
  spread: 0.5,
  particleCount: 30,
  opacityStart: 0.8,
  opacityEnd: 0.0,
  rotate: false,
)
```

**fire（火焰）**：
```dart
ParticleConfig(
  colors: [Color(0xFFFF4500), Color(0xFFFFD700), Color(0xFFFF0000)],
  direction: Offset(0, -1),  // 向上
  speed: 0.5,
  spread: 0.3,
  particleCount: 50,
  opacityStart: 1.0,
  opacityEnd: 0.0,
  rotate: true,  // 火焰会旋转
)
```

**snow（雪花）**：
```dart
ParticleConfig(
  colors: [Colors.white],
  direction: Offset(0, 1),  // 向下
  speed: 0.1,
  spread: 1.0,  // 横向扩散大
  particleCount: 40,
  opacityStart: 0.9,
  opacityEnd: 0.9,
  rotate: true,  // 雪花旋转
)
```

**broken（玻璃破碎）**：
```dart
ParticleConfig(
  colors: [Colors.white.withOpacity(0.8)],
  direction: Offset(0, 0),  // 向外（需要特殊处理）
  speed: 0.8,
  spread: 2.0,  // 大范围扩散
  particleCount: 20,
  opacityStart: 1.0,
  opacityEnd: 0.0,
  rotate: true,  // 碎片旋转
)
```

**glitch（故障）**：
- 不使用粒子系统
- 使用 `ShaderMask` + 自定义 Fragment Shader
- RGB通道分离 + 随机位移 + 颜色抖动

### 2.4 文件修改清单

#### 2.4.1 枚举扩展
- **文件**：`lib/src/widget_extension.dart` (1104-1116行)
- **修改**：在 `AnimType` 枚举中添加：
  ```dart
  smoke,
  fire,
  snow,
  broken,
  glitch,
  ```

#### 2.4.2 Anim 工厂方法
- **文件**：`lib/src/widget_extension.dart` (约1100-1200行)
- **添加**：5个静态工厂方法
  - `Anim.smoke({...})`
  - `Anim.fire({...})`
  - `Anim.snow({...})`
  - `Anim.broken({...})`
  - `Anim.glitch({...})`

#### 2.4.3 粒子系统实现
- **文件**：`lib/src/widget_extension.dart` (新增)
- **添加**：
  - `ParticleConfig` 类
  - `Particle` 类
  - `_ParticleSystemWidget` 类
  - `_ParticleSystemPainter` 类（CustomPainter）

#### 2.4.4 渲染逻辑
- **文件**：`lib/src/widget_extension.dart` (`_UnifiedAnimWidget._buildAnimatedChild`)
- **修改**：在 switch 中添加新 case：
  ```dart
  case AnimType.smoke:
  case AnimType.fire:
  case AnimType.snow:
  case AnimType.broken:
    return _ParticleSystemWidget(...);
  case AnimType.glitch:
    return _GlitchWidget(...);
  ```

#### 2.4.5 Glitch 特殊实现
- **文件**：`lib/src/widget_extension.dart` (新增)
- **添加**：
  - `_GlitchWidget` 类
  - `_GlitchShader`（Fragment Shader，可选）
  - 或使用 `ImageFilter` + `ShaderMask` 组合

## 三、UI/UX 设计考虑

### 3.1 性能优化
- 使用 `RepaintBoundary` 隔离粒子系统重绘
- 粒子数量可配置（默认值平衡效果和性能）
- 支持降低粒子数量（低端设备）

### 3.2 用户体验
- 提供合理的默认参数
- 支持自定义颜色、速度、密度
- 动画可中断和重置

### 3.3 跨平台兼容
- CustomPainter 在所有平台表现一致
- Shader 需要 Flutter 2.5+，提供降级方案
- 性能监控和自适应调整

## 四、实现步骤

1. **第一步**：创建粒子系统基础架构
   - `ParticleConfig` 类
   - `Particle` 数据类
   - `_ParticleSystemPainter`（CustomPainter）

2. **第二步**：实现统一粒子 Widget
   - `_ParticleSystemWidget` 状态管理
   - 粒子生成和更新逻辑
   - 与 AnimationController 集成

3. **第三步**：添加各效果配置
   - smoke、fire、snow、broken 的参数配置
   - 在 `Anim` 类中添加工厂方法

4. **第四步**：实现 glitch 效果
   - RGB分离逻辑
   - 随机位移和抖动
   - 使用 ShaderMask 或 ImageFilter

5. **第五步**：集成到统一动画系统
   - 在 `_UnifiedAnimWidget` 中添加渲染逻辑
   - 处理 repeat、trigger 等参数

6. **第六步**：测试和优化
   - 性能测试
   - 视觉效果调优
   - 边界情况处理

## 五、代码示例结构

```dart
// 1. 枚举扩展
enum AnimType {
  // ... existing
  smoke,
  fire,
  snow,
  broken,
  glitch,
}

// 2. 粒子配置
class ParticleConfig {
  final List<Color> colors;
  final Offset direction;
  final double speed;
  // ... 其他参数
}

// 3. Anim 工厂方法
static Anim smoke({
  Color smokeColor = const Color(0xFF808080),
  int particleCount = 30,
  // ...
}) => Anim._(
  type: AnimType.smoke,
  // 使用 slideOffset 存储 direction
  // 使用 intensity 存储 particleCount
  // ...
);

// 4. 粒子系统 Widget
class _ParticleSystemWidget extends StatefulWidget {
  // ...
}

// 5. 渲染逻辑
case AnimType.smoke:
case AnimType.fire:
case AnimType.snow:
case AnimType.broken:
  return _ParticleSystemWidget(
    config: _getParticleConfig(anim.type),
    controller: _controller,
    child: widget.child,
  );
```

## 六、注意事项

1. **性能**：粒子数量需要平衡，默认值建议 20-50
2. **内存**：及时清理粒子数据，避免内存泄漏
3. **兼容性**：Shader 需要 Flutter 2.5+，提供降级方案
4. **可配置性**：保持 API 简洁，但允许高级用户自定义参数

## 七、预期效果

- **smoke**：从底部向上扩散的灰色烟雾，适合过渡动画
- **fire**：向上跳跃的橙红色火焰，适合强调和警告
- **snow**：从上向下飘落的白色雪花，适合节日和装饰
- **broken**：向外飞散的透明碎片，适合错误和破坏性操作
- **glitch**：RGB分离 + 抖动，适合科技感和故障提示

## 八、技术细节

### 8.1 粒子生命周期管理
- 粒子从生成到消失的完整生命周期
- 使用 `life` 值（0.0-1.0）控制透明度、大小等属性
- 粒子死亡后重新生成，实现循环效果

### 8.2 性能优化策略
- 使用对象池复用粒子对象
- 限制同时存在的粒子数量
- 使用 `RepaintBoundary` 减少重绘范围
- 低端设备自动降低粒子数量

### 8.3 Glitch 实现细节
- RGB通道分离：使用 `ShaderMask` 分别处理 R、G、B 通道
- 随机位移：使用 `Transform.translate` 随机偏移
- 颜色抖动：使用 `ColorFilter` 或自定义 Shader
- 时间控制：使用 `AnimationController` 控制抖动频率
