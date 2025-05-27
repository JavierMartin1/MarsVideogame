import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GoalMarker extends SpriteComponent with CollisionCallbacks {
  GoalMarker({required Vector2 position})
      : super(
    position: position,
    size: Vector2(150, 200),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('goal_marker.png');
    add(RectangleHitbox());
  }
}