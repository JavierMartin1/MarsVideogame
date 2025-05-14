import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import '../components/player.dart';
import '../components/platform.dart';
import '../components/enemy.dart';

import '../helpers/constants.dart';

class PlanetPlatformerGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Player player;

  bool leftPressed = false;
  bool rightPressed = false;
  bool jumpPressed = false;
  bool attackPressed = false;
  double elapsedTime = 0;

  @override
  Future<void> onLoad() async {
    // 🔹 Cargar y añadir el fondo
    final background = SpriteComponent()
      ..sprite = await Sprite.load('background.png')
      ..size = Vector2(1635, 400)
      ..anchor = Anchor.topLeft
      ..priority = -1
      ..position = Vector2(-100, 0);

    add(background);

    // 🔹 Añadir jugador
    player = Player(gameRef: this)
      ..position = Vector2(100, gameHeight - 150);
    add(player);

    // 🔹 Añadir plataforma
    add(PlatformBlock(
      position: Vector2(0, gameHeight - 195),
      size: Vector2(1000, 100),
    ));

    // 🔹 Añadir enemigo
    add(Enemy(
      position: Vector2(600, gameHeight - 220),
      minX: 400,
      maxX: 600,
    ));

    // 🔹 Cámara
    final camera = CameraComponent.withFixedResolution(
      width: size.x,
      height: size.y,
    )..viewfinder.anchor = Anchor.topLeft;

    camera.follow(player);
    add(camera);
  }
  @override
  Color backgroundColor() => const Color(0xFFECECEC);
}
