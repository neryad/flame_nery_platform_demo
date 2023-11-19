import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
// import 'package:flame_nery_platform_demo/game/game_play.dart';
// import 'package:flame_nery_platform_demo/game/hub/hub.dart';
// import 'package:flame_nery_platform_demo/game/level/level.dart';
import 'package:flame_nery_platform_demo/game/model/player_data.dart';
import 'package:flame_nery_platform_demo/utils/audio_manager.dart';

class SimplePlatformer extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasTappables {
  // Level? _currentLevel;
  late Image spriteSheet;
  final playerData = PlayerData();
  @override
  Future<void>? onLoad() async {
    spriteSheet = await images.load('Spritesheet.png');
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    await AudioManager.init();
    camera.viewport = FixedResolutionViewport(Vector2(640, 330));

    return super.onLoad();
  }
}
