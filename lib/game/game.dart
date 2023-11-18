import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame_nery_platform_demo/game/level/level.dart';

class SimplePlatformer extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  Level? _currentLevel;
  late Image spriteSheet;
  @override
  Future<void>? onLoad() async {
    spriteSheet = await images.load('Spritesheet.png');
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    camera.viewport = FixedResolutionViewport(Vector2(640, 330));
    loadLevel('Level2.tmx');
    return super.onLoad();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }
}
