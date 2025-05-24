import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import '../components/player.dart';
import '../components/platform.dart';
import '../components/enemy.dart';

import '../components/score_text.dart';
import '../helpers/constants.dart';

class PlanetPlatformerGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Player player;
  @override
  late World world;

  int enemiesKilled = 0;
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

    //Cargar y añadir el fondo
    final sprite = await Sprite.load('background2.png');
    final worldSize = Vector2(gameWidth, gameHeight);

    const backgroundMargin = 0.55;
    final backgroundSize = worldSize * (1 + backgroundMargin * 2); // adds margin on all sides

    final background = SpriteComponent()
      ..sprite = sprite
      ..size = backgroundSize
      ..position = worldSize * -backgroundMargin
      ..anchor = Anchor.topLeft;
    world.add(background);

    //Crear la cámara y seguir al jugador
    final cameraComponent = CameraComponent(world: world)
      ..viewfinder.anchor = Anchor.center
      ..priority = 1;
    add(cameraComponent);

    //Añadir jugador
    player = Player(gameRef: this)
      ..position = Vector2(100, playerStartHeight)
      ..priority = 10;
    world.add(player);

    //Añadir plataforma general
    world.add(PlatformBlock(
      position: Vector2(0, playerStartHeight),
      size: Vector2(gameWidth, 10),
    ));

    //Añadir enemigos
    for(Vector2 v in enemies){
      world.add(Enemy(
        gameRef: this,
        position: v,
        minX: v.x,
        maxX: v.x + 200,
      ));
      world.add(PlatformBlock(
          position: Vector2(v.x - 50, v.y),
          size: Vector2(300, 100),
          useImage: true
      ));
      add(ScoreText(this));
    }

    cameraComponent.follow(player);
  }

  void onEnemyKilled(){
    enemiesKilled++;
    print(enemiesKilled);
  }

  @override
  Color backgroundColor() => const Color(0xFFECECEC);
}
