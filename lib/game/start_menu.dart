import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:videojuego/game/planet_platformer_game.dart';

class StartMenu extends StatelessWidget {
  final PlanetPlatformerGame game;

  const StartMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        color: Colors.black.withOpacity(0.5), // Optional overlay tint
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🌌 Planet Platformer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
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
                'Start Game',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: game.soundOn,
              builder: (context, soundOn, child) {
                return IconButton(
                  onPressed: () {
                    game.soundOn.value = !soundOn;
                    if (!game.soundOn.value) {
                      FlameAudio.bgm.stop();
                    } else {
                      FlameAudio.bgm.resume();
                    }
                  },
                  icon: Icon(
                      soundOn ? Icons.volume_up : Icons.volume_off,
                      color: Colors.blueAccent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

