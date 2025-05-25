import 'package:flutter/material.dart';
import 'package:videojuego/game/planet_platformer_game.dart';

class GameOverMenu extends StatelessWidget {
  final PlanetPlatformerGame game;

  const GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '💀 Game Over',
            style: TextStyle(
              fontSize: 36,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Enemies defeated: ${game.enemiesKilled}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
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
    );
  }
}
