import 'package:flame/components.dart';
import '../components/platform.dart';
import '../helpers/constants.dart';

class Level1 extends Component {
  @override
  Future<void> onLoad() async {
    add(PlatformBlock(
      position: Vector2(0, gameHeight - 50),
      size: Vector2(gameWidth, 50),
    ));
    add(PlatformBlock(
      position: Vector2(200, gameHeight - 150),
      size: Vector2(100, 20),
    ));
    add(PlatformBlock(
      position: Vector2(400, gameHeight - 100),
      size: Vector2(100, 20),
    ));
  }
}
