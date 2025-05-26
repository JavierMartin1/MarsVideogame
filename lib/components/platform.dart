import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class PlatformBlock extends PositionComponent with CollisionCallbacks {
  String? image;
  late Sprite? _sprite;

  PlatformBlock({required Vector2 position, required Vector2 size, this.image,
  }) {
    this.position = position;
    this.size = size;
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onLoad() async {
    if(image != null){
      _sprite = await Sprite.load(image!);
    }
      add(RectangleHitbox());
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if(image != null){
      _sprite!.render(canvas, size: size);
    }
  }
}