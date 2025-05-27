import 'package:flame/components.dart';

const double gameWidth = 3500;
const double gameHeight = 1000;

const double gravity = 600;
const double jumpForceCst = 500;

const double playerStartHeight = gameHeight/1.53;
List<Vector2> enemies = [
  Vector2(600, playerStartHeight - 240),   // Primera: ligeramente elevada
  Vector2(1100, playerStartHeight - 390),   // Segunda: más arriba y separada
  Vector2(1650, playerStartHeight - 450),  // Tercera
  Vector2(2150, playerStartHeight - 410),  // Cuarta
  Vector2(2750, playerStartHeight - 460),  // Quinta: la más alta
];