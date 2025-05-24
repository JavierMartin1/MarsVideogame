import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:videojuego/game/planet_platformer_game.dart';

class ScoreText extends TextComponent {
  final PlanetPlatformerGame gameRef;

  ScoreText(this.gameRef)
      : super(
    text: 'Kills: 0',
    anchor: Anchor.topRight,
    position: Vector2(0, 10), // will update X in onGameResize
    textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
      ),
    ),
    priority: 100,
  );

  @override
  void update(double dt) {
    text = 'Kills: ${gameRef.enemiesKilled}';
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    // Position in top-right corner, with 10 pixels padding from right edge
    position = Vector2(size.x - 10, 10);
  }
}