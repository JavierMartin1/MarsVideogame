import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import 'package:videojuego/components/goal_marker.dart';

import '../helpers/constants.dart';
import '../game/planet_platformer_game.dart';
import 'enemy.dart';
import 'platform.dart';

class Player extends PositionComponent with CollisionCallbacks, KeyboardHandler {
  final PlanetPlatformerGame gameRef;

  final double speed = 200;
  Vector2 velocity = Vector2.zero();
  bool onGround = false;
  double lastDamageTime = 0; // en segundos
  final double damageCooldown = 1.0;
  final double jumpForce = jumpForceCst;
  
  Sprite? idleSprite;
  Sprite? attackSprite;

  int health = 5;
  bool isAttacking = false;

  Player({required this.gameRef})
      : super(size: Vector2.all(80), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    try {
      idleSprite = await Sprite.load('player.png');
      attackSprite = await Sprite.load('player_attack.png');
    } catch (e) {
      print('❌ Error cargando sprites del player: $e');
    }

    add(RectangleHitbox.relative(
      Vector2(1, 1),
      parentSize: size,
      position: Vector2(0, 0),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    final min = Vector2(100, 0);
    final max = Vector2(gameWidth, gameHeight) - size;

    position.clamp(min, max);
    velocity.x = 0;
    if (gameRef.leftPressed) velocity.x = -speed;
    if (gameRef.rightPressed) velocity.x = speed;

    if (velocity.x < 0) {
      scale.x = -1;
    } else if (velocity.x > 0) {
      scale.x = 1;
    }

    if (gameRef.jumpPressed && onGround) {
      velocity.y = -jumpForce;
      onGround = false;
      gameRef.jumpPressed = false;
    }

    if (gameRef.attackPressed && !isAttacking) {
      isAttacking = true;
      attackEnemyNearby();

      Future.delayed(const Duration(milliseconds: 100), () {
        isAttacking = false;
      });
    }

    velocity.y += gravity * dt;
    position += velocity * dt;

    if (position.y > gameRef.size.y) {
      position.y = gameRef.size.y - 100;
      velocity.y = 0;
    }

    if (health <= 0) {
      print("💀 Player muerto");
      removeFromParent();
      gameRef.showGameOver();
    }
  }

  void attackEnemyNearby() {
    final enemies = gameRef.activeEnemies;
    for (final enemy in enemies) {
      final distance = (enemy.position - position).length;
      if (distance < 60 && enemy.health > 0) {
        enemy.health -= 1;
        print('🗡 Enemy hit! Queda: ${enemy.health}');
      }
    }
  }

  void receiveDamage() {
    final now = gameRef.currentTime(); // Obtén el tiempo actual del juego

    if (now - lastDamageTime >= damageCooldown) {
      health -= 1;
      lastDamageTime = now;
      print('🛑 Player golpeado. Vida restante: $health');
    } else {
      // Está en cooldown, no se aplica daño
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final spriteToRender = isAttacking ? attackSprite : idleSprite;
    if (spriteToRender != null) {
      spriteToRender.render(canvas, size: size);
    } else {
      canvas.drawRect(size.toRect(), Paint()..color = const Color(0xFF00FF00));
    }

    //Dibujar barra de vida
    const barHeight = 5.0;
    const barWidth = 50.0;
    final healthRatio = health / 5;
    final paintBg = Paint()..color = const Color(0xFF444444);
    final paintHealth = Paint()..color = const Color(0xFF43a047);

    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2 + 30, -size.y / 3, barWidth, barHeight),
      paintBg,
    );
    canvas.drawRect(
      Rect.fromLTWH(-barWidth / 2 + 30, -size.y / 3, barWidth * healthRatio, barHeight),
      paintHealth,
    );
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity.x = 0;
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space) && onGround) {
      velocity.y = -jumpForce;
      onGround = false;
    }
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlatformBlock && velocity.y >= 0) {
      final platformHitboxTop = other.position.y + (other.size.y / 4) + 10;
      onGround = true;
      velocity.y = 0;
      position.y = platformHitboxTop - (height / 2);
    }
    else if (other is GoalMarker){
      if(gameRef.world.children.whereType<Enemy>().isEmpty){
        gameRef.advanceLevel();
        print("a");
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is PlatformBlock) {
      onGround = false;
    }
    super.onCollisionEnd(other);
  }
}
