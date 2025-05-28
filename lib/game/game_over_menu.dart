import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          Text(
            '💀 Game Over 💀',
            style: GoogleFonts.unifrakturCook(
              textStyle: const TextStyle(fontSize: 35, color: Color(0xFF9B2015), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Enemies defeated: ${game.enemiesKilled}',
            style: GoogleFonts.unifrakturCook(
              textStyle: const TextStyle(fontSize: 24, color: Color(0xFF9B2015), fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
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
          )
        ],
      ),
    );
  }
}
