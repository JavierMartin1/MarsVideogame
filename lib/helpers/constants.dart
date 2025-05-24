import 'package:flame/components.dart';

const double gameWidth = 3500;
const double gameHeight = 700;

const double gravity = 600;
const double jumpForceCst = 500;

const double playerStartHeight = gameHeight/1.53;
List<Vector2> enemies = [Vector2(500, playerStartHeight - 200), Vector2(800, playerStartHeight - 400)];