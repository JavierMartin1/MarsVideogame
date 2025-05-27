import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import 'game/game_over_menu.dart';
import 'game/pause_menu.dart';
import 'game/planet_platformer_game.dart';
import 'game/start_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  final game = PlanetPlatformerGame();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
              overlayBuilderMap: {
                'StartMenu': (context, game) => StartMenu(game: game as PlanetPlatformerGame),
                'GameOver': (context, game) => GameOverMenu(game: game as PlanetPlatformerGame),
                'PauseMenu': (context, game) => PauseMenu(game: game as PlanetPlatformerGame),
              },
              initialActiveOverlays: const ['StartMenu'],
            ),
            ValueListenableBuilder<bool>(
            valueListenable: game.isPlaying,
            builder: (context, isPlaying, child) {
              if (!isPlaying) return const SizedBox.shrink();
              return Stack(
                children: [
                  Positioned(
                    bottom: 30,
                    left: 30,
                    child: Row(
                      children: [
                        // Botón izquierda
                        _GameButton(
                          icon: Icons.arrow_left,
                          onPressed: () => game.leftPressed = true,
                          onReleased: () => game.leftPressed = false,
                        ),
                        const SizedBox(width: 20),
                        // Botón derecha
                        _GameButton(
                          icon: Icons.arrow_right,
                          onPressed: () => game.rightPressed = true,
                          onReleased: () => game.rightPressed = false,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Row(
                      children: [
                        // Botón de salto
                        _GameButton(
                          icon: Icons.arrow_upward,
                          onPressed: () => game.jumpPressed = true,
                          onReleased: () => game.jumpPressed = false,
                        ),
                        const SizedBox(width: 20),
                        // Botón de ataque
                        _GameButton(
                          icon: Icons.gavel,
                          onPressed: () => game.attackPressed = true,
                          onReleased: () => game.attackPressed = false,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 30,
                    child: Row(
                      children:
                      [
                        _GameButton(
                          icon: Icons.refresh,
                          onPressed: () => game.startGame(),
                          onReleased: () {},
                        ),
                        const SizedBox(width: 20),
                        _GameButton(
                          icon: Icons.pause,
                          onPressed: () {
                            game.pauseEngine();
                            game.overlays.add('PauseMenu');
                            game.isPlaying.value = false;
                          },
                          onReleased: () {},
                        ),
                        const SizedBox(width: 20),
                        _GameButton(
                          icon: Icons.home,
                          onPressed: () {
                            game.showStartMenu();
                          },
                          onReleased: () {},
                        ),
                      ]
                    ),
                  ),
                ],
              );},
            ),
          ],
        ),
      ),
    ),
  );
}

class _GameButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback onReleased;

  const _GameButton({
    required this.icon,
    required this.onPressed,
    required this.onReleased,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      onTapUp: (_) => onReleased(),
      onTapCancel: () => onReleased(),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
