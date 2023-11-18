import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_nery_platform_demo/game/actors/coins.dart';
import 'package:flame_nery_platform_demo/game/actors/door.dart';
import 'package:flame_nery_platform_demo/game/actors/enemy.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/game/actors/platform.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

class Level extends Component with HasGameRef<SimplePlatformer> {
  final String levelName;
  late Player _player;
  late Rect _levelBounds;
  Level(this.levelName) : super();

  @override
  Future<void>? onLoad() async {
    final level = await TiledComponent.load(levelName, Vector2.all(32));
    add(level);
    _levelBounds = Rect.fromLTWH(
        0,
        0,
        (level.tileMap.map.width * level.tileMap.map.tileWidth).toDouble(),
        (level.tileMap.map.height * level.tileMap.map.tileHeight).toDouble());
    _spwanActors(level.tileMap);
    _setupCamera();
    return super.onLoad();
  }

  void _spwanActors(RenderableTiledMap level) {
    final platafomrsLayer = level.getLayer<ObjectGroup>('Platforms');
    for (final platformObject in platafomrsLayer!.objects) {
      final platform = Platform(
          position: Vector2(platformObject.x, platformObject.y),
          size: Vector2(platformObject.width, platformObject.height));
      add(platform);
    }
    final spawPointsLayer = level.getLayer<ObjectGroup>('SpawnPoints');

    for (final spwanPoint in spawPointsLayer!.objects) {
      final position = Vector2(spwanPoint.x, spwanPoint.y - spwanPoint.height);
      final size = Vector2(spwanPoint.width, spwanPoint.height);
      switch (spwanPoint.name) {
        case 'Player':
          _player = Player(gameRef.spriteSheet,
              anchor: Anchor.center,
              levelBounds: _levelBounds,
              position: position,
              size: size);
          add(_player);
          break;

        case 'Coin':
          final coin =
              Coins(gameRef.spriteSheet, position: position, size: size);
          add(coin);
          break;

        case 'Enemy':
          final targetObj = int.parse(spwanPoint.properties.first.value);
          final target = spawPointsLayer.objects
              .firstWhere((object) => object.id == targetObj);
          final enemy = Enemy(gameRef.spriteSheet,
              position: position,
              size: size,
              targetPosition: Vector2(target.x, target.y));
          add(enemy);
          break;

        case 'Door':
          spwanPoint.properties.first.value;
          final door = Door(gameRef.spriteSheet,
              position: Vector2(spwanPoint.x, spwanPoint.y),
              size: size, onPlayerEnter: () {
            gameRef.loadLevel(spwanPoint.properties.first.value);
          });
          add(door);
          break;
      }
    }
  }

  void _setupCamera() {
    gameRef.camera.followComponent(_player);
    gameRef.camera.worldBounds = _levelBounds;
  }
}
