import 'package:flame/components.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/game/hub/hub.dart';
import 'package:flame_nery_platform_demo/game/level/level.dart';

class GamePlay extends Component with HasGameRef<SimplePlatformer> {
  Level? _currentLevel;
  final hub = (Hub(priority: 1));
  @override
  Future<void>? onLoad() {
    loadLevel('Level2.tmx');
    gameRef.add(hub);
    gameRef.playerData.score.value = 0;
    gameRef.playerData.health.value = 5;
    return super.onLoad();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }

  @override
  void onRemove() {
    gameRef.remove(hub);
    super.onRemove();
  }
}
