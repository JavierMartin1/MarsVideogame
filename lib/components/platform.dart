import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class PlatformBlock extends PositionComponent with CollisionCallbacks {
  final bool useImage;
  late Sprite? _sprite;

  PlatformBlock({required Vector2 position, required Vector2 size, this.useImage = false, // default: use image
  }) {
    this.position = position;
    this.size = size;
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onLoad() async {
    if(useImage){
      _sprite = await Sprite.load('platform.png');
      add(RectangleHitbox(
        size: Vector2(size.x, 10),
        position: Vector2(0, size.y/4 + 10), // Align with top of platform
      ));
    }
    else{
      add(RectangleHitbox());
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(useImage){
     _sprite!.render(canvas, size: size);

    }
    else{
      canvas.drawRect(size.toRect(), Paint()..color = Colors.brown);
    }
  }
}
