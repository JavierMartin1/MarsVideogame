import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/cupertino.dart';

import '../components/goal_marker.dart';
import '../components/player.dart';
import '../components/platform.dart';
import '../components/enemy.dart';

import '../components/score_text.dart';
import '../components/level_text.dart';
import '../helpers/constants.dart';

class PlanetPlatformerGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Player player;
  @override
  late World world;
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);
  final ValueNotifier<bool> soundOn = ValueNotifier(true);

  int enemiesKilled = 0;
  int level = 1;
  final List<Enemy> activeEnemies = [];

  bool leftPressed = false;
  bool rightPressed = false;
  bool jumpPressed = false;
  bool attackPressed = false;
  double elapsedTime = 0;

  @override
  Future<void> onLoad() async {
    //debugMode = true;
    if (soundOn.value) {
      FlameAudio.bgm.play('background_music.mp3', volume: 0.7);
    }

    world = World();
    add(world);

    pauseEngine(); // Prevents auto-update
    overlays.add('StartMenu');
  }

  void loadWorld() async {
    world = World();
    add(world);

    // Cargar y añadir el fondo
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

    // Crear la cámara y seguir al jugador
    final cameraComponent = CameraComponent(world: world)
      ..viewfinder.anchor = Anchor.center
      ..priority = 1;
    add(cameraComponent);

    // Añadir jugador
    player = Player(gameRef: this)
      ..position = Vector2(100, playerStartHeight)
      ..priority = 10;
    world.add(player);

    // Añadir plataforma general
    world.add(PlatformBlock(
      position: Vector2(0, playerStartHeight),
      size: Vector2(gameWidth, 90),
      image: 'platform_ground.png',
    ));

    // Añadir enemigos
    addEnemies(level);

    // Añadir ScoreText y LevelText
    add(LevelText(this));
    add(ScoreText(this));

    final goal = GoalMarker(position: Vector2(gameWidth - 200, playerStartHeight - 97));
    world.add(goal);

    cameraComponent.follow(player);
  }

  void addEnemies(int level) {
    activeEnemies.clear();
    for (Vector2 v in enemies) {
      double start = Random().nextInt(200) + v.x;
      final initialPosition = Vector2(start, v.y);
      final enemy = Enemy(
        gameRef: this,
        position: initialPosition,
        minX: v.x,
        maxX: v.x + 200,
      );
      world.add(enemy);
      activeEnemies.add(enemy);

      world.add(PlatformBlock(
          position: Vector2(v.x - 50, v.y + 40),
          size: Vector2(300, 60),
          image: 'platform_enemy.png'));
    }
  }

  void onEnemyKilled() {
    enemiesKilled++;
    if (enemiesKilled % enemies.length != 1) {
      if (enemiesKilled % 2 == 0) {
        player.health++;
      }
    }
  }

  @override
  Color backgroundColor() => const Color(0xFFECECEC);

  void startGame() {
    isPlaying.value = true;
    world.removeFromParent();
    loadWorld();
    resumeEngine();
    overlays.remove('StartMenu');
    overlays.remove('GameOver');
    overlays.remove('PauseMenu');

    level = 1;
    enemiesKilled = 0;
  }

  void advanceLevel() {
    level++;
    player.position = Vector2(100, playerStartHeight);
    player.health = 10;
    addEnemies(level);
  }

  void showGameOver() {
    isPlaying.value = false;
    pauseEngine();
    overlays.add('GameOver');
  }

  void showStartMenu() {
    isPlaying.value = false;
    pauseEngine();
    overlays.add('StartMenu');
  }
}
