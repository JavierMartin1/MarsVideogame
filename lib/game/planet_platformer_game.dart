import 'dart:math';
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
  @override
  late World world;

  bool leftPressed = false;
  bool rightPressed = false;
  bool jumpPressed = false;
  bool attackPressed = false;
  double elapsedTime = 0;

  @override
  Future<void> onLoad() async {
    //debugMode = true;
    world = World();
    add(world);

    // 🔹 Crear la cámara y seguir al jugador
    final cameraComponent = CameraComponent(world: world)
      ..viewfinder.anchor = Anchor.center
      ..priority = 1;
    add(cameraComponent);

    // 🔹 Cargar y añadir el fondo
    final sprite = await Sprite.load('background2.png');
    final imageSize = sprite.srcSize;
    final viewportSize = size;

    final scaleX = viewportSize.x / imageSize.x;
    final scaleY = viewportSize.y / imageSize.y;

    final scale = max(scaleX, scaleY);

    final background = SpriteComponent()
      ..sprite = sprite
      ..size = imageSize * scale
      ..position = viewportSize / 2
      ..anchor = Anchor.center;

    world.add(background);

    // 🔹 Añadir jugador
    player = Player(gameRef: this)
      ..position = Vector2(50, gameHeight - 195);
    world.add(player);

    // 🔹 Añadir plataforma
    world.add(PlatformBlock(
      position: Vector2(0, gameHeight - 130),
      size: Vector2(1540, 100),
    ));

    // 🔹 Añadir enemigo
    world.add(Enemy(
      position: Vector2(600, gameHeight - 235),
      minX: 400,
      maxX: 600,
    ));
    cameraComponent.follow(player);
  }
  @override
  Color backgroundColor() => const Color(0xFFECECEC);
}
