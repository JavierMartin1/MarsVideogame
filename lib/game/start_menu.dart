import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:videojuego/game/planet_platformer_game.dart';
import 'package:google_fonts/google_fonts.dart';

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
        color: Colors.black.withOpacity(0.8), // Optional overlay tint
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/icon.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(width: 12),
                Text(
                  'Ashes of the hollow',
                  style: GoogleFonts.unifrakturCook(
                    textStyle: const TextStyle(fontSize: 32, color: Color(0xFF9B2015)),
                  ),
                ),
                const SizedBox(width: 12),
                Image.asset(
                  'assets/images/icon.png',
                  width: 48,
                  height: 48,
                ),
              ],
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
                'New Game',
                  style: GoogleFonts.unifrakturCook(
                    textStyle: const TextStyle(fontSize: 24, color: Color(0xFF9B2015)),
                  ),
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
                    color: const Color(0xFF5F5F5F),
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
