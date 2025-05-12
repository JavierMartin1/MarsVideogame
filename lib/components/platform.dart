import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class PlatformBlock extends PositionComponent with CollisionCallbacks {
  PlatformBlock({required Vector2 position, required Vector2 size}) {
    this.position = position;
    this.size = size;
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()); // ← sólido por defecto
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    //canvas.drawRect(size.toRect(), Paint()..color = Colors.brown);
  }
}
