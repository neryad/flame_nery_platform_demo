import 'package:flame/components.dart';
import 'package:flame_nery_platform_demo/game/actors/coins.dart';
import 'package:flame_nery_platform_demo/game/actors/door.dart';
import 'package:flame_nery_platform_demo/game/actors/enemy.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/game/actors/platform.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends Component with HasGameRef<SimplePlatformer> {
  final String levelName;

  Level(this.levelName) : super();

  @override
  Future<void>? onLoad() async {
    final level = await TiledComponent.load(levelName, Vector2.all(32));
    add(level);
    _spwanActors(level.tileMap);
    return super.onLoad();
  }

  void _spwanActors(RenderableTiledMap level) {
    final platafomrsLayer = level.getObjectGroupFromLayer('Platforms');
    for (final platformObject in platafomrsLayer.objects) {
      final platform = Platform(
          position: Vector2(platformObject.x, platformObject.y),
          size: Vector2(platformObject.width, platformObject.height));
      add(platform);
    }
    final spawPointsLayer = level.getObjectGroupFromLayer('SpawnPoints');

    for (final spwanPoint in spawPointsLayer.objects) {
      switch (spwanPoint.name) {
        case 'Player':
          final player = Player(gameRef.spriteSheet,
              position: Vector2(spwanPoint.x, spwanPoint.y),
              size: Vector2(spwanPoint.width, spwanPoint.height));
          add(player);
          break;

        case 'Coin':
          final coin = Coins(gameRef.spriteSheet,
              position: Vector2(spwanPoint.x, spwanPoint.y),
              size: Vector2(spwanPoint.width, spwanPoint.height));
          add(coin);
          break;

        case 'Enemy':
          final enemy = Enemy(gameRef.spriteSheet,
              position: Vector2(spwanPoint.x, spwanPoint.y),
              size: Vector2(spwanPoint.width, spwanPoint.height));
          add(enemy);
          break;

        case 'Door':
          final door = Door(gameRef.spriteSheet,
              position: Vector2(spwanPoint.x, spwanPoint.y),
              size: Vector2(spwanPoint.width, spwanPoint.height));
          add(door);
          break;
      }
    }
  }
}
