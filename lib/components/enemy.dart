import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../helpers/constants.dart';
import 'player.dart';

class Enemy extends SpriteComponent with CollisionCallbacks {
  final double speed;
  final double minX;
  final double maxX;
  bool movingRight;

  int health = 3;
  bool isAlive = true;

  Enemy({
    required Vector2 position,
    this.speed = 80,
    this.minX = 0,
    this.maxX = 800,
    this.movingRight = true,
  }) : super(position: position, size: Vector2.all(50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('enemy.png');
    anchor = Anchor.center;
    add(RectangleHitbox.relative(
      Vector2(0.7, 0.8),
      parentSize: size,
      position: Vector2(0, 5),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isAlive) return;

    position.x += (movingRight ? 1 : -1) * speed * dt;

    if (position.x < minX || position.x > maxX) {
      movingRight = !movingRight;
    }

    if (health <= 0) {
      isAlive = false;
      removeFromParent();
      print('💀 Enemy eliminado');
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 🔴 Dibujar barra de vida encima del enemigo
    const barHeight = 5.0;
    const barWidth = 40.0;
    final healthRatio = health / 3;
    final paintBg = Paint()..color = const Color(0xFF444444);
    final paintHealth = Paint()..color = const Color(0xFFe53935);

    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2+25, -size.y / 2, barWidth, barHeight),
      paintBg,
    );

    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2+25, -size.y / 2, barWidth * healthRatio, barHeight),
      paintHealth,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.receiveDamage();
    }
    super.onCollision(intersectionPoints, other);
  }
}
