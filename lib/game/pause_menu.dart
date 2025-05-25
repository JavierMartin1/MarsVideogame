import 'package:flutter/material.dart';
import 'package:videojuego/game/planet_platformer_game.dart';

class PauseMenu extends StatelessWidget {
  final PlanetPlatformerGame game;

  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.resumeEngine();
                game.overlays.remove('PauseMenu');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                  'Resume',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('PauseMenu');
                game.startGame();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                  'Restart',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
