import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Paused',
              style: GoogleFonts.unifrakturCook(
                textStyle: const TextStyle(fontSize: 24, color: Color(0xFF9B2015), fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.isPlaying.value = true;
                game.resumeEngine();
                game.overlays.remove('PauseMenu');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: const Color(0xFF5F5F5F).withOpacity(0.8),
              ),
              child: Text(
                  'Resume',
                style: GoogleFonts.unifrakturCook(
                  textStyle: const TextStyle(fontSize: 24, color: Color(0xFF9B2015)),
                ),
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
                backgroundColor: const Color(0xFF5F5F5F).withOpacity(0.8),
              ),
              child: Text(
                  'Restart',
                style: GoogleFonts.unifrakturCook(
                  textStyle: const TextStyle(fontSize: 24, color: Color(0xFF9B2015)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
